-- Q25 – Total Transactions KPI
-- Business Problem
-- Management ko total processed transactions ka live count chahiye.
SELECT COUNT(*) AS total_transactions
FROM fraud.transactions_feature_engineered;


-- Q26 – Overall Fraud Rate KPI
-- Business Problem
-- Total suspicious transactions ka overall fraud percentage kitna hai?
SELECT 
      COUNT(*) FILTER (WHERE suspicion_flag = TRUE) AS suspicious_transactions,
	  COUNT(*) AS total_transaction,
      ROUND
           (COUNT(*) FILTER (WHERE suspicion_flag = TRUE)*100.0 / COUNT(*),2)
           AS overall_fraud_percentage
FROM fraud.transactions_feature_engineered ;


-- Q27 – P1 Investigation Queue
-- Business Problem
-- Investigation team ko abhi kitne P1 cases pending hain?
SELECT investigation_priority,COUNT(*) AS cases
FROM fraud.transactions_feature_engineered
GROUP BY investigation_priority;


-- Q28 – Daily Fraud Trend
-- Business Problem
-- Management ko daily suspicious transactions ka trend dekhna hai.
SELECT
    transaction_date,
    COUNT(*) FILTER(WHERE suspicion_flag=TRUE) AS suspicious_transactions,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) FILTER(WHERE suspicion_flag=TRUE)*100.0/
        COUNT(*),
        2
    ) AS daily_fraud_rate
FROM fraud.transactions_feature_engineered
GROUP BY transaction_date
ORDER BY transaction_date;


-- Q29 – Top 5 High-Risk States
-- Business Problem
-- Kaun se states investigation ke liye highest priority hain?
SELECT
    state,
    COUNT(*) FILTER(WHERE investigation_priority='P1') AS p1_cases,
    ROUND(AVG(overall_risk_score),2) AS avg_risk_score
FROM fraud.transactions_feature_engineered
GROUP BY state
ORDER BY p1_cases DESC
LIMIT 5;	   


-- Q30 – Payment Status Matrix
-- Business Problem
-- Risk category ke andar payment status ka distribution dekhna hai.
SELECT
    risk_category,
    payment_status,
    COUNT(*) AS transactions
FROM fraud.transactions_feature_engineered
GROUP BY risk_category,payment_status
ORDER BY risk_category,payment_status;


-- Q31 – Risk Heatmap Dataset
-- Business Problem
-- State aur Risk Category ke combination ka transaction volume dekhna hai.
SELECT
    state,
    risk_category,
    COUNT(*) AS transactions
FROM fraud.transactions_feature_engineered
GROUP BY state,risk_category
ORDER BY state,risk_category ;



-- Q32 – Executive Summary Report
-- Business Problem
-- Management ko ek hi report me highest priority fraud cases dekhne hain.
SELECT
    transaction_id,
    timestamp,
    user_id,
    state,
    merchant_category,
    amount,
    overall_risk_score,
    investigation_priority,
    risk_reason
FROM fraud.transactions_feature_engineered
WHERE investigation_priority='P1'
ORDER BY
    overall_risk_score DESC,
    amount DESC,
    timestamp DESC
LIMIT 25;



select SUM(amount) AS total_revenue
from fraud.transactions_feature_engineered;


select * from fraud.transactions_feature_engineered
limit 5;
