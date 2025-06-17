import requests
import json
import os 

os.makedirs ("data", exist_ok=True)

response = requests.get("https://api.fda.gov/drug/event.json?limit=100")
data = response.json()

with open("data/fda_event_data.json","w") as f:
    json.dump(data['results'],f)

print("✅ Data saved to data/raw/fda_event_raw.json")