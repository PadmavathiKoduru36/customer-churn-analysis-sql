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


-- BUSINESS INSIGHTS
-- 1. Overall churn rate is approximately 26.54%.
-- 2. Compare churn rates across contract types.
-- 3. Compare churn rates across customer tenure groups.
-- 4. Compare churn rates across monthly charge groups.
-- 5. Investigate customer retention opportunities using these results.

