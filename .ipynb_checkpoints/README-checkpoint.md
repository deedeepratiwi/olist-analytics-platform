📊 E-Commerce Behavioral Analytics Platform
Overview

This project builds a cloud-native analytics platform for an e-commerce marketplace using the Olist dataset. It transforms raw transactional data into analytics-ready datasets that support user behavior and product performance analysis.

The platform follows a modern data stack approach, combining data ingestion, distributed processing, transformation, and orchestration to deliver reliable and scalable analytics.

---

🎯 Objectives
Build an end-to-end ELT pipeline for marketplace data
Design analytics-ready data models using dimensional modeling
Analyze user behavior and product performance
Ensure data reliability through testing and orchestration
Optimize warehouse performance using partitioning and clustering

---

🧱 Architecture
Raw Data (CSV)
    ↓
dlt ingestion
    ↓
GCS / BigQuery Raw
    ↓
PySpark processing
    ↓
BigQuery Staging
    ↓
dbt transformations
    ↓
Analytics Data Mart
    ↓
Dashboard / Insights

---

⚙️ Tech Stack
| Layer              | Tools          |
| ------------------ | -------------- |
| Ingestion          | dlt            |
| Processing         | PySpark        |
| Transformation     | dbt            |
| Orchestration      | Kestra         |
| Data Warehouse     | BigQuery       |
| Infrastructure     | Terraform      |
| Containerization   | Docker         |
| Optional Streaming | Kafka, PyFlink |
| Visualization      | Looker Studio  |

---

📦 Dataset
[Olist E-Commerce Dataset (Brazilian marketplace)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
Includes customers, orders, products, sellers, payments, and reviews

---


🧮 Data Modeling

The platform uses a star schema design:

Fact Tables
fact_orders
Dimension Tables
dim_customers
dim_products
dim_sellers
dim_dates
Analytical Data Marts
mart_user_behavior
mart_product_performance
mart_seller_performance

---

🔍 Key Business Questions
1. Customer Behavior
What is the repeat purchase rate?
How does customer value evolve over time?
2. Product Performance
Which categories drive the most revenue?
Which products have the highest repeat purchases?
3. Seller Performance
Which sellers generate the most revenue?
How does delivery performance affect ratings?
4. Purchase Patterns
How frequently do users return?
What categories are commonly purchased together?

---
🚀 Pipeline Workflow
Ingestion
dlt loads raw data into GCS / BigQuery
Processing
PySpark cleans and aggregates large datasets
Transformation
dbt builds fact/dimension tables and marts
Orchestration
Kestra schedules and runs workflows
Serving
Data is exposed to BI dashboards

---
⚡ BigQuery Optimization
Partitioned by order_purchase_timestamp
Clustered by customer_id and product_id
Reduces query cost and improves performance

---

🔄 Orchestration (Kestra)

The pipeline automates:

Data ingestion
Spark transformations
dbt runs and tests

---

📊 Dashboard

The dashboard provides:

Customer Insights
retention cohorts
repeat purchase rate
Product Insights
category revenue
top products
Seller Insights
revenue by seller
delivery performance

---
🛠️ How to Run
# Provision infrastructure
cd terraform
terraform init
terraform apply

# Run ingestion
cd dlt_pipeline
python pipeline.py

# Run transformations
cd spark_jobs
spark-submit clean_orders.py

# Run dbt
cd dbt
dbt run
dbt test

# Start orchestration
kestra server start

---

📌 Key Learnings
Building scalable ELT pipelines
Designing dimensional models
Orchestrating workflows with Kestra
Optimizing BigQuery performance
Applying PySpark for large-scale transformations

---

📈 Future Improvements
Add real-time dashboards using streaming pipelines
Implement data quality monitoring dashboards
Extend models for recommendation systems