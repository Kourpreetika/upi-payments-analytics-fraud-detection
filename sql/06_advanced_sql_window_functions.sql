-- Rank customers by lifetime transaction value

WITH customer_metrics AS (

    SELECT
        customer_id,
        COUNT(*) AS total_transactions,
        SUM(transaction_amount) AS total_spending,
        AVG(transaction_amount) AS avg_transaction_value

    FROM upi_transactions

    WHERE transaction_status = 'Success'

    GROUP BY customer_id
),

customer_ranking AS (

    SELECT
        *,

        RANK() OVER (
            ORDER BY total_spending DESC
        ) AS spending_rank,

        DENSE_RANK() OVER (
            ORDER BY total_spending DESC
        ) AS dense_spending_rank,

        ROW_NUMBER() OVER (
            ORDER BY total_spending DESC
        ) AS customer_row_number,

        NTILE(4) OVER (
            ORDER BY total_spending DESC
        ) AS spending_quartile

    FROM customer_metrics
)

SELECT
    customer_id,
    total_transactions,
    ROUND(total_spending::numeric, 2) AS total_spending,
    ROUND(avg_transaction_value::numeric, 2) AS avg_transaction_value,
    spending_rank,
    dense_spending_rank,
    spending_quartile

FROM customer_ranking

ORDER BY spending_rank

LIMIT 100;
-- Monthly cumulative transaction value

WITH monthly_revenue AS (

    SELECT
        DATE_TRUNC(
            'month',
            TO_DATE(transaction_date, 'YYYY-MM-DD')
        )::date AS month,

        SUM(transaction_amount) AS monthly_value

    FROM upi_transactions

    WHERE transaction_status = 'Success'

    GROUP BY 1
)

SELECT
    month,

    ROUND(monthly_value::numeric, 2) AS monthly_value,

    ROUND(
        SUM(monthly_value) OVER (
            ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        )::numeric,
        2
    ) AS cumulative_transaction_value

FROM monthly_revenue

ORDER BY month;
-- Top 5 transactions within each payment method

WITH ranked_transactions AS (

    SELECT
        transaction_id,
        customer_id,
        transaction_type,
        transaction_amount,

        ROW_NUMBER() OVER (
            PARTITION BY transaction_type
            ORDER BY transaction_amount DESC
        ) AS transaction_rank

    FROM upi_transactions

    WHERE transaction_status = 'Success'
)

SELECT *

FROM ranked_transactions

WHERE transaction_rank <= 5

ORDER BY transaction_type, transaction_rank;