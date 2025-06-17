{{ config(
    materialized='table',
    database='DRUGS_NAME',
    schema='DRUGS_LISTINGS'
) }}

WITH reports_age AS(
    SELECT
      raw_json:patient_age::string AS patient_age,
      raw_json:patient_sex::string As patient_sex
      FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
)

SELECT patient_age,patient_sex,
   COUNT(*) AS Total_report_counts
   FROM reports_age
   GROUP BY patient_age,patient_sex
   ORDER BY COUNT(*) DESC
   