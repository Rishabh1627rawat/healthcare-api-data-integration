{{ config(
    database='DRUGS_NAME',
    schema='DRUG_LISTINGS'
) }}

WITH patient AS (
    SELECT 
        raw_json:report_id::string AS case_id,
        raw_json:report_date::date AS report_date,
        raw_json:country::string AS country
    FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
)

SELECT * FROM patient
