-- Retail Sales & Inventory Analysis
SELECT
    DATEFROMPARTS(YEAR(s.sale_date), MONTH(s.sale_date), 1) AS month_start,
    s.region,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.quantity * s.unit_price) AS revenue,
    SUM((s.unit_price - s.unit_cost) * s.quantity) AS gross_profit
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY
    DATEFROMPARTS(YEAR(s.sale_date), MONTH(s.sale_date), 1),
    s.region,
    p.category;