-- ======================================
-- CASE STUDY 1
-- Late Night Fraud Investigation
-- ======================================

-- Q1 Total Late Night Transactions

SELECT COUNT(*) AS late_night_transactions
FROM fraud.transactions_feature_engineered
WHERE is_late_night = TRUE;


-- Q2 Hour-wise Late Night Distribution

SELECT
    EXTRACT(HOUR FROM timestamp) AS hour,
    COUNT(*) AS transactions
FROM fraud.transactions_feature_engineered
WHERE is_late_night = TRUE
GROUP BY EXTRACT(HOUR FROM timestamp)
ORDER BY hour;


-- Late-night transactions mein Success, Failed aur Pending ka distribution kya hai?
SELECT
    CASE
        WHEN payment_status = 'Success' THEN 'Successful'
        WHEN payment_status = 'Failed' THEN 'Failed'
        ELSE 'Pending'
    END AS transaction_result,
    COUNT(*) AS total_transactions
FROM fraud.transactions_feature_engineered
WHERE is_late_night = TRUE
GROUP BY transaction_result
ORDER BY total_transactions DESC;

	
-- Late-night transactions ka average amount har hour ke liye nikalna hai.
WITH late_night_transactions AS (
      SELECT amount, EXTRACT(HOUR FROM timestamp) AS hour
	  FROM 
	  fraud.transactions_feature_engineered
	  WHERE is_late_night = TRUE
)
SELECT hour,COUNT(*) AS late_night_transaction,
ROUND(AVG(amount),2) AS late_night_hourly_average 
FROM late_night_transactions group by hour order by hour;



-- Late-night ke kis hour ko investigation team pehle dekhe?
WITH late_night_summary AS (
    SELECT
        EXTRACT(HOUR FROM timestamp) AS hour,
        COUNT(*) AS transactions
    FROM fraud.transactions_feature_engineered
    WHERE is_late_night = TRUE
    GROUP BY EXTRACT(HOUR FROM timestamp)
)
SELECT
    hour,
    transactions,
    RANK() OVER(
        ORDER BY transactions DESC
    ) AS investigation_rank
FROM late_night_summary
ORDER BY investigation_rank;



-- Top risky late-night hours ko priority ke saath report karo.
WITH late_night_summary AS (
    SELECT
        EXTRACT(HOUR FROM timestamp) AS hour,
        COUNT(*) AS transactions,
        ROUND(AVG(amount),2) AS average_amount
    FROM fraud.transactions_feature_engineered
    WHERE is_late_night = TRUE
    GROUP BY EXTRACT(HOUR FROM timestamp)
)
SELECT
    hour,
    transactions,
    average_amount,
    RANK() OVER(
        ORDER BY transactions DESC
    ) AS investigation_rank,
    CASE
        WHEN transactions >=1500 THEN 'Immediate Review'
        WHEN transactions >=700 THEN 'Monitor'
        ELSE 'Low Priority'
    END AS recommendation
FROM late_night_summary
ORDER BY investigation_rank;


-- Kitne transactions shared devices se hue?
SELECT COUNT(*) AS shared_device_transaction
FROM fraud.transactions_feature_engineered
WHERE shared_device_flag = TRUE;

-- Shared aur Non-Shared devices ka contribution kitna hai?
SELECT
    shared_device_flag,
    COUNT(*) AS transactions,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM fraud.transactions_feature_engineered
GROUP BY shared_device_flag
ORDER BY shared_device_flag DESC;


-- Shared devices par kitni transactions High, Medium aur Low risk hain?
SELECT  COUNT(*) AS transactions ,
CASE
    WHEN overall_risk_score >= 6 THEN 'High Risk'
	WHEN overall_risk_score >=3 THEN 'Medium Risk'
	ElSE 'Low Risk'
END AS risk_bucket
FROM fraud.transactions_feature_engineered
WHERE shared_device_flag = TRUE 
GROUP BY risk_bucket
ORDER BY transactions DESC;


-- Sabse zyada transactions kis shared device par hui?
SELECT device_id,COUNT(*) AS transactions
FROM fraud.transactions_feature_engineered
WHERE shared_device_flag = TRUE
GROUP BY device_id
ORDER BY transactions DESC
LIMIT 10;

-- second method
WITH shared_devices AS (
    SELECT
        device_id,
        COUNT(*) AS transactions
    FROM fraud.transactions_feature_engineered
    WHERE shared_device_flag = TRUE
    GROUP BY device_id
)
SELECT
    device_id,
    transactions,
    DENSE_RANK() OVER(
        ORDER BY transactions DESC
    ) AS device_rank
FROM shared_devices
ORDER BY device_rank 
LIMIT 10;

-- Shared devices kis merchant category mein sabse zyada use hote hain?
SELECT merchant_category,COUNT(*) AS Shared_device_used
FROM fraud.transactions_feature_engineered
WHERE shared_device_flag = TRUE
GROUP BY merchant_category 
ORDER BY Shared_device_used DESC ;



WITH shared_transactions AS (
    SELECT *
    FROM fraud.transactions_feature_engineered
    WHERE shared_device_flag = TRUE
)
SELECT
    merchant_category,
    COUNT(*) AS transactions,
    ROUND(AVG(amount),2) AS avg_amount
FROM shared_transactions
GROUP BY merchant_category
ORDER BY transactions DESC;



-- Analyst ko P1 shared-device cases dikhao.

SELECT
    transaction_id,
    user_id,
    device_id,
    amount,
    payment_status,
    overall_risk_score,
    investigation_priority,
    risk_reason
FROM fraud.transactions_feature_engineered
WHERE
    shared_device_flag = TRUE
    AND investigation_priority = 'P1'
ORDER BY
    overall_risk_score DESC,
    amount DESC
LIMIT 20;



select * FROM fraud.transactions_feature_engineered limit 5;