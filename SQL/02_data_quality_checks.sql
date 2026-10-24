USE customer_churn_analysis;

-- 1 Total number of customers
select count(*) as total_customers
from customer_churn_analysis_raw;

-- 2 Duplicate customer IDs
select customerID,
count(*) as record_count
from customer_churn_analysis_raw
group by customerID
having count(*) > 1;

-- 3 Missing customer IDs
select count(*) as missing_customer_IDs
from customer_churn_analysis_raw
where customerID is NULL
or trim(customerID) = '';

-- 4 Missing Total charges
select count(*) as missing_total_charges
from customer_churn_analysis_raw
where TotalCharges is null;

-- 5 Customer churn distribution
select Churn,
count(*) as customer_churn_count
from customer_churn_analysis_raw
group by Churn
ORDER BY customer_churn_count desc;

-- 6 Check contract distribution
select Contract,
count(*) as contract_count
from customer_churn_analysis_raw
group by Contract
order by contract_count desc;