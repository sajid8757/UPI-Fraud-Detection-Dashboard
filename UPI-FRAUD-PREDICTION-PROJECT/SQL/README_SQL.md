# PostgreSQL Investigation Lab

## Database

- Database: `upi_fraud_detection`
- Schema: `fraud`

## Main Table

`transactions_feature_engineered`

Rows: **200,000**

## Why Manual Table Creation?

Instead of automatic CSV import, data types were defined manually to maintain control over numeric, boolean, timestamp, and date fields.

## Performance Optimization

Indexes created on:

- user_id 
- timestamp
- merchant_id
- overall_risk_score
- investigation_priority


# Case Study 1 – Late Night Fraud Investigation

## Objective

Analyze transaction behavior between **12 AM and 5 AM** to identify unusual payment patterns.

## SQL Concepts Covered

- WHERE
- COUNT
- GROUP BY
- ORDER BY
- EXTRACT()

## Case Study 1 (Continued)

### New SQL Concepts

- CASE WHEN
- CTE (Common Table Expression)
- AVG()
- ROUND()
- EXTRACT()

## Case Study 1 (Completed)

### SQL Concepts Learned

- WHERE
- COUNT
- GROUP BY
- ORDER BY
- CASE WHEN
- CTE
- AVG
- ROUND
- EXTRACT
- RANK() OVER()

## Case Study 2 – Shared Device Investigation

### SQL Concepts Covered

- WHERE
- COUNT
- GROUP BY
- CASE WHEN
- CTE
- DENSE_RANK()
- Window Functions
- Percentage Calculation

### Key Finding

The highest-risk transaction achieved a score of **11** because multiple behavioral signals occurred together:

- Late Night
- Shared Device
- High Value
- High Activity User

Instead of relying on a single rule, the project combines multiple risk signals into one explainable investigation score.

Case Study 3 – High Value Payment Investigation
Business Problem

Fraud Investigation Team ko ₹50,000 ya usse upar ke transactions identify karne hain aur unhe risk score, payment status aur customer behavior ke basis par prioritize karna hai.

SQL Concepts Covered

WHERE

GROUP BY

COUNT

SUM

AVG

Scalar Subquery

ROW_NUMBER()

CTE

ORDER BY

Key Findings

999 high-value transactions identify hui (0.50% of total transactions).

High-value transactions me 944 Success, 45 Failed, aur 10 Pending cases mile.

Telangana aur West Bengal sabse zyada high-value transaction wale states nikle.

Highest priority cases me Shared Device + Failed Payment + High Value ka combination repeatedly mila.

Business Impact

Instead of manually reviewing all 200,000 transactions, analysts can directly focus on a small group of high-value transactions that carry the highest financial risk.

Case Study 4 – Merchant Risk Audit
Business Problem

Fraud Risk Team ko identify karna tha ki kaun se merchant categories aur individual merchants unusual suspicious activity generate kar rahe hain.

SQL Concepts Covered

HAVING

CASE WHEN

DENSE_RANK()

NTILE()

CTE

Aggregate Functions

Window Functions

Scalar Subquery

Key Findings

Other merchant category sabse high suspicious rate (5.98%) par rahi.

Merchant M0161 highest suspicious rate (9.47%) ke saath Rank 1 par raha.

NTILE(4) ki madad se merchants ko Critical, High, Medium aur Low risk groups me classify kiya gaya.

Above-average suspicious rate wale merchants ko executive audit list me isolate kiya gaya.

Business Impact

Risk Team manually 500 merchants review karne ke bajay sirf high-risk merchants ko prioritize kar sakti hai, jisse investigation time significantly reduce hota hai.

# Case Study 5 – Executive Fraud Dashboard

## Business Problem

Create SQL queries that directly power an executive Power BI dashboard, allowing management to monitor fraud trends, investigation queues, and high-risk transactions without manually exploring raw data.

## SQL Concepts Covered

- FILTER clause
- Aggregate Functions
- GROUP BY
- ORDER BY
- Multi-level Sorting
- KPI Queries
- Executive Reporting

## Key Findings

- **200,000** transactions processed.
- **11,136** suspicious transactions identified.
- Overall fraud rate: **5.57%**.
- **4,022** P1 investigation cases require immediate review.
- Karnataka generated the highest number of P1 cases (432).
- The highest-risk transaction reached a risk score of **11**, while several low-value transactions also became P1 because multiple behavioral signals occurred together.

## Business Impact

Instead of opening thousands of raw transaction records, executives can immediately monitor fraud KPIs, state-wise risk distribution, daily fraud trends, and the highest-priority investigation queue.

