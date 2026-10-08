# Suggested Power BI Measures

```DAX
Customers =
DISTINCTCOUNT('Customer Churn'[customer_id])

Churned Customers =
CALCULATE([Customers], 'Customer Churn'[churn] = "Yes")

Churn Rate =
DIVIDE([Churned Customers], [Customers], 0)

Monthly Revenue =
SUM('Customer Churn'[monthly_charges])

Revenue at Risk =
CALCULATE([Monthly Revenue], 'Customer Churn'[churn] = "Yes")

Average Monthly Charge =
AVERAGE('Customer Churn'[monthly_charges])

Average Tenure =
AVERAGE('Customer Churn'[tenure_months])
```