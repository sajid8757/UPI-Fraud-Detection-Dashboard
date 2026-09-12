CREATE SCHEMA fraud;

SELECT schema_name
FROM information_schema.schemata;

CREATE TABLE fraud.transactions_feature_engineered (

    transaction_id TEXT PRIMARY KEY,

    timestamp TIMESTAMP,

    user_id TEXT,

    device_id TEXT,

    merchant_id TEXT,

    transaction_type TEXT,

    amount NUMERIC(12,2),

    payment_status TEXT,

    suspicion_flag BOOLEAN,

    suspicion_reason TEXT,

    state TEXT,

    city TEXT,

    amount_valid BOOLEAN,

    timestamp_valid BOOLEAN,

    status_valid BOOLEAN,

    location_valid BOOLEAN,

    quality_score INT,

    is_late_night BOOLEAN,

    is_business_hours BOOLEAN,

    rush_hour_flag BOOLEAN,

    hour_risk_score INT,

    device_usage_count INT,

    shared_device_flag BOOLEAN,

    total_transactions INT,

    user_transaction_rank INT,

    transaction_date DATE,

    daily_transaction_count INT,

    burst_activity_flag BOOLEAN,

    merchant_category TEXT,

    merchant_risk_score NUMERIC(5,2),

    user_activity_score INT,

    overall_risk_score INT,

    risk_category TEXT,

    investigation_priority TEXT,

    risk_reason TEXT
);

SELECT * FROM fraud.transactions_feature_engineered;

SELECT COUNT(*)
FROM fraud.transactions_feature_engineered;

SELECT *
FROM fraud.transactions_feature_engineered
LIMIT 5;


CREATE INDEX idx_user
ON fraud.transactions_feature_engineered(user_id);

CREATE INDEX idx_timestamp
ON fraud.transactions_feature_engineered(timestamp);

CREATE INDEX idx_merchant
ON fraud.transactions_feature_engineered(merchant_id);

CREATE INDEX idx_risk
ON fraud.transactions_feature_engineered(overall_risk_score);

CREATE INDEX idx_priority
ON fraud.transactions_feature_engineered(investigation_priority);


SELECT indexname
FROM pg_indexes
WHERE schemaname='fraud';


-- SELECT COUNT(*) FROM fraud.transactions_feature_engineered;
SELECT * FROM  fraud.transactions_feature_engineered LIMIT 5 ;
-- SELECT indexname FROM pg_indexes WHERE schemaname='fraud';

-- Kya CSV successfully import hua?

-- Kya fraud schema create hua?

-- Kya indexes successfully create hue?