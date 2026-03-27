# 📊 E-Commerce Behavioral Analytics Platform

## 🚀 Overview
This project builds a **cloud-native analytics platform** to analyze customer and product behavior using the [Olist e-commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). The goal is to transform raw transactional data into **analytics-ready datasets** that support business insights such as customer retention, purchase behavior, and product performance.

The platform follows a modern data stack approach, combining data ingestion, distributed processing, transformation, and orchestration to deliver reliable and scalable analytics.

---

## 🎯 Problem Description
E-commerce platforms generate large amounts of transactional data, but raw data alone does not provide actionable insights.  

This project addresses the challenge of:
- Understanding **customer behavior** (repeat purchases, spending patterns)
- Identifying **high-performing products and categories**
- Enabling **data-driven decision making** through structured analytics models and dashboards  

By building an end-to-end pipeline, this project demonstrates how raw data can be transformed into meaningful business insights.

---

## 🧱 Architecture

Kaggle Dataset (CSV)
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
Looker Studio Dashboard

---

## ⚙️ Tech Stack
| Layer              | Tools            |
| ------------------ | ---------------- |
| Ingestion          | Kaggle API + dlt |
| Processing         | PySpark          |
| Transformation     | dbt              |
| Orchestration      | Kestra           |
| Data Warehouse     | BigQuery         |
| Infrastructure     | Terraform        |
| Containerization   | Docker           |
| Optional Streaming | Kafka, PyFlink   |
| Visualization      | Looker Studio    |
| Environment        | GCP VM + uv      |

---

## 📦 Dataset
- Source:[Olist E-Commerce Dataset (Brazilian marketplace)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Tables include:
  - customers
  - geolocation
  - order_items
  - order_payments
  - order_reviews
  - orders
  - product_category_name_translation
  - products
  - sellers

---

## 🧮 Data Modeling
The project follows a **layered approach**:

### 🔹 Staging Layer
- Cleans and standardizes raw data
- Casts data types (e.g., timestamps)

### 🔹 Core Layer
- `fct_orders`
  - Grain: one row per order
  - Includes total order value, item count, timestamps

### 🔹 Data Marts

#### `mart_user_behavior`
- Customer-level aggregation
- Metrics:
  - total_orders
  - total_spent
  - avg_order_value
  - days_since_last_order
  - repeat customer flag

#### `mart_product_performance`
- Product-level aggregation
- Metrics:
  - total_orders
  - total_revenue
  - avg_price
  - product category

---

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
## ⚡ Data Warehouse Optimization

- **Partitioning:**
  - `fact_orders` partitioned by `order_purchase_timestamp`
- **Clustering:**
  - Clustered by `customer_id`

This improves query performance and reduces cost.

---
## 🔄 Pipeline

### Ingestion
- dlt loads raw CSV data into BigQuery (`olist_raw`)

### Transformation
- dbt builds staging models, fact table, and marts

---

🔄 Orchestration (Kestra)

The pipeline automates:

Data ingestion
Spark transformations
dbt runs and tests

---

## 📊 Dashboard
The dashboard provides insights into:

### Customer Behavior
- Repeat vs one-time customers
- Customer spending patterns

### Product Performance
- Revenue by product category
- Top-performing products

---
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
## 📸 Dashboard Preview

_Add screenshot here_

---

## 🛠️ How to Run
### 1. Setup environment
```bash
uv sync
```

### 2. Setup GCP credentials
```bash
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/credentials.json"
```

### 3. Run Ingestion
```bash
cd dlt-pipeline
python dlt_pipeline.py
```

### 4. Run Transformations
```bash
cd dbt-olist
dbt run
dbt test
```
# Provision infrastructure
cd terraform
terraform init
terraform apply


# Run transformations
cd spark_jobs
spark-submit clean_orders.py

# Start orchestration
kestra server start

---

## 📌 Key Learnings
- Building end-to-end ELT pipelines
- Designing dimensional models
- Using dbt for analytics engineering
- Orchestrating workflows with Kestra
- Optimizing BigQuery performance with partitioning and clustering
- Applying PySpark for large-scale transformations
- Creating business-focused dashboards

---

## 📈 Future Improvements
- Add real-time dashboards using streaming pipelines
- Implement data quality monitoring dashboards
- Extend models for recommendation systems
- Add workflow orchestration (Kestra)
- Implement streaming pipeline (Kafka / Flink)
- Add advanced customer segmentation (RFM / clustering)