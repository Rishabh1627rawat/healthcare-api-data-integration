{{ config(
    materialized='table',
    database='DRUGS_NAME',
    schema='DRUG_LISTINGS'
) }}

WITH total_reports AS (
    SELECT
        raw_json:drug_name::string AS drug_name,
        COUNT(*) AS total_count
    FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
    GROUP BY drug_name
),

death_reports AS (
    SELECT
        raw_json:drug_name::string AS drug_name,
        COUNT(*) AS death_count
    FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA
    WHERE raw_json:result_in_death::string = 'Yes'
    GROUP BY drug_name
)

SELECT
    t.drug_name,
    t.total_count,
    COALESCE(d.death_count, 0) AS death_count,
    ROUND(COALESCE(d.death_count, 0) * 100.0 / t.total_count, 2) AS mortality_rate_percent
FROM total_reports t
LEFT JOIN death_reports d
    ON t.drug_name = d.drug_name
ORDER BY mortality_rate_percent DESC
