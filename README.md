# UPI Payments Analytics & Fraud Detection

**An end-to-end data analytics project using Python, SQL, PostgreSQL and Power BI to analyse UPI transactions, payment performance, fraud patterns, customer behaviour and retention.**

[![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)](https://www.python.org/)
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Visualization-Power%20BI-F2C811?logo=powerbi)](https://powerbi.microsoft.com/)
[![SQL](https://img.shields.io/badge/Language-SQL-orange)](https://www.postgresql.org/)

## Project Overview

Digital payment platforms generate large volumes of transaction data every day. Analysing this data helps businesses monitor payment performance, understand customer behaviour, identify transaction failures and investigate suspicious transaction patterns.

This project performs an end-to-end analysis of **550,000 UPI transaction records** using Python, PostgreSQL and Power BI. It transforms raw transaction data into analytical datasets and interactive dashboards to generate meaningful business insights.

## Project Objectives

- Analyse overall UPI transaction volume and value.
- Evaluate payment success, failure, reversal and pending rates.
- Identify payment methods with higher failure rates.
- Analyse transaction patterns across time and geography.
- Examine fraud patterns using the dataset-provided fraud indicator.
- Segment customers using RFM analysis.
- Explore customer acquisition and cohort retention patterns.
- Build interactive Power BI dashboards for business reporting.

## Technology Stack

| Technology | Application |
|---|---|
| Python | Data cleaning, preprocessing and analysis |
| Pandas | Data manipulation and transformation |
| NumPy | Numerical operations |
| Matplotlib & Seaborn | Exploratory data visualisation |
| Jupyter Notebook | Data analysis |
| PostgreSQL | Relational database management |
| SQL | Analytical queries and reporting |
| Power BI | Interactive dashboards |
| Git & GitHub | Version control |

## Dataset Overview

| Description | Details |
|---|---:|
| Total transaction records | 550,000 |
| Unique customers | 79,916 |
| Successful transactions | 506,247 |
| Failed transactions | 21,905 |
| Reversed transactions | 11,019 |
| Pending transactions | 10,829 |

The project uses transaction-level information and customer attributes to perform payment, fraud and customer behaviour analysis.

*Note: The fraud analysis uses the fraud indicator supplied in the dataset. It is an analytical investigation of labelled cases, not a production fraud prediction model.*

## Project Workflow

1. **Data Understanding:** Inspect the dataset, understand its structure and assess data quality.
2. **Data Cleaning:** Handle missing values, validate data types and prepare transaction records.
3. **Exploratory Data Analysis:** Investigate transaction patterns and distributions using Python.
4. **Feature Engineering:** Create transaction status flags and customer-level analytical features.
5. **Database Management:** Load transaction records into PostgreSQL.
6. **SQL Analysis:** Execute analytical queries using aggregations, CTEs and window functions.
7. **Data Export:** Generate processed analytical datasets for reporting.
8. **Power BI:** Develop dashboards to communicate business insights.

## Key Analysis Performed

### 1. Payment Performance Analysis

- Total transaction volume and transaction value.
- Successful, failed, reversed and pending transactions.
- Payment success and failure rates.
- Transaction distribution by payment method.
- Monthly and time-based transaction trends.
- State-wise transaction analysis.

### 2. Fraud & Risk Analytics

- Fraud-labelled transaction distribution.
- Fraud cases across different states.
- Fraud patterns by payment method.
- Fraud analysis by merchant category.
- Comparison of fraud-labelled and non-fraud transactions.

### 3. Customer Behaviour & RFM Segmentation

RFM analysis was performed using three customer metrics:

- **Recency:** How recently a customer made a transaction.
- **Frequency:** How frequently a customer transacted.
- **Monetary:** Total customer spending.

Customers were grouped into the following segments:

- High Value Customers
- Loyal Customers
- Regular Customers
- At Risk Customers
- Inactive Customers

### 4. Customer Retention & Cohort Analysis

- Customer acquisition month identification.
- Cohort customer counts.
- Monthly cohort retention analysis.
- Retention matrix generation.
- Cohort-based visualisation.

Retention calculations and cohort visualisations are exploratory and should be validated before using them for business decisions.

## Power BI Dashboard

The project contains five analytical dashboard sections.

| Dashboard Page | Description |
|---|---|
| Executive Overview | Key transaction and customer KPIs |
| Payment Performance | Payment success, failure and payment method analysis |
| Fraud & Risk Analytics | Fraud patterns by state, payment method and merchant category |
| Customer Segmentation | Customer distribution and RFM analysis |
| Customer Retention & Cohort Analysis | Cohort counts and retention patterns |

### Dashboard Screenshots

**1. Executive Overview & Payment Performance**

![Executive Overview and Payment Performance](screenshots/dashboard-overview.png)

**2. Fraud & Risk Analytics & Customer Segmentation**

![Fraud and Customer Segmentation](screenshots/fraud-customer-segmentation.png)

**3. Customer Retention & Cohort Analysis**

![Customer Retention and Cohort Analysis](screenshots/cohort-retention.png)

## Key Dashboard Metrics

The dashboard preview displays the following headline figures:

| Metric | Dashboard Value |
|---|---:|
| Total Transactions | 550K |
| Total Transaction Value | 16.45bn |
| Payment Success Rate | 92.0% |
| Failed Transactions | 22K |
| Fraud Cases | 5K |
| Total Customers | 79.916K |

These are rounded dashboard figures. Refer to the underlying analytical datasets for detailed values.

## SQL Analysis

Seven SQL scripts were developed and executed successfully.

| SQL Script | Analysis |
|---|---|
| `01_payment_performance_analysis.sql` | Payment performance |
| `02_advanced_payment_analytics.sql` | Advanced payment analytics |
| `03_customer_behavior_analysis.sql` | Customer behaviour |
| `04_customer_retention_analysis.sql` | Customer retention |
| `05_fraud_detection_analysis.sql` | Fraud analysis |
| `06_advanced_sql_window_functions.sql` | Advanced window functions |
| `07_export_analytics_datasets.sql` | Analytical dataset exports |

### SQL Concepts Used

- SELECT, WHERE and ORDER BY
- GROUP BY and aggregate functions
- CASE statements
- Common Table Expressions (CTEs)
- Window functions
- Date-based analysis
- Customer-level aggregations
- Analytical subqueries

## Project Structure

```text
upi-payments-analytics-fraud-detection/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   └── 01_data_understanding.ipynb
│
├── sql/
│   ├── 01_payment_performance_analysis.sql
│   ├── 02_advanced_payment_analytics.sql
│   ├── 03_customer_behavior_analysis.sql
│   ├── 04_customer_retention_analysis.sql
│   ├── 05_fraud_detection_analysis.sql
│   ├── 06_advanced_sql_window_functions.sql
│   └── 07_export_analytics_datasets.sql
│
├── src/
│   ├── export_analytics.py
│   ├── load_data_to_postgres.py
│   └── prepare_powerbi_data.py
│
├── powerbi/
│   └── upi_analytics_dashboard_data.xlsx
│
├── screenshots/
│   ├── dashboard-overview.png
│   ├── fraud-customer-segmentation.png
│   └── cohort-retention.png
│
├── reports/
│
├── requirements.txt
├── .gitignore
└── README.md
```

*The structure above is a guide. Update it if your final repository has different folder names or files.*

## How to Run the Project

### 1. Clone the Repository

```bash
git clone https://github.com/Kourpreetika/upi-payments-analytics-fraud-detection.git
cd upi-payments-analytics-fraud-detection
```

### 2. Create a Python Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Run the Jupyter Notebook

```bash
jupyter notebook
```

Open `01_data_understanding.ipynb` inside the `notebooks/` directory and execute the analysis cells.

### 5. Set Up PostgreSQL

Create the project database:

```sql
CREATE DATABASE upi_payments_analytics;
```

Configure your local PostgreSQL connection, load the prepared transaction dataset and execute the SQL scripts from the `sql/` directory.

### 6. Generate Analytical Datasets

Run the export scripts from the project root:

```bash
python src/export_analytics.py
python src/prepare_powerbi_data.py
```

The generated analytical datasets can then be imported into Power BI.

## Key Skills Demonstrated

- Data Analytics
- Data Cleaning and Preprocessing
- Exploratory Data Analysis (EDA)
- Python Programming
- SQL & PostgreSQL
- Data Transformation
- Customer Segmentation
- RFM Analysis
- Fraud Pattern Analysis
- Cohort Analysis
- Data Visualisation
- Power BI Dashboard Development
- Business Intelligence

## Future Enhancements

- Validate and improve cohort retention calculations.
- Develop a machine learning model for fraud prediction.
- Explore customer churn prediction.
- Automate data refresh and dashboard reporting.
- Add more advanced transaction monitoring and customer insights.

## Author

**Preetika Kour**

B.Tech – Information Science and Engineering

Interested in Data Analytics, Business Intelligence, SQL, Python and Data Visualisation.

- **GitHub:** [Kourpreetika](https://github.com/Kourpreetika)
- **Project Repository:** [UPI Payments Analytics & Fraud Detection](https://github.com/Kourpreetika/upi-payments-analytics-fraud-detection)

---

If you find this project useful, feel free to explore the repository and share your feedback.