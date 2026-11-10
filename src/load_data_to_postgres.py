
import pandas as pd
from sqlalchemy import create_engine

# 1. Connect to PostgreSQL
engine = create_engine(
    "postgresql+psycopg2://preetikakour@localhost:5432/upi_payments_analytics"
)

# 2. Load cleaned dataset
df = pd.read_csv(
    "data/processed/upi_transactions_cleaned.csv"
)

print("Dataset loaded successfully!")
print("Total records:", len(df))
print("Starting database import...", flush=True)

# 3. Import in batches with visible progress
batch_size = 5000
total_records = len(df)

for start in range(0, total_records, batch_size):

    batch = df.iloc[start:start + batch_size]

    batch.to_sql(
        name="upi_transactions",
        con=engine,
        if_exists="replace" if start == 0 else "append",
        index=False,
        method=None
    )

    loaded = min(start + len(batch), total_records)

    print(
        f"Imported {loaded:,} / {total_records:,} records",
        flush=True
    )

# 4. Close connection
engine.dispose()

print("\nDatabase import completed successfully!")
