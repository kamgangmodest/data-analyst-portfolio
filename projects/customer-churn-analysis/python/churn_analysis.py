import pandas as pd

df = pd.read_csv("../data/customer_churn.csv")
df = df.drop_duplicates()

df["monthly_charges"] = pd.to_numeric(df["monthly_charges"], errors="coerce")
df["total_charges"] = pd.to_numeric(df["total_charges"], errors="coerce")

customer_count = df["customer_id"].nunique()
churn_rate = df["churn"].eq("Yes").mean()
monthly_revenue = df["monthly_charges"].sum()
revenue_at_risk = df.loc[df["churn"].eq("Yes"), "monthly_charges"].sum()

print(f"Customers: {customer_count:,}")
print(f"Churn rate: {churn_rate:.1%}")
print(f"Monthly revenue: {monthly_revenue:,.2f}")
print(f"Revenue at risk: {revenue_at_risk:,.2f}")

def churn_summary(field):
    return (
        df.groupby(field)
          .agg(
              customers=("customer_id", "nunique"),
              churned=("churn", lambda s: s.eq("Yes").sum()),
              avg_monthly_charge=("monthly_charges", "mean"),
              monthly_revenue=("monthly_charges", "sum")
          )
          .assign(churn_rate=lambda x: x["churned"] / x["customers"])
          .sort_values("churn_rate", ascending=False)
    )

print(churn_summary("contract_type"))
print(churn_summary("payment_method"))
print(churn_summary("internet_service"))
print(churn_summary("tech_support"))

df["tenure_band"] = pd.cut(
    df["tenure_months"],
    bins=[-1, 12, 24, 48, 999],
    labels=["0-12", "13-24", "25-48", "49+"]
)
print(churn_summary("tenure_band"))
