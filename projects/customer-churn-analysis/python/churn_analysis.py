import pandas as pd

df = pd.read_csv("customer_churn.csv")
df.columns = [c.strip().lower().replace(" ", "_") for c in df.columns]
df = df.drop_duplicates()

churn_rate = df["churn"].eq("Yes").mean()
revenue_at_risk = df.loc[df["churn"].eq("Yes"), "monthly_charges"].sum()

summary = (
    df.groupby("contract_type")
      .agg(
          customers=("customer_id", "count"),
          churn_rate=("churn", lambda s: s.eq("Yes").mean()),
          avg_monthly_charges=("monthly_charges", "mean")
      )
      .reset_index()
)

print("Overall churn rate:", churn_rate)
print("Monthly revenue at risk:", revenue_at_risk)
print(summary)