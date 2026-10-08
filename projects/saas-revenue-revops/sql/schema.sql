CREATE TABLE dbo.revops_deals (
    deal_id varchar(20) NOT NULL,
    created_date date NOT NULL,
    close_date date NULL,
    segment varchar(30) NOT NULL,
    source varchar(30) NOT NULL,
    account_executive varchar(50) NOT NULL,
    stage varchar(20) NOT NULL,
    arr_value decimal(12,2) NOT NULL,
    sales_cycle_days int NOT NULL,
    discount_pct decimal(5,2) NOT NULL
);