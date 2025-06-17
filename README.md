# 🩺 Health Integration Project with Snowflake & dbt

This project focuses on integrating, processing, and modeling healthcare-related data—specifically FDA drug reports—using **Snowflake** for scalable storage, **Python** for automation, and **dbt** for transformation logic and data modeling.

---

## ✅ Project Goals

- Ingest and store FDA drug data in CSV and JSON (NDJSON) formats.
- Automate the data pipeline using Python and Snowflake connectors.
- Transform and model data with **dbt** (data build tool).
- Build a modular, cloud-based data stack for healthcare analytics.

---

## 📁 Folder Structure

health-integration-project/
├── data/
│ └── processed/
│ ├── fda_cleaned.csv # Cleaned CSV data
│ └── fda.json # Raw FDA report JSON (NDJSON)
├── dbt_project/
│ ├── models/
│ │ ├── staging/ # Staging layer models
│ │ ├── marts/ # Analytics-ready models
│ │ └── sources/ # Source definitions
│ ├── dbt_project.yml # dbt config
│ └── snapshots/ # Future snapshots
├── pipeline.py # Python script to automate ingestion
└── README.md # Project documentation

markdown
Copy
Edit

---

## 🔧 Technologies Used

- **Snowflake** – Cloud Data Warehouse for storage & analytics
- **Python** – Automation with `snowflake-connector-python`
- **SnowSQL** – CLI tool to upload local files to Snowflake stages
- **dbt (data build tool)** – SQL-based transformation and modeling framework
- **File Formats** – CSV, JSON (NDJSON), VARIANT for semi-structured data

---

## 📥 Data Loading Progress

### ✅ CSV Upload to Snowflake

- **Stage Created:** `@drug_stage`
- **File Uploaded:** `fda_cleaned.csv`
- **Table Created:** `drug_listing_fda`
- **Data Loaded With:**
  ```sql
  COPY INTO drug_listing_fda
  FROM @drug_stage/fda_cleaned.csv.gz
  FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
✅ JSON Upload to Snowflake (Using VARIANT)
Table Created:

sql
Copy
Edit
CREATE OR REPLACE TABLE json_data_fda (
  raw_json VARIANT
);
File Format: Newline-delimited JSON (NDJSON)

Loaded using COPY INTO after uploading via PUT

🛠 Python Automation (pipeline.py)
Connects to Snowflake using snowflake-connector-python

Automates file upload and loading into respective tables

Handles logging of success/failure

Validates data file structure before ingestion

🧠 dbt Work
✅ Initialized dbt project: dbt init health_integration_dbt

✅ Configured Snowflake connection via profiles.yml

✅ Added source definition in sources.yml

✅ Created staging model: stg_drug_listing_fda.sql

sql
Copy
Edit
SELECT
  report_id,
  report_date::DATE AS report_date,
  country,
  drug_name,
  patient_age::INT AS patient_age,
  patient_sex,
  side_effects
FROM {{ source('raw', 'drug_listing_fda') }}
🔜 Next Steps
 Build marts/ models for analytical insights (e.g., side effects by region)

 Define tests and documentation in schema.yml

 Implement snapshots to track changes over time

 Schedule dbt jobs using Airflow or dbt Cloud

 Visualize results using Tableau or Power BI

 Enrich data with external drug metadata

❗ Tips & Notes
NDJSON Format: Ensure each JSON record is on a new line before ingestion.

File Removal (if needed):

sql
Copy
Edit
REMOVE @drug_stage/fda_cleaned.csv.gz;
Monitor pipeline.py logs for ingestion issues or schema mismatches.

🙋 Author
Rishabh Rawat
Passionate about real-world healthcare data engineering using Snowflake, Python, and dbt.
Always learning. Always building. 🚀
Build a reliable, automated integration system for multi-source healthcare data.
