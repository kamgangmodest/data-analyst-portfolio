/*
SaaS Revenue & RevOps Analysis
Synthetic portfolio project
*/

-- Executive KPIs
SELECT
    SUM(CASE WHEN stage = 'Closed Won' THEN arr_value ELSE 0 END) AS closed_won_arr,
    SUM(CASE WHEN stage = 'Open' THEN arr_value ELSE 0 END) AS open_pipeline,
    CAST(
        SUM(CASE WHEN stage = 'Closed Won' THEN 1.0 ELSE 0 END) /
        NULLIF(SUM(CASE WHEN stage IN ('Closed Won','Closed Lost') THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS win_rate,
    AVG(CASE WHEN stage = 'Closed Won' THEN arr_value END) AS avg_deal_size,
    AVG(CASE WHEN stage = 'Closed Won' THEN sales_cycle_days END) AS avg_sales_cycle_days
FROM dbo.revops_deals;

-- Segment performance
SELECT
    segment,
    SUM(CASE WHEN stage='Closed Won' THEN arr_value ELSE 0 END) AS closed_won_arr,
    SUM(CASE WHEN stage='Open' THEN arr_value ELSE 0 END) AS open_pipeline,
    CAST(
        SUM(CASE WHEN stage='Closed Won' THEN 1.0 ELSE 0 END) /
        NULLIF(SUM(CASE WHEN stage IN ('Closed Won','Closed Lost') THEN 1.0 ELSE 0 END),0)
        AS decimal(10,4)
    ) AS win_rate
FROM dbo.revops_deals
GROUP BY segment
ORDER BY closed_won_arr DESC;

-- Source efficiency
SELECT
    source,
    COUNT(*) AS deals,
    SUM(CASE WHEN stage='Closed Won' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN stage='Closed Won' THEN arr_value ELSE 0 END) AS closed_won_arr
FROM dbo.revops_deals
GROUP BY source
ORDER BY closed_won_arr DESC;

-- Rep ranking
WITH rep_perf AS (
    SELECT
        account_executive,
        SUM(CASE WHEN stage='Closed Won' THEN arr_value ELSE 0 END) AS closed_won_arr,
        SUM(CASE WHEN stage='Open' THEN arr_value ELSE 0 END) AS pipeline
    FROM dbo.revops_deals
    GROUP BY account_executive
)
SELECT
    account_executive,
    closed_won_arr,
    pipeline,
    DENSE_RANK() OVER (ORDER BY closed_won_arr DESC) AS revenue_rank
FROM rep_perf
ORDER BY revenue_rank;
