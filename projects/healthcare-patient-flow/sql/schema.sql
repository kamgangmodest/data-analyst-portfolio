-- SQL Server schema for synthetic healthcare patient-flow data
CREATE TABLE dbo.patient_encounters (
    encounter_id            varchar(20)   NOT NULL,
    patient_id              varchar(20)   NOT NULL,
    admit_datetime          datetime2     NOT NULL,
    discharge_datetime      datetime2     NOT NULL,
    unit_name               varchar(50)   NOT NULL,
    bed_capacity            int           NOT NULL,
    admission_source        varchar(50)   NOT NULL,
    payer                    varchar(30)   NOT NULL,
    age                      int           NOT NULL,
    length_of_stay_days     decimal(10,2) NOT NULL,
    readmit_30d             bit           NOT NULL,
    discharge_disposition   varchar(50)   NOT NULL
);