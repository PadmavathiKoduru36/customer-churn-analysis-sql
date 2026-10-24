# Customer Churn Analysis — Business Insights Report

## 1. Project Objective
Analyze customer churn patterns using MySQL and identify customer groups that may need retention-focused attention.

## 2. Dataset
- Dataset: Telco Customer Churn
- Total customer records: 7,043
- Database: MySQL

## 3. Key Findings

| Contract Type | Total Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| Month-to-month | 3,875 | 1,655 | 42.71% |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

Month-to-month customers have the highest observed churn rate, while two-year contract customers have the lowest.

## 4. Recommendations
- Investigate the reasons for month-to-month customer churn.
- Evaluate targeted retention offers.
- Assess whether longer-term contract options improve retention.
- Monitor churn rates regularly to evaluate retention efforts.

## 5. Data Quality
- Checked total record count and duplicate customer IDs.
- Identified 11 missing TotalCharges values.
- Accounted for carriage-return characters in the Churn field during analysis.

## 6. Limitations
The analysis identifies associations, not causes. Monthly charges associated with churned customers are not confirmed lost revenue or profit.

## 7. Tools and Skills
MySQL, SQL aggregations, conditional logic, data quality checks, business analysis, Git, GitHub, and VS Code.
