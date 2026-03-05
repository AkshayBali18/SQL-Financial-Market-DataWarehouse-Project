/*
===============================================================================
 Create Gold Views
===============================================================================
Purpose:
    Creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Clean layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- Create Dimension: gold.dim_company

create view gold.dim_company as

select 
row_number() over(order by f.company_id) company_key,
f.company_id,
f.company_name,
c.rating_code as credit_rating_code,
case
when c.rating_code in('AAA','AA','A','BBB') then 'Investment Grade'
else 'Speculative Grade'                    -
end credit_grade,
c.rating_date as credit_rating_date,
b.issue_date as bond_issue_date,
b.maturity_date as bond_maturity_date,
datediff(year,b.issue_date,b.maturity_date) bond_period_YY
from clean.src_credit_ratings c
left join clean.src_bonds b
on c.company_id=b.company_id 
left join clean.src_company_financials f
on f.company_id=c.company_id

-- Create Dimension: gold.fact_financials

create view gold.fact_financials as

select c.company_key,
f.fiscal_year,
f.revenue,
f.net_income,
f.total_debt,
f.total_equity,
f.interest_expense,
f.ebit
from clean.src_company_financials f
left join gold.dim_company c
on f.company_id=c.company_id
