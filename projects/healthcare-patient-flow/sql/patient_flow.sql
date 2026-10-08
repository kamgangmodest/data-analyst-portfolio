SELECT
    CAST(admit_datetime AS DATE) AS admit_date,
    unit_name,
    COUNT(*) AS admissions,
    AVG(DATEDIFF(HOUR, admit_datetime, discharge_datetime) / 24.0) AS avg_length_of_stay_days
FROM encounters
WHERE encounter_type = 'Inpatient'
GROUP BY
    CAST(admit_datetime AS DATE),
    unit_name;