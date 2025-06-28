# Aasawari_Bhavsar_Assesement
This project extracts, transforms, and loads (ETL) raw property data from a JSON file into a normalized MySQL database using Python. It supports scalable, maintainable architecture with configuration-driven mapping.

---

## 📁 Project Structure
Aasawari_Bhavsar_Assesement/
├── config/
│ └── field_mapping.json # Table-column mapping configuration
├── data/
│ └── raw_properties.json # Raw JSON data to be loaded
├── scripts/
│ └── etl.py # Python ETL script
├── sql/
│ └── schema.sql # SQL schema definitions
├── .env # Environment variables (DB configs)
├── docker-compose.initial.yml # Docker setup for MySQL
├── Dockerfile.initial_db # Dockerfile for initial DB
├── requirements.txt # Python dependencies
└── README.md # Project documentation


---

## 🔧 Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/AasawariBhavsar/Aasawari_Bhavsar_Assesement.git
cd Aasawari_Bhavsar_Assesement

### 2. Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

### 3. Install required Python packages
pip install -r requirements.txt

### 4. Set up environment variables
Create a .env file in the root directory with the following content:
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=6equj5_root
DB_NAME=home_db
FIELD_MAPPING_CONFIG=config/field_mapping.json
RAW_DATA_PATH=data/fake_property_data.json
RELATION_PATH=config/table_relationships.json


🐬 MySQL Setup (via Docker)
### 1. Build and run MySQL using Docker:

docker-compose -f docker-compose.initial.yml up --build -d

### 2.Run the schema SQL:
mysql -h 127.0.0.1 -P 3306 -u root -p home_db < sql/create_tables.sql

▶️ Run the ETL Pipeline
Once everything is set up, run the ETL script:
python scripts/etl.py
It will:

1.Read the raw JSON data

2.Parse and normalize based on field_mapping.json

3.Insert records into the respective MySQL tables


📜 Dependencies
Listed in requirements.txt:
mysql-connector-python
python-dotenv

Install using:
pip install -r requirements.txt

🧪 Testing & Validation
After running the ETL:

Connect to MySQL mysql -h 127.0.0.1 -P 3306 -u root -p

Run:
USE home_db;
SHOW TABLES;
SELECT * FROM property LIMIT 5;


