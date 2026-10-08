/*
Operations KPI Dashboard
Synthetic portfolio project
SQL Server / T-SQL
*/

DECLARE @SnapshotDate datetime2 = '2026-01-01 00:00:00';

-- 1. Executive KPI summary
SELECT
    COUNT(*) AS received,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status <> 'Completed' THEN 1 ELSE 0 END) AS open_backlog,
    CAST(
        SUM(CASE WHEN status = 'Completed' AND completed_at <= due_at THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN status = 'Completed' THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS on_time_rate,
    AVG(CASE WHEN status = 'Completed'
        THEN DATEDIFF(MINUTE,received_at,completed_at)/60.0 END) AS avg_closure_hours
FROM dbo.operational_tickets;


-- 2. Team scorecard
SELECT
    team,
    COUNT(*) AS received,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status <> 'Completed' THEN 1 ELSE 0 END) AS open_backlog,
    CAST(
        SUM(CASE WHEN status = 'Completed' AND completed_at <= due_at THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN status = 'Completed' THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS on_time_rate,
    CAST(
        SUM(CASE WHEN reopened_flag = 1 THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN status = 'Completed' THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS reopen_rate
FROM dbo.operational_tickets
GROUP BY team
ORDER BY on_time_rate DESC;


-- 3. Monthly received vs completed
SELECT
    DATEFROMPARTS(YEAR(received_at),MONTH(received_at),1) AS month_start,
    COUNT(*) AS received,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed
FROM dbo.operational_tickets
GROUP BY DATEFROMPARTS(YEAR(received_at),MONTH(received_at),1)
ORDER BY month_start;


-- 4. Backlog aging
WITH open_work AS (
    SELECT
        ticket_id,
        team,
        priority,
        received_at,
        DATEDIFF(DAY,received_at,@SnapshotDate) AS age_days
    FROM dbo.operational_tickets
    WHERE status <> 'Completed'
)
SELECT
    CASE
        WHEN age_days <= 2 THEN '0-2 Days'
        WHEN age_days <= 7 THEN '3-7 Days'
        WHEN age_days <= 14 THEN '8-14 Days'
        ELSE '15+ Days'
    END AS aging_bucket,
    COUNT(*) AS open_tickets
FROM open_work
GROUP BY
    CASE
        WHEN age_days <= 2 THEN '0-2 Days'
        WHEN age_days <= 7 THEN '3-7 Days'
        WHEN age_days <= 14 THEN '8-14 Days'
        ELSE '15+ Days'
    END
ORDER BY MIN(age_days);


-- 5. SLA risk by priority and team
SELECT
    team,
    priority,
    COUNT(*) AS completed,
    SUM(CASE WHEN completed_at <= due_at THEN 1 ELSE 0 END) AS on_time,
    CAST(
        SUM(CASE WHEN completed_at <= due_at THEN 1.0 ELSE 0 END)
        / NULLIF(COUNT(*),0)
        AS decimal(10,4)
    ) AS on_time_rate
FROM dbo.operational_tickets
WHERE status = 'Completed'
GROUP BY team, priority
ORDER BY on_time_rate, team, priority;


-- 6. Analyst productivity using window ranking
WITH analyst_perf AS (
    SELECT
        team,
        analyst,
        COUNT(*) AS assigned_work,
        SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
        SUM(CASE WHEN status = 'Completed' AND completed_at <= due_at THEN 1 ELSE 0 END) AS on_time
    FROM dbo.operational_tickets
    GROUP BY team, analyst
)
SELECT
    team,
    analyst,
    assigned_work,
    completed,
    on_time,
    DENSE_RANK() OVER (
        PARTITION BY team
        ORDER BY completed DESC
    ) AS productivity_rank
FROM analyst_perf
ORDER BY team, productivity_rank, analyst;


-- 7. Leading indicators: reopen and exception rates
SELECT
    team,
    CAST(
        SUM(CASE WHEN reopened_flag = 1 THEN 1.0 ELSE 0 END)
        / NULLIF(SUM(CASE WHEN status = 'Completed' THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS reopen_rate,
    CAST(
        SUM(CASE WHEN exception_flag = 1 THEN 1.0 ELSE 0 END)
        / NULLIF(COUNT(*),0)
        AS decimal(10,4)
    ) AS exception_rate
FROM dbo.operational_tickets
GROUP BY team
ORDER BY reopen_rate DESC;


-- 8. Open tickets already past due
SELECT
    ticket_id,
    team,
    analyst,
    priority,
    received_at,
    due_at,
    DATEDIFF(HOUR,due_at,@SnapshotDate) AS hours_past_due
FROM dbo.operational_tickets
WHERE status <> 'Completed'
  AND due_at < @SnapshotDate
ORDER BY hours_past_due DESC;
