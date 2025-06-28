import os
import json
import mysql.connector
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

DB_CONFIG = {
    'host': os.getenv("DB_HOST"),
    'port': int(os.getenv("DB_PORT")),
    'user': os.getenv("DB_USER"),
    'password': os.getenv("DB_PASSWORD"),
    'database': os.getenv("DB_NAME")
}

CONFIG_PATH = os.getenv("FIELD_MAPPING_CONFIG")
RAW_DATA_PATH = os.getenv("RAW_DATA_PATH")
RELATION_PATH = os.getenv("TABLE_RELATION_CONFIG")

# Handle nested values (e.g., JSON objects/lists)
def convert_safe(value):
    if isinstance(value, (list, dict)):
        return json.dumps(value)
    return value

def connect_db():
    return mysql.connector.connect(**DB_CONFIG)

def insert_data():
    # Load configurations
    with open(CONFIG_PATH) as f:
        table_mappings = json.load(f)
    with open(RELATION_PATH) as f:
        relation_types = json.load(f)
    with open(RAW_DATA_PATH) as f:
        records = json.load(f)

    conn = connect_db()
    cursor = conn.cursor()

    for row in records:
        # --- Insert into property table ---
        property_fields = table_mappings["property"]
        property_values = [convert_safe(row.get(f)) for f in property_fields]
        cursor.execute(f"""
            INSERT INTO property ({','.join([f.lower() for f in property_fields])})
            VALUES ({','.join(['%s'] * len(property_fields))})
        """, property_values)
        property_id = cursor.lastrowid

        # --- Insert into all other tables ---
        for table, relation in relation_types.items():
            if table == "property":
                continue

            fields = table_mappings[table]

            if relation == "1-1":
                values = [property_id] + [convert_safe(row.get(f)) for f in fields]
                placeholders = ','.join(['%s'] * len(values))
                columns = ['property_id'] + [f.lower() for f in fields]

                cursor.execute(f"""
                    INSERT INTO {table} ({','.join(columns)})
                    VALUES ({placeholders})
                """, values)

            elif relation == "1-many":
                data_list = row.get(table.capitalize(), [])
                for item in data_list:
                    values = [property_id] + [convert_safe(item.get(f)) for f in fields]
                    placeholders = ','.join(['%s'] * len(values))
                    columns = ['property_id'] + [f.lower() for f in fields]

                    cursor.execute(f"""
                        INSERT INTO {table} ({','.join(columns)})
                        VALUES ({placeholders})
                    """, values)

    conn.commit()
    cursor.close()
    conn.close()
    print("✅ ETL completed successfully.")

if __name__ == "__main__":
    insert_data()
