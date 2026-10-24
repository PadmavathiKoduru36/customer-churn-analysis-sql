-- 1 Overall churn rate

USE customer_churn_analysis;
select Churn,
count(*) as customer_count,
round(
    count(*) * 100.0 / (select count(*) from customer_churn_analysis_raw),
    2
) as percentage
from customer_churn_analysis_raw
group by Churn;


-- 2 Churn rate by contract type
select Contract,
count(*) as totall_customers,
 SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by Contract
order by churn_rate_percentage desc;

-- 3 Churn by tenure group
SELECT
    CASE
        when tenure <= 12 then '0-12 months'
        when tenure <= 24 then '13-24 months'
        when tenure <= 48 then '25-48 months'
        else '49-72 months'
    end as tenure_group,
    count(*) as total_cutomers,
	SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by tenure_group
order by min(tenure);

-- 4 Churn by monthly charges
select 
    CASE
        when MonthlyCharges < 35 then 'Low Charges'
        when MonthlyCharges < 70 then 'Medium Charges'
        else 'High Charges'
    end as charge_group,
    count(*) as total_cutomers,
     SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by charge_group
order by churn_rate_percentage desc;

-- 5 Churn analysis by payment method
select PaymentMethod,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by PaymentMethod
order by churn_rate_percentage desc;

-- 6 Churn analysis by internet service
select InternetService,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by InternetService
order by churn_rate_percentage desc;

-- 7 Churn analysis by online security
select OnlineSecurity,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by OnlineSecurity
order by churn_rate_percentage desc;


-- 8 Churn analysis by tech support
select TechSupport,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by TechSupport
order by churn_rate_percentage desc;

-- 9 Monthly charges associated with churned customers
SELECT
count(*) as churned_customers,
round(sum(MonthlyCharges),2) as monthly_charges_at_risk,
round(avg(MonthlyCharges),2) as average_monthly_charges,
round(sum(MonthlyCharges) * 12,2) as annualized_charges_at_risk
from customer_churn_analysis_raw
where replace(Churn, char(13), '') = 'Yes';

-- 10 Business Summary: Churn analysis by Contract
select Contract,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage,
round(sum(case when replace(Churn, char(13), '') = 'Yes'
      then monthlycharges
      else 0
      end),2) as monthly_charges_from_churned_customers
      from customer_churn_analysis_raw
      group by Contract
      order by churn_rate_percentage desc;

-- 11 Rank contract types by churn rates
With contract_churn as (
select Contract,
count(*) as total_customers,
SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    )
as churn_rate_percentage
from customer_churn_analysis_raw
group by Contract    
) 
select 
    Contract,
    total_customers,
    churned_customers,
    churn_rate_percentage,
    dense_rank() over(order by churn_rate_percentage desc) as churn_rate_rank
    from contract_churn
    order by churn_rate_rank;


-- 12 Customer retention priority by contract
select 
    contract,
    count(*) as total_customers,
    SUM(REPLACE(Churn, CHAR(13), '') = 'Yes') AS churned_customers,
    ROUND(
        SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*),
        2
    ) as churn_rate_percentage,
    case 
        when SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*) >= 30 
            then "High Priority"
        when SUM(REPLACE(Churn, CHAR(13), '') = 'Yes')
        * 100.0 / COUNT(*) >= 10 
            then "Medium Priority"
        else "Low Priority"
    end as retention_priority
from customer_churn_analysis_raw
group by Contract
order by churn_rate_percentage desc;


-- BUSINESS INSIGHTS
-- 1. Overall churn rate is approximately 26.54%.
-- 2. Compare churn rates across contract types.
-- 3. Compare churn rates across customer tenure groups.
-- 4. Compare churn rates across monthly charge groups.
-- 5. Investigate customer retention opportunities using these results.

