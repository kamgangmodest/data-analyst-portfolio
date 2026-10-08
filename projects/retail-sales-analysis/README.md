# Retail Sales & Inventory Performance

![Retail dashboard preview](dashboard/retail_dashboard.svg)

## Project Overview
This end-to-end portfolio project demonstrates how I would analyze retail sales and inventory performance for leadership using **SQL and Power BI-style business intelligence techniques**.

The dataset is fully **synthetic** and contains **520 sales transactions** across four locations, twelve products, and four product categories.

## Business Problem
Leadership needs one view that answers:
- Which stores and products are driving revenue?
- Are high sales translating into healthy gross profit?
- Which categories are growing or underperforming?
- Where are inventory levels creating stockout risk?
- What should management act on first?

## Tools & Skills Demonstrated
**SQL Server • T-SQL • Window Functions • CTEs • KPI Development • Data Modeling • Power BI Dashboard Design • Business Analysis**

## Executive KPIs
| KPI | Result |
|---|---:|
| Revenue | $140,051 |
| Gross Profit | $61,518 |
| Gross Margin | 43.9% |
| Units Sold | 1,655 |
| Top Store | Washington DC |
| Top Category | Office |
| Top Product | Standing Desk |

## Data Model
The portfolio version uses a flat synthetic transaction file for easy review. In production, I would model this as a star schema with:
- **FactSales**
- **DimDate**
- **DimProduct**
- **DimStore**

## Analysis Performed
- Executive revenue and profit KPIs
- Monthly revenue and profit trends
- Store performance ranking
- Product and category performance
- Gross-margin analysis
- Low-stock and reorder-risk identification
- Window-function logic for latest inventory state

## Key Findings
- **Washington DC** generated the highest store revenue at **$38,866**.
- **Office** was the leading category with **$71,874** in revenue.
- **Standing Desk** was the strongest product by revenue.
- Overall gross margin was **43.9%**.
- The data contains **114** transaction records where inventory was at or below reorder level, highlighting the need for proactive replenishment.

## Business Recommendations
1. Protect top-selling products from stockouts using reorder alerts.
2. Compare product mix across stores to identify why some locations outperform others.
3. Monitor discounting together with gross margin rather than focusing only on revenue.
4. Use product/store drilldowns to prioritize inventory replenishment.
5. Track monthly category performance to identify changes in demand early.

## Repository Structure
- `data/retail_sales.csv` — synthetic source data
- `sql/schema.sql` — SQL Server table definition
- `sql/analysis.sql` — KPI, trend, ranking, and inventory queries
- `analysis/business_insights.md` — executive findings and recommendations
- `dashboard/retail_dashboard.svg` — dashboard preview

## Privacy
No employer, customer, or patient data is used in this project.
