import pandas as pd
from pathlib import Path

data_dir = Path("data/processed")
output_dir = Path("powerbi")
output_dir.mkdir(exist_ok=True)

datasets = {
    "Monthly_Trends": "monthly_trends.csv",
    "Payment_Performance": "payment_performance.csv",
    "Fraud_Analysis": "fraud_analysis.csv",
    "Customer_Segments": "customer_segments.csv",
    "Customer_RFM": "customer_rfm_segments.csv",
    "Cohort_Counts": "cohort_customer_counts.csv",
    "Cohort_Retention": "cohort_retention_matrix.csv"
}

output_file = output_dir / "upi_analytics_dashboard_data.xlsx"

with pd.ExcelWriter(output_file, engine="openpyxl") as writer:

    for sheet_name, filename in datasets.items():

        file_path = data_dir / filename

        if not file_path.exists():
            print(f"Missing file: {filename}")
            continue

        df = pd.read_csv(file_path)

        df.to_excel(
            writer,
            sheet_name=sheet_name,
            index=False
        )

        print(f"Added {sheet_name}: {len(df)} rows")

print("\nPower BI workbook created successfully!")
print(f"Location: {output_file}")