{{ config(
    materialized='table',
    database='DRUGS_NAME',
    schema='DRUG_LISTINGS'
) }}

SELECT
    raw_json:drug_name::string AS drug_name,
    COUNT(*) AS total_reports,
    COUNT_IF(raw_json:serious_case::string = 'Yes') AS serious_cases,
    COUNT_IF(raw_json:result_in_death::string = 'Yes') AS deaths,
    ROUND(COUNT_IF(raw_json:serious_case::string = 'Yes') * 100.0 / COUNT(*), 2) AS serious_pct,
    ROUND(COUNT_IF(raw_json:result_in_death::string = 'Yes') * 100.0 / COUNT(*), 2) AS death_pct
FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
WHERE raw_json:drug_name IS NOT NULL
GROUP BY raw_json:drug_name::string
ORDER BY total_reports DESC
