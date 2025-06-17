import snowflake.connector
import os 

conn = snowflake.connector.connect(
   user="RISHABH16RAWAT",
   password='bC0zzssz@161717',
   account='HVUGDJG-NM17550',
   database='DRUGS_NAME',
   schema='DRUG_LISTINGS'

)
    

print("✅ Connected to Snowflake!")   



cursor = conn.cursor()

file_path= "C:/Users/nikhi/Desktop/health-integration-project/data/processed/fda_cleaned.csv"
put_sql=  f"PUT file://{file_path} @drug_stage AUTO_COMPRESS=TRUE;"
cursor.execute(put_sql)

copy_sql = """
COPY INTO drug_listing_fda
FROM @drug_stage/fda.Cleaned.csv.gz
FILE_FORMAT =(TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1)
"""
cursor.execute(copy_sql)

print('✅ Data pipline completed')
cursor.close()
conn.close()






