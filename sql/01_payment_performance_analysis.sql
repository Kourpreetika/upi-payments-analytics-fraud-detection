SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(transaction_amount)::numeric, 2) AS total_transaction_value,
    ROUND(AVG(transaction_amount)::numeric, 2) AS average_transaction_value
FROM upi_transactions;
SELECT
    transaction_status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS percentage
FROM upi_transactions
GROUP BY transaction_status
ORDER BY total_transactions DESC;
SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (
        WHERE transaction_status = 'Success'
    ) AS successful_transactions,
    COUNT(*) FILTER (
        WHERE transaction_status = 'Failed'
    ) AS failed_transactions,
    ROUND(
        COUNT(*) FILTER (
            WHERE transaction_status = 'Failed'
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS failure_rate
FROM upi_transactions
GROUP BY transaction_type
ORDER BY failure_rate DESC;