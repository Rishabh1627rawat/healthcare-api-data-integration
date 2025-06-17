import json

# Step 1: Read the original JSON file
with open('C:/Users/nikhi/Desktop/health-integration-project/data/processed/fda_cleansed.json', 'r') as f:
    data = json.load(f)

# Step 2: Write to NDJSON format
with open('updated.cleansed.json', 'w') as out:
    for record in data:
        json.dump(record, out)
        out.write('\n')
