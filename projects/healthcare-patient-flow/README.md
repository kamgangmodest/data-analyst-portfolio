# Healthcare Patient Flow Analysis

![Healthcare Patient Flow Dashboard](dashboard/patient_flow_dashboard.svg)

## Project Overview
This end-to-end project demonstrates **SQL and Power BI-style healthcare operations analytics** using synthetic inpatient encounter data.

The dataset contains **2,200 synthetic encounters** across six hospital units.

## Business Questions
- Are admissions outpacing discharges?
- Which units are experiencing the most capacity pressure?
- Where is length of stay highest?
- Which units show elevated readmission rates?
- How can leadership identify patient-flow bottlenecks earlier?

## Tools & Skills Demonstrated
**SQL Server • T-SQL • CTEs • Healthcare Operations Analytics • KPI Development • Bed Occupancy • Length of Stay • Readmissions • Power BI Concepts • Executive Reporting**

## Executive KPIs
| KPI | Result |
|---|---:|
| Admissions | **2,200** |
| Discharges | **2,200** |
| Average LOS | **4.6 days** |
| 30-Day Readmission Rate | **4.0%** |
| Average Unit Occupancy | **11.6%** |

## Analysis Performed
- Monthly admissions vs discharges
- Average LOS by unit
- Estimated occupancy by unit
- 30-day readmission rate by unit
- Admission-source analysis
- Payer mix
- Discharge-disposition analysis
- Long-stay / high-utilization exception identification

## Key Findings
- **ICU** has the highest estimated occupancy.
- **ICU** has the longest average LOS.
- **Cardiology** has the highest readmission rate.
- ED admissions represent the largest intake pathway.
- Long-stay cases and readmissions both contribute to capacity pressure.

[Read the full business insights](analysis/business_insights.md)

## Repository Structure
- `data/patient_encounters.csv` — synthetic encounter data
- `sql/schema.sql` — SQL Server schema
- `sql/patient_flow.sql` — patient-flow analysis
- `analysis/business_insights.md` — findings and recommendations
- `dashboard/patient_flow_dashboard.svg` — dashboard preview
- `dax_measures.md` — suggested BI measures
- `data_dictionary.md` — field definitions

## Privacy
This project uses synthetic data only. No PHI, employer data, or proprietary healthcare schemas are included.
