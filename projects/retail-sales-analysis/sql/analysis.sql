-- Retail Sales & Inventory Performance
-- Synthetic portfolio project

-- 1. Executive KPIs
SELECT
    SUM(quantity) AS units_sold,
    SUM(quantity * unit_price * (1 - discount_pct)) AS revenue,
    SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost)) AS gross_profit,
    CAST(
        SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost))
        / NULLIF(SUM(quantity * unit_price * (1 - discount_pct)),0)
        AS decimal(10,4)
    ) AS gross_margin
FROM dbo.retail_sales;

-- 2. Monthly trend
SELECT
    DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1) AS month_start,
    SUM(quantity * unit_price * (1 - discount_pct)) AS revenue,
    SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost)) AS gross_profit
FROM dbo.retail_sales
GROUP BY DATEFROMPARTS(YEAR(sale_date),MONTH(sale_date),1)
ORDER BY month_start;

-- 3. Store ranking
SELECT
    store,
    region,
    SUM(quantity * unit_price * (1 - discount_pct)) AS revenue,
    SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost)) AS gross_profit,
    DENSE_RANK() OVER (
        ORDER BY SUM(quantity * unit_price * (1 - discount_pct)) DESC
    ) AS revenue_rank
FROM dbo.retail_sales
GROUP BY store, region
ORDER BY revenue DESC;

-- 4. Product performance
SELECT
    product_name,
    category,
    SUM(quantity) AS units_sold,
    SUM(quantity * unit_price * (1 - discount_pct)) AS revenue,
    SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost)) AS gross_profit
FROM dbo.retail_sales
GROUP BY product_name, category
ORDER BY revenue DESC;

-- 5. Inventory risk
WITH latest_inventory AS (
    SELECT
        product_id,
        product_name,
        store,
        inventory_on_hand,
        reorder_level,
        ROW_NUMBER() OVER (
            PARTITION BY product_id, store
            ORDER BY sale_date DESC, order_id DESC
        ) AS rn
    FROM dbo.retail_sales
)
SELECT
    product_id,
    product_name,
    store,
    inventory_on_hand,
    reorder_level,
    reorder_level - inventory_on_hand AS units_below_reorder
FROM latest_inventory
WHERE rn = 1
  AND inventory_on_hand <= reorder_level
ORDER BY units_below_reorder DESC;

-- 6. Category margin
SELECT
    category,
    SUM(quantity * unit_price * (1 - discount_pct)) AS revenue,
    SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost)) AS gross_profit,
    CAST(
        SUM((quantity * unit_price * (1 - discount_pct)) - (quantity * unit_cost))
        / NULLIF(SUM(quantity * unit_price * (1 - discount_pct)),0)
        AS decimal(10,4)
    ) AS gross_margin
FROM dbo.retail_sales
GROUP BY category
ORDER BY revenue DESC;