/*
Healthcare Patient Flow Analysis
Synthetic portfolio project
SQL Server / T-SQL
*/

-- 1. Executive KPIs
SELECT
    COUNT(*) AS admissions,
    COUNT(*) AS discharges,
    AVG(length_of_stay_days) AS avg_length_of_stay_days,
    CAST(SUM(CASE WHEN readmit_30d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) AS decimal(10,4)) AS readmission_rate
FROM dbo.patient_encounters;


-- 2. Monthly admissions and discharges
WITH admissions AS (
    SELECT
        DATEFROMPARTS(YEAR(admit_datetime),MONTH(admit_datetime),1) AS month_start,
        COUNT(*) AS admissions
    FROM dbo.patient_encounters
    GROUP BY DATEFROMPARTS(YEAR(admit_datetime),MONTH(admit_datetime),1)
),
discharges AS (
    SELECT
        DATEFROMPARTS(YEAR(discharge_datetime),MONTH(discharge_datetime),1) AS month_start,
        COUNT(*) AS discharges
    FROM dbo.patient_encounters
    GROUP BY DATEFROMPARTS(YEAR(discharge_datetime),MONTH(discharge_datetime),1)
)
SELECT
    COALESCE(a.month_start,d.month_start) AS month_start,
    ISNULL(a.admissions,0) AS admissions,
    ISNULL(d.discharges,0) AS discharges
FROM admissions a
FULL OUTER JOIN discharges d
    ON a.month_start = d.month_start
ORDER BY month_start;


-- 3. Unit performance
SELECT
    unit_name,
    COUNT(*) AS admissions,
    AVG(length_of_stay_days) AS avg_los_days,
    CAST(SUM(CASE WHEN readmit_30d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) AS decimal(10,4)) AS readmission_rate
FROM dbo.patient_encounters
GROUP BY unit_name
ORDER BY admissions DESC;


-- 4. Approximate annual bed occupancy
SELECT
    unit_name,
    MAX(bed_capacity) AS bed_capacity,
    SUM(length_of_stay_days) AS patient_days,
    CAST(
        SUM(length_of_stay_days) / (MAX(bed_capacity) * 365.0)
        AS decimal(10,4)
    ) AS occupancy_rate
FROM dbo.patient_encounters
GROUP BY unit_name
ORDER BY occupancy_rate DESC;


-- 5. Admission source analysis
SELECT
    admission_source,
    COUNT(*) AS admissions,
    AVG(length_of_stay_days) AS avg_los_days,
    CAST(SUM(CASE WHEN readmit_30d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) AS decimal(10,4)) AS readmission_rate
FROM dbo.patient_encounters
GROUP BY admission_source
ORDER BY admissions DESC;


-- 6. Payer mix
SELECT
    payer,
    COUNT(*) AS admissions,
    CAST(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS decimal(10,4)) AS payer_mix_pct
FROM dbo.patient_encounters
GROUP BY payer
ORDER BY admissions DESC;


-- 7. Discharge disposition
SELECT
    discharge_disposition,
    COUNT(*) AS discharges,
    AVG(length_of_stay_days) AS avg_los_days
FROM dbo.patient_encounters
GROUP BY discharge_disposition
ORDER BY discharges DESC;


-- 8. High-utilization / long-stay exceptions
SELECT
    encounter_id,
    patient_id,
    unit_name,
    admit_datetime,
    discharge_datetime,
    length_of_stay_days,
    readmit_30d
FROM dbo.patient_encounters
WHERE length_of_stay_days >= 7
   OR readmit_30d = 1
ORDER BY length_of_stay_days DESC;
