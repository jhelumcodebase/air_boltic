**Air_Boltic**
A design for a hypothetical air taxi service.

**ETL Process Overview**
Extraction, Cleaning, and Preprocessing
Data transformation is carried out using PySpark. Input files can be stored in either an S3 or GCS bucket, with Databricks managing the Spark jobs. The transformed data is then stored in BigQuery for downstream usage.

**Data Modeling**
DBT (Data Build Tool) is used to generate insights such as revenue and popular routes. Models can be configured for incremental updates or materialized as tables. DBT configurations allow for clustering, pre-hook and post-hook operations, and repartitioning. Processed models are stored in BigQuery, accessible for BI teams, data analysts, and data scientists.

**Orchestration**
Airflow is employed to orchestrate and schedule jobs that trigger DBT models. This project uses the DockerOperator, but the BigQueryOperator could also be used.

**Visualization**
Looker, Power BI, or Tableau can be leveraged to build dashboards and generate insights or reports using the tables created by DBT models. These reports are instrumental for marketing, CRM, and leadership teams in making data-driven decisions.

**Containerization**
Docker is used to create containers for all essential services, including DBT, the Airflow webserver, and the Airflow scheduler, ensuring smooth deployment and management.

**Additional Tools**
The project utilizes Git for version control and VS Code as the development environment.

