-- SQL Server schema for the synthetic retail portfolio dataset
CREATE TABLE dbo.retail_sales (
    order_id            varchar(20)   NOT NULL,
    sale_date           date          NOT NULL,
    store               varchar(100)  NOT NULL,
    region              varchar(100)  NOT NULL,
    product_id          varchar(20)   NOT NULL,
    product_name        varchar(100)  NOT NULL,
    category            varchar(50)   NOT NULL,
    quantity            int           NOT NULL,
    unit_price          decimal(10,2) NOT NULL,
    unit_cost           decimal(10,2) NOT NULL,
    discount_pct        decimal(5,2)  NOT NULL,
    inventory_on_hand   int           NOT NULL,
    reorder_level       int           NOT NULL
);