# UPI Fraud Detection & Investigation Dashboard

End-to-End Fraud Analytics Project built using **Python, PostgreSQL, SQL, and Power BI** on **200,000 simulated UPI transactions**.

The project combines ETL, Feature Engineering, SQL Investigation, and Executive Dashboarding into a complete business intelligence solution.

![Executive Dashboard](DASHBOARD/Executive.png)

## Project Overview

This project simulates a real fraud investigation environment where analysts identify suspicious UPI transactions using multiple behavioral signals instead of relying on a single fraud rule.

The complete workflow includes:
- Data Generation
- Data Cleaning
- Exploratory Data Analysis
- Feature Engineering
- PostgreSQL Investigation
- Power BI Executive Dashboard

## Tech Stack

| Area | Tools |
|---|---|
| Programming | Python |
| Data Processing | Pandas, NumPy |
| Visualization | Matplotlib |
| BI | Power BI |
| Database | PostgreSQL |
| Querying | SQL |
| Version Control | Git |

## Project Workflow

1. Generated synthetic UPI transactions
2. Cleaned duplicate and missing records
3. Validated data quality
4. Performed Exploratory Data Analysis
5. Engineered 35 fraud detection features
6. Built PostgreSQL investigation case studies
7. Designed an executive Power BI dashboard

## Key Metrics

| Metric | Value |
|---|---|
| Transactions | 200,000 |
| Users | 10,000 |
| Merchants | 500 |
| Fraud Rate | 5.57% |
| P1 Cases | 4,022 |
| Features | 35 |

## SQL Investigation

Solved **30+ business case studies** using:
- CTE
- Window Functions
- RANK
- DENSE_RANK
- NTILE
- CASE
- Aggregate Analysis

## Repository Structure

| Folder | Purpose |
|---|---|
| PYTHON | Complete Python workflow |
| SQL | PostgreSQL investigation |
| POWER_BI | Dashboard files |
| CHARTS | Visual outputs |
| DOCUMENTATION | Project Notes & Data Dictionary |

## Business Impact

Instead of relying on a single fraud rule, the project combines multiple behavioral signals into an explainable investigation score.

The highest-risk transaction reached a score of **11** because multiple fraud indicators occurred together:
- Late Night
- Shared Device
- High Value
- High Activity User
