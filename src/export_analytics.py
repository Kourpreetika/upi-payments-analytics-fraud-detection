import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

# Database connection
DATABASE_URL = "postgresql+psycopg2://localhost/upi_payments_analytics"

engine = create_engine(DATABASE_URL)

# Output directory
OUTPUT_DIR = Path("data/processed")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

queries = {

    "payment_performance": """
        SELECT
            transaction_type,
            COUNT(*) AS total_transactions,
            COUNT(*) FILTER (
                WHERE transaction_status = 'Success'
            ) AS successful_transactions,
            COUNT(*) FILTER (
                WHERE transaction_status = 'Failed'
            ) AS failed_transactions
        FROM upi_transactions
        GROUP BY transaction_type
    """,

    "monthly_trends": """
        SELECT
            DATE_TRUNC(
                'month',
                TO_DATE(transaction_date, 'YYYY-MM-DD')
            )::date AS month,
            COUNT(*) AS total_transactions,
            SUM(transaction_amount) AS total_value,
            COUNT(*) FILTER (
                WHERE transaction_status = 'Success'
            ) AS successful_transactions
        FROM upi_transactions
        GROUP BY 1
        ORDER BY 1
    """,

    "fraud_analysis": """
        SELECT
            state,
            COUNT(*) AS total_transactions,
            COUNT(*) FILTER (
                WHERE is_fraud = 1
            ) AS fraud_count,
            ROUND(
                COUNT(*) FILTER (
                    WHERE is_fraud = 1
                ) * 100.0 / COUNT(*), 3
            ) AS fraud_rate
        FROM upi_transactions
        GROUP BY state
    """,

    "customer_segments": """
        SELECT
            customer_id,
            COUNT(*) AS total_transactions,
            SUM(transaction_amount) AS total_spending
        FROM upi_transactions
        GROUP BY customer_id
    """
}

for name, query in queries.items():

    df = pd.read_sql(query, engine)

    output_path = OUTPUT_DIR / f"{name}.csv"

    df.to_csv(output_path, index=False)

    print(f"Exported {name}: {len(df)} rows")

engine.dispose()

print("All analytics datasets exported successfully!")