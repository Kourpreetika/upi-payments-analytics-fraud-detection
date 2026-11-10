-- Monthly transaction performance

WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC(
    'month',
    TO_DATE(transaction_date, 'YYYY-MM-DD')
)::date AS month,
        COUNT(*) AS total_transactions,
        SUM(transaction_amount) AS total_value,

        COUNT(*) FILTER (
            WHERE transaction_status = 'Success'
        ) AS successful_transactions,

        COUNT(*) FILTER (
            WHERE transaction_status = 'Failed'
        ) AS failed_transactions

    FROM upi_transactions
    GROUP BY 1
),

monthly_analysis AS (
    SELECT
        *,
        ROUND(
            successful_transactions * 100.0 /
            NULLIF(total_transactions, 0),
            2
        ) AS success_rate,

        LAG(total_transactions) OVER (
            ORDER BY month
        ) AS previous_month_transactions

    FROM monthly_metrics
)

SELECT
    month,
    total_transactions,
    total_value,
    successful_transactions,
    failed_transactions,
    success_rate,

    ROUND(
        (total_transactions - previous_month_transactions)
        * 100.0 /
        NULLIF(previous_month_transactions, 0),
        2
    ) AS month_over_month_growth

FROM monthly_analysis
ORDER BY month;