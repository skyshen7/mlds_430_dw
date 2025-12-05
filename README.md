# NYC 311 Complaints Data Pipeline | MLDS 430 Final Project

**Author:** Keyu (Sky) Shen  
**Course:** MLDS 430 - Data Warehousing  

---

## Project Overview

This project implements an end-to-end data pipeline analyzing NYC 311 service requests from Manhattan during Summer 2025 (June - August). The pipeline demonstrates modern data engineering practices including API data extraction, cloud data warehousing, transformation using dbt, and interactive visualization.

**Dataset:** NYC 311 Service Requests (Manhattan, Summer 2025)  
**Total Records:** 161,198 complaints  
**Time Period:** June 1 - August 31, 2025

---

## Architecture

```
NYC Open Data API → Python Extraction → Snowflake (Raw) → dbt Transformations → Tableau Dashboard
```

### Pipeline Components:
1. **Extraction:** Python script pulls data from NYC Open Data API
2. **Storage:** Raw data loaded into Snowflake data warehouse
3. **Transformation:** dbt models clean and transform data (staging → marts)
4. **Visualization:** Tableau dashboard with interactive analytics

---

## Tech Stack

- **Data Extraction:** Python (requests, pandas)
- **Data Warehouse:** Snowflake
- **Transformation:** dbt (Data Build Tool)
- **Visualization:** Tableau
- **Version Control:** Git/GitHub

---

## 📁 Project Structure

```
mlds_430_dw/
├── Extraction_Python/
│   ├── Extarct_data.ipynb          # Python notebook for API extraction
│   └── raw_data_screenshot.png          # Raw data screenshot 
│
├── Loaded_data/
│   ├── snowflake_raw.png           # Raw table in Snowflake
│   ├── snowflake_stg.png           # Staging table in Snowflake
│   ├── snow_flake_fct.png          # Fact table in Snowflake
│   └── check_query_snowflake.sql   # Verification queries
│
├── final_dbt_project/
│   ├── models/
│   │   ├── staging/
│   │   │   └── stg_311.sql         # Staging model (data cleaning)
│   │   └── marts/
│   │       └── fct_311.sql         # Fact table (feature engineering)
│   ├── dbt_project.yml             # dbt configuration
│   └── schema.yml                  # Model documentation
│
├── Analytics:Visualizatiton/
│   ├── dashboard.twb               # Tableau workbook
│   └── dashboard_screenshot.png    # Dashboard preview
│
└── README.md                       # Project documentation
```

---

## Data Pipeline Details

### 1. Data Extraction (`Extraction_Python/`)

**Source:** NYC Open Data 311 Service Requests API  
**Endpoint:** `https://data.cityofnewyork.us/resource/erm2-nwe9.json`

**Filters Applied:**
- **Borough:** Manhattan only
- **Date Range:** June 1 - August 31, 2025
- **Pagination:** 50,000 records per API call

**Key Fields Extracted:**
- `created_date`, `closed_date`
- `agency`, `complaint_type`, `descriptor`
- `status`, `resolution_description`
- `incident_zip`, `incident_address`
- `latitude`, `longitude`

**Output:** 161,198 records loaded into Snowflake `RAW_311` table

---

### 2. Data Transformation (dbt Models)

#### Staging Layer: `stg_311.sql`
**Purpose:** Data cleaning and type casting  
**Materialization:** View

**Transformations:**
- Convert date strings to timestamps
- Cast numeric fields (zip, latitude, longitude)
- Filter out records with missing critical fields
- Ensure data quality (no nulls in key columns)

#### Marts Layer: `fct_311.sql`
**Purpose:** Feature engineering for analytics  
**Materialization:** Table

**Features Created:**
- `case_duration_hours`: Time to resolve complaint (in hours)
- `is_weekend`: Weekday vs Weekend classification
- `hour_of_day`: Hour when complaint was created
- `response_speed_category`: Fast (<2h), Medium (2-12h), Slow (>12h)

---

## Dashboard & Analytics

### Key Metrics:
- **Total Cases:** 145,706 (after cleaning)
- **Average Case Duration:** 110.4 hours
- **Peak Complaint Month:** June (52,020 cases)

### Visualizations:
1. **Monthly Trends:** Complaint volume by month
2. **Hourly Patterns:** Weekday vs Weekend complaint distribution
3. **Top Complaint Types:** Bar chart of most common issues
4. **Geographic Map:** Spatial distribution across Manhattan
5. **Interactive Filters:** Filter by complaint type, time, location

**Dashboard Preview:**

![NYC 311 Dashboard](Analytics:Visualizatiton/dashboard_screenshot.png)

---

## How to Run This Project

### Prerequisites:
- Python 3.10+
- Snowflake account with appropriate credentials
- dbt installed (`pip install dbt-snowflake`)
- Tableau Desktop (for viewing dashboard)

### Step 1: Data Extraction
```bash
# Navigate to extraction folder
cd Extraction_Python/

# Run the Jupyter notebook
jupyter notebook Extarct_data.ipynb

# Execute all cells to:
# 1. Fetch data from NYC Open Data API
# 2. Save to complaints_raw.csv
# 3. Upload to Snowflake RAW_311 table
```

### Step 2: dbt Transformations
```bash
# Navigate to dbt project
cd final_dbt_project/

# Install dependencies
dbt deps

# Run dbt models
dbt run

# Test data quality
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```

### Step 3: Tableau Dashboard
```bash
# Open Tableau workbook
open Analytics:Visualizatiton/dashboard.twb

# Connect to Snowflake and refresh data
# Explore interactive visualizations
```

## References

- [NYC Open Data 311 API](https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9)