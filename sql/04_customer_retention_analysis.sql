-- Customer Retention and Churn Analysis

WITH customer_activity AS (

    SELECT
        customer_id,

        MIN(transaction_date::date) AS first_transaction,

        MAX(transaction_date::date) AS last_transaction,

        COUNT(*) AS total_transactions,

        SUM(transaction_amount) AS lifetime_value

    FROM upi_transactions

    GROUP BY customer_id
),

retention_segments AS (

    SELECT
        *,

        DATE '2024-01-01' - last_transaction
            AS days_inactive,

        CASE

            WHEN last_transaction >= DATE '2023-10-01'
                THEN 'Active Customers'

            WHEN last_transaction >= DATE '2023-07-01'
                THEN 'At Risk Customers'

            ELSE 'Churned Customers'

        END AS retention_segment

    FROM customer_activity
)

SELECT
    retention_segment,

    COUNT(*) AS total_customers,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS customer_percentage,

    ROUND(
        AVG(total_transactions)::numeric,
        2
    ) AS avg_transactions,

    ROUND(
        AVG(lifetime_value)::numeric,
        2
    ) AS avg_customer_lifetime_value

FROM retention_segments

GROUP BY retention_segment

ORDER BY total_customers DESC;