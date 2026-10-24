USE customer_churn_analysis;

-- Check for hidden carriage returns in Churn

select 
hex(Churn) as churn_hex,
count(*) as customer_count
from customer_churn_analysis_raw
group by hex(Churn);

-- Check missing TotalCharges
select count(*) as missing_total_charges
from customer_churn_analysis_raw
where TotalCharges is null;

-- Verify the customer count
select count(*) as total_customers
from customer_churn_analysis_raw;