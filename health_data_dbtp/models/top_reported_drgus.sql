{{ config(
    database='DRUGS_NAME',
    schema='DRUGS_LISTINGS'
) }}

WITH top_drug AS (
    SELECT
        raw_json:report_id::string AS case_id,
        raw_json:DRUG_NAME::string AS drug_name
        FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
)

SELECT 
    drug_name, 
    COUNT(*) AS report_count 
FROM top_drug
GROUP BY drug_name
HAVING COUNT(*) > 10
ORDER BY report_count desc
