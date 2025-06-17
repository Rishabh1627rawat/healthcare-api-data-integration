{{ config(
    materialized='table',
    database='DRUGS_NAME',
    schema='DRUG_LISTINGS'
) }}

WITH flattened AS (
    SELECT
        TRIM(side_effect.value::string) AS common_side_effect
     FROM DRUGS_NAME.DRUG_LISTINGS.JSON_DATA_FDA AS j,
         LATERAL FLATTEN(input => SPLIT(j.raw_json:side_effects::string, ','))
         AS side_effect
)

SELECT
    common_side_effect,
    COUNT(*) AS top_side_effect
FROM flattened
GROUP BY common_side_effect
ORDER BY top_side_effect DESC
