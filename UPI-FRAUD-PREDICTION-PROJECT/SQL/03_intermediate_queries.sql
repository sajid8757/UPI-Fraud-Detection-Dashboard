-- Q13 – Total High Value Transactions
-- Business Question
-- Kitni transactions ₹50,000 ya usse upar hain?

SELECT COUNT(*) AS high_value_transactions 
FROM fraud.transactions_feature_engineered
WHERE amount >= 50000;


-- Q14 – High Value Percentage
-- Business Question
-- High-value transactions total ka kitna percentage hain?
WITH high_value_transactions AS(
    SELECT COUNT(*) AS high_value_transaction
    FROM fraud.transactions_feature_engineered
    WHERE amount >= 50000
)
SELECT high_value_transaction ,
ROUND((high_value_transaction * 100.0 )/(SELECT COUNT(*) FROM fraud.transactions_feature_engineered),2) AS
high_value_transaction_percantage
FROM high_value_transactions;



-- Q15 – Payment Status of High Value Transactions
-- Business Question
-- High-value transactions mein Success, Failed aur Pending kitna hai?

SELECT payment_status,COUNT(*) AS high_value_transactions
FROM fraud.transactions_feature_engineered
WHERE amount >= 50000
GROUP BY payment_status;


-- Q16 – Top States by High Value Transactions
-- Business Question
-- Sabse zyada high-value transactions kis state mein hui?
SELECT state,COUNT(*) AS high_value_transactions,
ROUND(SUM(amount),2) AS total_amount
FROM fraud.transactions_feature_engineered
WHERE amount >= 50000
GROUP BY state
ORDER BY high_value_transactions DESC;


-- Q17 – Top High Value Customers (ROW_NUMBER())
-- Ab ROW_NUMBER() practically use karenge.
-- Business Question
-- Kaun se customers sabse zyada high-value transactions karte hain?
SELECT user_id,COUNT(*) AS high_transaction,
SUM(amount) AS total_amount
FROM fraud.transactions_feature_engineered
WHERE amount >= 50000
GROUP BY user_id 
ORDER BY total_amount DESC
LIMIT 10;



-- Q18 – Executive Investigation Report
-- Ye Power BI ke table visual mein direct use hoga.
-- Business Question
-- Top P1 High-Value cases dikhao.
SELECT
    transaction_id,
    user_id,
    state,
    amount,
    payment_status,
    overall_risk_score,
    investigation_priority,
    risk_reason
FROM fraud.transactions_feature_engineered
WHERE
    amount>=50000
    AND investigation_priority='P1'
ORDER BY
    overall_risk_score DESC,
    amount DESC
LIMIT 20;



-- Q19 – Merchant Category Risk Rate
-- Business Question: Har merchant category ka suspicious transaction rate kitna hai?
SELECT
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN suspicion_flag THEN 1 ELSE 0 END) AS suspicious_transactions,
    ROUND(
        AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END) * 100,
        2
    ) AS suspicious_rate
FROM fraud.transactions_feature_engineered
GROUP BY merchant_category
ORDER BY suspicious_rate DESC;


-- Q20 – Top 10 Riskiest Merchants
-- Ab category nahi.
-- Actual merchant IDs.
SELECT merchant_id,merchant_category,
COUNT(*) AS total_transactions ,
SUM(CASE WHEN suspicion_flag THEN 1 ELSE 0 END) AS suspicious_transactions,
ROUND(
      AVG(CASE WHEN suspicion_flag THEN 1 ELSE 0 END) * 100,2
) AS suspicious_rate
FROM fraud.transactions_feature_engineered
GROUP BY merchant_id,merchant_category
HAVING COUNT(*) >=200
ORDer BY suspicious_rate DESC
LIMIT 10;


-- Q21 – Merchant Leaderboard (DENSE_RANK)
-- Ab proper ranking.
WITH merchant_summary AS (
    SELECT
        merchant_id,
        merchant_category,
        COUNT(*) AS transactions,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id,merchant_category
    HAVING COUNT(*)>=200
)
SELECT
    merchant_id,
    merchant_category,
    transactions,
    suspicious_rate,
    DENSE_RANK() OVER(
        ORDER BY suspicious_rate DESC
    ) AS merchant_rank
FROM merchant_summary
ORDER BY merchant_rank
LIMIT 15;


-- Q22 – Risk Quartiles (NTILE(4))
-- Ye query recruiters ko impress karegi.
-- Business Question
-- Merchants ko risk ke hisab se 4 groups mein baanto.
WITH merchant_summary AS (
    SELECT
        merchant_id,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id
    HAVING COUNT(*)>=200
)
SELECT
    merchant_id,
    suspicious_rate,
    NTILE(4) OVER(
        ORDER BY suspicious_rate DESC
    ) AS risk_quartile
FROM merchant_summary
ORDER BY suspicious_rate DESC;


-- Q23 – Above Average Risk Merchants (Subquery)
-- Ab comparison karte hain.
-- Business Question
-- Kaun se merchants average se zyada risky hain?
WITH merchant_summary AS (
    SELECT
        merchant_id,
        merchant_category,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id,merchant_category
    HAVING COUNT(*)>=200
)
SELECT *
FROM merchant_summary
WHERE suspicious_rate>(
    SELECT AVG(suspicious_rate)
    FROM merchant_summary
)
ORDER BY suspicious_rate DESC;





-- Q24 – Executive Merchant Audit Report
-- Ye management-ready report hai.
WITH merchant_summary AS (
    SELECT
        merchant_id,
        merchant_category,
        COUNT(*) AS transactions,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id,merchant_category
    HAVING COUNT(*)>=200
)
SELECT
    merchant_id,
    merchant_category,
    transactions,
    suspicious_rate,
    DENSE_RANK() OVER(
        ORDER BY suspicious_rate DESC
    ) AS merchant_rank,
    CASE
        WHEN suspicious_rate>=8 THEN 'Critical'
        WHEN suspicious_rate>=6 THEN 'High'
        WHEN suspicious_rate>=5 THEN 'Medium'
        ELSE 'Low'
    END AS audit_status
FROM merchant_summary
ORDER BY merchant_rank
LIMIT 20;




WITH merchant_summary AS (
    SELECT
        merchant_id,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id
    HAVING COUNT(*)>=200
)

SELECT
    risk_quartile,
    COUNT(*)
FROM (
    SELECT
        merchant_id,
        NTILE(4) OVER(ORDER BY suspicious_rate DESC) AS risk_quartile
    FROM merchant_summary
) q
GROUP BY risk_quartile
ORDER BY risk_quartile;


WITH merchant_summary AS (
    SELECT
        merchant_id,
        merchant_category,
        ROUND(
            AVG(CASE WHEN suspicion_flag THEN 1.0 ELSE 0 END)*100,
            2
        ) AS suspicious_rate
    FROM fraud.transactions_feature_engineered
    GROUP BY merchant_id, merchant_category
    HAVING COUNT(*)>=200
)

SELECT COUNT(*) AS above_average_merchants
FROM merchant_summary
WHERE suspicious_rate>(
    SELECT AVG(suspicious_rate)
    FROM merchant_summary
);


select * from fraud.transactions_feature_engineered limit 5;