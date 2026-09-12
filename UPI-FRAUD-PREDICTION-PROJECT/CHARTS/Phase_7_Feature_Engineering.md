# Phase 7 – Feature Engineering

## Feature 1 – is_late_night

### Business Question

Did the transaction occur during unusual late-night hours?

### Logic

Hours between **00:00 and 05:59** are marked as late-night activity.

### Pandas Method

`dt.hour.between(0,5)`

### Why It Matters

Late-night activity becomes one of the core inputs for the final fraud investigation score.

### Future Usage

- SQL filtering
- Power BI slicers
- Risk scoring
- Investigation dashboard


## Feature 2 – is_business_hours

### Business Question
Did the transaction occur during normal business hours?

### Logic
Hours between **09:00 and 18:59** are marked as business hours.

### Pandas Method
`dt.hour.between(9,18)`

### Future Usage
Business behavior comparison and office-hour analytics.

---

## Feature 3 – rush_hour_flag

### Business Question
Did the transaction occur during peak payment hours?

### Logic
Morning (8–10 AM) and Evening (7–9 PM) are marked as rush hours.

### Pandas Method
`dt.hour.isin([8,9,10,19,20,21])`

### Future Usage
Traffic analysis and behavioral comparison.

---

## Feature 4 – hour_risk_score

### Business Question
How much risk should be assigned based only on transaction timing?

### Logic
- Late Night → 3
- Rush Hour → 1
- Business Hours → 0
- Others → 2

### Pandas Method
`np.select()`

### Future Usage
One of the core inputs for the final fraud investigation score.

## Feature 5 – device_usage_count

### Business Question
How many unique users are associated with each device?

### Logic
Count unique users for every device using `groupby()` and `nunique()`.

### Why It Matters
Devices linked with multiple users may require additional investigation.

---

## Feature 6 – shared_device_flag

### Business Question
Is the transaction performed from a shared device?

### Logic
If `device_usage_count > 1`, mark the device as shared.

### Why It Matters
Shared devices become an important behavioral signal in the final fraud investigation score.

## Feature 7 – user_transaction_rank

### Business Question
How active is each user compared with others?

### Logic
Count total transactions for each user and assign a dense rank.

### Pandas Method
`groupby().size()` + `rank(method="dense")`

### SQL Equivalent
`DENSE_RANK()`

### Why It Matters
High-activity users can be prioritized for behavioral analysis.

---

## Feature 8 – daily_transaction_count

### Business Question
How many transactions does a user perform in a single day?

### Logic
Group by `user_id` and `transaction_date`.

### Bonus Rule
If daily transactions are **5 or more**, mark `burst_activity_flag=True`.

### SQL Equivalent
`COUNT(*) OVER (PARTITION BY user_id, transaction_date)`

### Why It Matters
Sudden bursts of activity become an important fraud investigation signal.

## Feature 9 – merchant_risk_score

### Business Question
How risky is each merchant category based on historical suspicious rates?

### Logic
Calculate the suspicious percentage for each merchant category and attach it to every transaction.

### Why It Matters
Category-level risk becomes an important investigation signal.

---

## Feature 10 – user_activity_score

### Business Question
How active is the customer overall?

### Logic
Convert total transaction volume into a score between 0 and 3.

### Why It Matters
Very active users require behavioral context during investigations.

---

## Feature 11 – overall_risk_score

### Business Question
How can multiple investigation signals be combined into one priority score?

### Logic
Combine time, device, payment, amount, burst activity, user behavior, and merchant risk into a single rule-based score.

### Why It Matters
This becomes the primary prioritization metric for analysts and Power BI dashboards.

## Feature 12 – investigation_priority

### Business Question
Which transactions should analysts investigate first?

### Logic
- High → P1
- Medium → P2
- Low → P3

### Why It Matters
It converts risk categories into an operational investigation queue.

---

## Feature 13 – risk_reason

### Business Question
Why was a transaction assigned a particular risk score?

### Logic
Combine multiple behavioral signals into a human-readable explanation.

### Example
"Late Night | Shared Device"

### Why It Matters
Explainable risk scoring improves analyst decision-making and dashboard usability.

## Explainability Improvement

Initially, some transactions received Medium risk scores because of user activity alone while their explanation still showed "Normal".

The risk explanation function was updated to include **High Activity User**, ensuring that every elevated risk score has a matching business explanation.