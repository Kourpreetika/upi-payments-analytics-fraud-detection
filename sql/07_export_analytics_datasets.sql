COPY (
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
                WHERE transaction_status = 'Success'
            ) * 100.0 / COUNT(*), 2
        ) AS success_rate
    FROM upi_transactions
    GROUP BY transaction_type
) TO STDOUT WITH CSV HEADER;