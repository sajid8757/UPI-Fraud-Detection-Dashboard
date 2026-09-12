## Chart 1 – Dataset Overview

### Business Question
Is dataset analysis ke liye ready hai

### Tool Used
Pandas

### Key Metrics
- Total Transactions 200,000
- Total Customers 10,000
- Total Merchants 500

### Insight
The dataset is sufficiently large and well-structured for fraud analysis.

### Interview Point
I always begin EDA with executive KPIs before creating visualizations.

## Chart 3 – Data Type Summary

### Business Question
Are all columns stored in appropriate formats?

### Tool Used
Pandas + Matplotlib

### Insight
The timestamp column was successfully converted to datetime, enabling time-based analysis. Validation columns are stored as boolean for efficient filtering.

## Chart 4 – Quality Score Distribution

### Business Question
How healthy is the cleaned dataset?

### Tool Used
Matplotlib

### Insight
Nearly all transactions achieved a quality score of 100, while only a small number of intentionally invalid records scored 70.

### Interview Point
I built a custom quality scoring framework instead of relying only on missing-value checks.

## Chart 5 – Daily Transaction Trend

### Business Question
How does transaction volume change over time?

### Tool Used
Pandas + Matplotlib

### Insight
Daily transaction activity remained relatively stable across the six-month period.

### Interview Point
I aggregated timestamps before visualization to avoid plotting raw records.

## Chart 6 – Monthly Transaction Trend

### Business Question
How are transactions distributed across months?

### Tool Used
Pandas + Matplotlib

### Insight
Monthly transaction volume remained balanced across the six-month simulation period.

### Interview Point
I grouped timestamps using `to_period('M')` before creating the visualization.

## Chart 5 – Daily Transaction Trend

### Business Question
How does transaction activity change day by day?

### Tool Used
Pandas + Matplotlib

### Insight
Daily transaction volume remained stable across all 181 days with only natural fluctuations.

### Interview Point
I aggregated raw timestamps into daily observations before visualization.

---

## Chart 6 – Monthly Transaction Trend

### Business Question
How are transactions distributed across months?

### Tool Used
Pandas + Matplotlib

### Insight
February showed fewer total transactions because it contains only 28 days, while the daily average remained consistent.

### Interview Point
I validated business context before treating lower monthly totals as anomalies.

## Chart 7 – Hour-wise Transaction Volume

### Business Question
At what time of day do customers perform the most transactions?

### Tool Used
Pandas + Matplotlib

### Insight
Transaction activity peaks during business and evening hours, while early morning shows the lowest activity.

### Interview Point
I extracted hourly features using `dt.hour` before aggregation.

## Chart 8 – Day of Week Analysis

### Business Question
Does transaction behavior differ between weekdays and weekends?

### Tool Used
Pandas + Matplotlib

### Insight
Transaction volume follows a balanced weekly distribution, with lower weekend totals reflecting fewer calendar days.

### Interview Point
I reordered weekday categories using `reindex()` to preserve calendar order.

## Chart 9 – Customer Segment Distribution

### Business Question
What is the composition of customers in the payment ecosystem?

### Tool Used
Seaborn

### Insight
Regular customers form the largest customer group, while Premium and Business customers represent smaller but strategically important segments.

### Interview Point
I validated customer composition before comparing behavior across segments.

---

## Chart 10 – Top 10 Most Active Users

### Business Question
Which customers perform the highest number of transactions?

### Tool Used
Pandas + Seaborn

### Insight
The most active users become priority candidates for behavioral investigation rather than immediate fraud classification.

### Interview Point
I linked high-activity users back to their customer segments before drawing conclusions.

### Development Note

Initially, `customer_segment` was not available in `eda_df` because it belongs to the Users dimension table. The issue was resolved by loading `users_raw.csv` and performing a `LEFT JOIN` on `user_id`, following a star-schema approach.

## Chart 11 – Top 10 Most Active Merchants

### Business Question
Which merchants receive the highest number of transactions?

### Tool Used
Pandas + Seaborn

### Insight
A small number of merchants consistently process higher transaction volumes and are suitable candidates for operational monitoring.

### Interview Point
I avoided labeling high-volume merchants as fraudulent without supporting behavioral evidence.

---

## Chart 12 – State-wise Transaction Distribution

### Business Question
How are transactions distributed across different states?

### Tool Used
Pandas + Seaborn

### Insight
Transaction activity varies across states, providing a geographic foundation for regional fraud monitoring.

### Interview Point
I built geographic summaries that can later be converted into Power BI drill-down reports.

## Chart 13 – Payment Status Distribution

### Business Question
How are transactions distributed by payment outcome?

### Tool Used
Matplotlib

### Insight
Most transactions are successful, while failed and pending transactions represent a much smaller operational workload.

### Interview Point
I used a percentage-based visualization to communicate operational outcomes.

---

## Chart 14 – Transaction Type Distribution

### Business Question
Which payment type dominates the ecosystem?

### Tool Used
Seaborn

### Insight
Merchant payments represent the largest share of total transaction activity.

### Interview Point
I compared payment categories before moving into merchant-level analysis.

---

## Chart 15 – Suspicious vs Normal Transactions

### Business Question
What percentage of transactions require investigation?

### Tool Used
Matplotlib

### Insight
Only a small fraction of transactions are flagged for investigation, allowing analysts to prioritize their workload.

### Interview Point
I distinguished flagged transactions from confirmed fraud cases.

---

## Chart 16 – Suspicion Reason Breakdown

### Business Question
What are the most common investigation triggers?

### Tool Used
Seaborn

### Insight
Failed transactions are the largest trigger, followed by late-night activity and high-value payments.

### Interview Point
I treated suspicion reasons as investigation signals rather than confirmed fraud labels.

### Fraud Investigation Summary

Out of 200,000 transactions:

- **11,136 (5.57%)** were flagged for investigation.
- **94.6%** of all transactions completed successfully.
- Failed transactions contributed the largest share of investigation triggers.

# Executive EDA Summary

The exploratory analysis was performed on **200,000 cleaned UPI transactions** covering a six-month period.

## Major Findings

- Peak transaction activity occurred at **8 PM (19,509 transactions)**.
- Only **5.57%** of transactions were flagged for investigation.
- **94.6%** of payments completed successfully.
- Business users consistently appeared among the most active customers.
- High-value transactions represented only **0.5%** of total activity.
- Merchant categories showed relatively balanced suspicious rates between **5.38% and 5.98%**.

## Business Value

The EDA established behavioral baselines that will be used in feature engineering, SQL investigations, and Power BI dashboard design.