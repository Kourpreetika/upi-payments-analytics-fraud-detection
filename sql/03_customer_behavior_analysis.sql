-- Customer Behaviour and Spending Analysis

WITH customer_metrics AS (

    SELECT
        customer_id,

        COUNT(*) AS total_transactions,

        SUM(transaction_amount) AS total_spending,

        AVG(transaction_amount) AS avg_transaction_value,

        COUNT(*) FILTER (
            WHERE transaction_status = 'Success'
        ) AS successful_transactions,

        COUNT(*) FILTER (
            WHERE transaction_status = 'Failed'
        ) AS failed_transactions,

        MIN(transaction_date::date) AS first_transaction,

        MAX(transaction_date::date) AS last_transaction

    FROM upi_transactions
    GROUP BY customer_id
),

customer_analysis AS (

    SELECT
        *,

        ROUND(
            successful_transactions * 100.0 /
            NULLIF(total_transactions, 0),
            2
        ) AS customer_success_rate,

        CURRENT_DATE - last_transaction AS days_since_last_transaction

    FROM customer_metrics
)

SELECT
    customer_id,
    total_transactions,
    ROUND(total_spending::numeric, 2) AS total_spending,
    ROUND(avg_transaction_value::numeric, 2) AS avg_transaction_value,
    customer_success_rate,
    days_since_last_transaction,

    CASE
        WHEN total_transactions >= 15 THEN 'High Frequency'
        WHEN total_transactions >= 7 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS customer_segment

FROM customer_analysis

ORDER BY total_spending DESC
LIMIT 100;