# Suggested Power BI Measures

```DAX
Admissions =
DISTINCTCOUNT('Patient Encounters'[encounter_id])

Discharges =
CALCULATE(
    DISTINCTCOUNT('Patient Encounters'[encounter_id]),
    NOT ISBLANK('Patient Encounters'[discharge_datetime])
)

Average LOS =
AVERAGE('Patient Encounters'[length_of_stay_days])

Readmissions =
CALCULATE(
    [Admissions],
    'Patient Encounters'[readmit_30d] = 1
)

Readmission Rate =
DIVIDE([Readmissions], [Admissions], 0)

Patient Days =
SUM('Patient Encounters'[length_of_stay_days])

Bed Capacity =
MAX('Patient Encounters'[bed_capacity])

Occupancy Rate =
DIVIDE(
    [Patient Days],
    [Bed Capacity] * 365,
    0
)
```
