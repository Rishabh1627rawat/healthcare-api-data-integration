import json
import pandas as pd
import os

# Mapping values for gender and seriousness
sex_map = {
    "0": "Unknown",       
    "1": "Male",
    "2": "Female",
    "3": "Not Reported"
}

serious_case_map = {
    "0": "No",           
    "1": "Yes"
}

result_in_death_map = {
    "0": "No",
    "1": "Yes"
}


with open('data/fda_event_data.json', "r") as f:  
    raw_files = json.load(f)

clean_records = []

for record in raw_files:
    try:
        report = {
            "report_id": record.get("safetyreportid"),  
            "report_date": record.get("receivedate"),   

           
            "serious_case": serious_case_map.get(str(record.get("serious", "0")), "Unknown"),

            "result_in_death": result_in_death_map.get(
                str(record.get("seriousnessdeath", "0")), "Unknown"
            ),

            "country": record.get("primarysource", {}).get("reportercountry"),

            "patient_age": record.get("patient", {}).get("patientonsetage"),

            "patient_sex": sex_map.get(
                str(record.get("patient", {}).get("patientsex", "0")), "Unknown"
            ),

            "drug_name": record.get("patient", {}).get("drug", [{}])[0].get("medicinalproduct"),

            "drug_indication": record.get("patient", {}).get("drug", [{}])[0].get("drugindication"),

            "side_effects": ", ".join([
                r.get("reactionmeddrapt", "") for r in record.get("patient", {}).get("reaction", [])
            ])
        }

        clean_records.append(report)

    except Exception as e:
        print("❌ Skipped one record due to missing data or structure issue.")
        continue

# Save the cleaned data
os.makedirs("data/processed", exist_ok=True)

df = pd.DataFrame(clean_records)
df.to_csv("data/processed/fda_cleaned.csv", index=False)

with open("data/processed/fda_cleansed.json", "w") as jf:
    json.dump(clean_records, jf , indent=2)

print("✅ Cleaned data saved to data/processed/fda_cleaned.csv")

print("✅ Cleaned data saved to data/processed/fda_cleaned.json")