# HW3 – Wiki Page Views Pipeline (dbt + Snowflake)

## 1. Project Overview

This project implements an end-to-end ELT pipeline using **dbt** and **Snowflake**.  
The objectives are to:

- Create staging tables in Snowflake from 311_raw_data  
- Build a dbt project with sources, staging models, and marts  
- Clean and transform 311 service requests data in Mahanttan, NYC
- Produce fact table
- Run schema tests and generate project documentation  

---

## 2. dbt Project Structure

```
wiki_dbt_project/
│── dbt_project.yml
│── README.md
│
├── models/
│   ├── sources.yml
│   │
│   ├── staging/
│   │   ├── stg_311.sql
│   │
│   └── marts/
│       ├── fct_311.sql
│       └── schema.yml
```

---

## 3. dbt Commands Used

### Run all models
```sh
dbt run
```

### Run staging models only
```sh
dbt run --select staging
```

### Run tests
```sh
dbt test
```

### Generate documentation
```sh
dbt docs generate
dbt docs serve
```