🩺 HealthCare Data Integration & Analytics Pipeline
This project is an end-to-end data integration and analytics pipeline for healthcare data. It processes real-world FDA drug reports, automates ingestion using Python, models the data with dbt, and stores it in Snowflake for scalable analytics. The goal is to simulate how healthcare platforms can clean, organize, and gain insights from complex, semi-structured medical data in an automated fashion.

📌 Problem Statement
In the healthcare domain, regulatory data like FDA reports is often messy, semi-structured (JSON), and underutilized. Stakeholders—including researchers, public health analysts, and pharma companies—struggle to derive meaningful insights due to:

Inconsistent data formats (CSV, JSON)

Complex nested structures

No change tracking over time

Lack of modular pipelines to manage ingestion, transformation, and analytics

🎯 Goal
Build a reliable healthcare data pipeline that:

Ingests FDA drug reports in JSON and CSV formats

Stores and manages structured + semi-structured data in Snowflake

Transforms raw data into analytics-ready tables using dbt

Tracks data changes and enriches insights for healthcare decision-makers

📌 Project Architecture
Data source: FDA adverse event drug report datasets

Local data cleaning and format conversion (CSV & NDJSON)

Python pipeline for automation and Snowflake ingestion

Data modeling using dbt (source → staging → marts)

Future extensions: snapshots, enrichment, and dashboarding

🔍 What Business Problems This Solves
❌ Problem	✅ Solution
Unstructured FDA data (JSON, CSV)	Python preprocessing + NDJSON formatting
No central store for drug reports	Snowflake-based warehousing (structured + VARIANT support)
Difficulty analyzing side effects by drug/region	dbt models with filters, joins, and regional aggregations
No version control of reports	Plan for dbt Snapshots to track changes
Manual ingestion and loading	Python automation using Snowflake Connector

🧠 Technologies Used
Area	Tool/Tech
Data Ingestion	Python (snowflake-connector-python)
Storage	Snowflake
Modeling	dbt
File Formats	CSV, JSON (NDJSON), VARIANT
CLI Tools	SnowSQL
Automation	Python scripts
Visualization (Planned)	Tableau / Power BI

📊 Core Features / Models
Model/File Name	Purpose
drug_listing_fda	Main table for structured CSV report data
json_data_fda	Table for storing raw NDJSON using VARIANT
stg_drug_listing_fda.sql	dbt staging model: cleaned & typed version of the raw data
marts/ (planned)	Business insights: side effects by drug/region
snapshots/ (planned)	Historical tracking of drug safety reports

📥 Data Loading Progress
✅ CSV Upload to Snowflake

Stage Created: @drug_stage

File Format: CSV with headers

Table: drug_listing_fda

Load Command:

sql
Copy
Edit
COPY INTO drug_listing_fda
FROM @drug_stage/fda_cleaned.csv.gz
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
✅ NDJSON Upload to Snowflake

Table Created:

sql
Copy
Edit
CREATE OR REPLACE TABLE json_data_fda (
  raw_json VARIANT
);
File Format: NDJSON (1 JSON object per line)

Loaded using:

sql
Copy
Edit
COPY INTO json_data_fda
FROM @drug_stage/fda.json
FILE_FORMAT = (TYPE = 'JSON');
🛠 Python Automation (pipeline.py)
Feature	Description
🔗 Snowflake Connector	Uses snowflake-connector-python for ingestion
🗃 File Validation	Checks schema and format before upload
🚀 Upload & Load Automation	Automates PUT & COPY INTO Snowflake stage
🧾 Logging	Logs success/failure and errors for each run

🔧 dbt Work
✅ Project Setup

Initialized using: dbt init health_integration_dbt

Configured Snowflake connection in profiles.yml

✅ Source Definitions

Defined in: sources.yml

Example:

yaml
Copy
Edit
sources:
  - name: raw
    database: HEALTHCARE
    schema: DRUG_LISTINGS
    tables:
      - name: drug_listing_fda
✅ Staging Model: stg_drug_listing_fda.sql

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

Create marts models for:

Side effects by drug

Report count by region/time

Add schema tests and documentation

Build snapshots to track updates over time

Integrate dbt Cloud or Airflow for scheduling

📂 Folder Structure
bash
Copy
Edit
health-integration-project/
│
├── data/
│   └── processed/
│       ├── fda_cleaned.csv         # Cleaned CSV data
│       └── fda.json                # NDJSON-formatted JSON reports
│
├── dbt_project/
│   ├── models/
│   │   ├── sources/
│   │   ├── staging/
│   │   └── marts/                  # Future models
│   ├── snapshots/                  # Future snapshots
│   └── dbt_project.yml
│
├── pipeline.py                     # Python ingestion & upload script
└── README.md                       # Project documentation
✅ Project Timeline & Progress
Week	Focus Area	Status
1	CSV/JSON Ingestion + Snowflake Upload	✅ Completed
2	Python Pipeline & Automation	✅ Completed
3	dbt Staging + Source Models	✅ In Progress
4	dbt Marts + Snapshots + Dashboarding	⏳ Upcoming
5	Airflow Scheduling + Visual Demos	❌ Not Started

📸 Screenshots & Demo (Coming Soon)
Dashboard screenshots and model preview snapshots will be shared once the marts and visualization layers are finalized.

👨‍💻 Author
Rishabh Rawat – Passionate about real-world healthcare data engineering using Snowflake, Python, and dbt.

GitHub: github.com/Rishabh1627rawat

LinkedIn: (Add your profile link)
