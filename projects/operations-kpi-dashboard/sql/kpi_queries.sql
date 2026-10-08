WITH base AS (
    SELECT ticket_id, team, received_at, completed_at, due_at, status,
           CASE WHEN completed_at <= due_at THEN 1 ELSE 0 END AS on_time_flag
    FROM operational_tickets
)
SELECT
    team,
    COUNT(*) AS received,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status <> 'Completed' THEN 1 ELSE 0 END) AS open_backlog,
    AVG(CAST(on_time_flag AS DECIMAL(10,4))) AS on_time_rate
FROM base
GROUP BY team;