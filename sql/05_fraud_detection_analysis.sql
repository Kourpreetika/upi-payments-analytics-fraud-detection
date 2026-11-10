-- Fraud Detection Analytics

-- 1. Overall fraud KPIs

SELECT
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraudulent_transactions,

    ROUND(
        COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) * 100.0 / COUNT(*),
        3
    ) AS fraud_rate,

    ROUND(
        SUM(transaction_amount) FILTER (
            WHERE is_fraud = 1
        )::numeric,
        2
    ) AS fraudulent_transaction_value

FROM upi_transactions;


-- 2. Fraud by transaction type

SELECT
    transaction_type,

    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_count,

    ROUND(
        COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) * 100.0 / COUNT(*),
        3
    ) AS fraud_rate

FROM upi_transactions

GROUP BY transaction_type

ORDER BY fraud_rate DESC;


-- 3. Fraud by state

SELECT
    state,

    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_count,

    ROUND(
        COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) * 100.0 / COUNT(*),
        3
    ) AS fraud_rate

FROM upi_transactions

GROUP BY state

ORDER BY fraud_rate DESC

LIMIT 15;


-- 4. Fraud by transaction hour

SELECT
    transaction_hour,

    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_count

FROM upi_transactions

GROUP BY transaction_hour

ORDER BY fraud_count DESC;
