# Business Insights & Recommendations

This project uses fully synthetic healthcare data.

## Executive Summary
- Admissions: **2,200**
- Discharges: **2,200**
- Average Length of Stay: **4.6 days**
- 30-Day Readmission Rate: **4.0%**
- Average Unit Occupancy: **11.6%**

## Key Findings
1. **ICU** has the highest estimated occupancy at **20.0%**, creating the greatest capacity pressure.
2. **ICU** has the longest average LOS at **7.0 days**.
3. **Cardiology** has the highest readmission rate at **5.2%**.
4. Emergency Department admissions represent the largest intake source and should be monitored against downstream bed capacity.
5. Long-stay encounters and readmissions should be reviewed together because both contribute to avoidable capacity pressure.

## Recommended Actions
- Create an occupancy threshold alert for units above 85%.
- Add a daily list of encounters approaching 5+ days LOS.
- Review readmissions by unit, payer, and discharge disposition.
- Compare admissions vs discharges daily to identify growing census pressure.
- Use discharge-disposition trends to anticipate placement delays.
