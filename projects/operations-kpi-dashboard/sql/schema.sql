-- SQL Server schema for the synthetic Operations KPI portfolio dataset
CREATE TABLE dbo.operational_tickets (
    ticket_id        varchar(20)   NOT NULL,
    received_at      datetime2     NOT NULL,
    due_at           datetime2     NOT NULL,
    completed_at     datetime2     NULL,
    status           varchar(20)   NOT NULL,
    priority         varchar(20)   NOT NULL,
    team             varchar(50)   NOT NULL,
    analyst          varchar(100)  NOT NULL,
    category         varchar(50)   NOT NULL,
    channel          varchar(30)   NOT NULL,
    reopened_flag    bit           NOT NULL,
    exception_flag   bit           NOT NULL
);