# Operations KPI Dashboard

![Operations KPI Dashboard](dashboard/operations_kpi_dashboard.svg)

## Project Overview
This end-to-end portfolio project demonstrates how I would help operations leadership monitor **workload, throughput, backlog, SLA performance, aging, productivity, and quality indicators**.

The dataset is fully **synthetic** and contains **1,000 operational work items** across four teams and twelve analysts.

## Business Problem
Leadership does not only need to know whether the monthly SLA was met. They need early warning signals showing **where performance is starting to break down before month-end**.

This dashboard answers:
- How much work is being received and completed?
- Is backlog growing?
- Which teams are at risk of missing SLA?
- How old is open work?
- Are reopen and exception rates signaling quality problems?
- Which analysts and teams are carrying the greatest workload?

## Tools & Skills Demonstrated
**SQL Server • T-SQL • Power BI / Tableau Concepts • DAX • Window Functions • CTEs • KPI Development • SLA Analysis • Root-Cause Analysis • Operational Reporting**

## Executive KPIs
| KPI | Result |
|---|---:|
| Received | **1,000** |
| Completed | **913** |
| Open Backlog | **87** |
| On-Time Completion | **87.4%** |
| Average Closure Time | **31.3 hours** |
| Reopen Rate | **6.2%** |
| Exception Rate | **8.2%** |

## Dashboard Design

### Executive Overview
- Received
- Completed
- Open backlog
- On-time %
- Reopen rate

### Leading Indicators
- Average closure time
- Exception rate
- Team SLA risk
- Backlog aging

### Operational Drilldowns
- Team performance
- Priority performance
- Analyst productivity
- Past-due open work
- Reopen and exception trends

## SQL Analysis Included
The SQL folder demonstrates:
1. Executive KPI calculations
2. Team scorecards
3. Monthly received vs completed
4. Backlog aging
5. SLA risk by priority/team
6. Analyst ranking with `DENSE_RANK()`
7. Reopen and exception indicators
8. Past-due work identification

## Key Findings
- Overall on-time completion is **87.4%**.
- **West** is the lowest-performing SLA team at **81.3%**.
- The year-end open backlog is **87** work items.
- **86** open items are 15+ days old.
- Reopen rate is **6.2%**, making quality a useful leading indicator alongside throughput.

[Read the full business insights and recommendations](analysis/business_insights.md)

## Repository Structure
```
operations-kpi-dashboard/
├── data/
│   └── operational_tickets.csv
├── sql/
│   ├── schema.sql
│   └── kpi_queries.sql
├── analysis/
│   └── business_insights.md
├── dashboard/
│   └── operations_kpi_dashboard.svg
├── dax_measures.md
├── data_dictionary.md
└── README.md
```

## Privacy
All data in this project is synthetic. No employer, customer, patient, or proprietary data is included.
