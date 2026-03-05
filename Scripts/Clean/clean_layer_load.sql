/*
===============================================================================
 Load Clean Layer 
===============================================================================
Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'Clean' schema tables from the 'Finance' schema.
	Actions Performed:
		- Inserts transformed and cleansed data from Finance into Clean tables.

===============================================================================
*/


 
 --Inserting into clean.src_company_financials
 --a) Data Cleaning
 --b) Insert clean data into second layer(Clean)


select company_id,
case
when company_name != trim(company_name) then upper(trim(company_name))   --Standardize Company Name
else company_name
end company_name,
fiscal_year,
round(revenue,0)revenue,
round(net_income,0)net_income,
round(total_debt,0)total_debt,
round(total_equity,0)total_equity,
round(interest_expense,1)intrest_expense,
round(ebit,0)ebit                          --Removing Unwanted Decimals
from finance.src_company_financials

--Inserting into clean.src_credit_ratings
 --a) Data Cleaning
 --b) Insert clean data into second layer(Clean)


select rating_id,
company_id,
case
when rating_code != trim(rating_code) then upper(trim(rating_code))  
else rating_code
end rating_code,                                                 --Standardize rating code
from finance.[src_credit_ratings ],
rating_date
from finance.src_credit_ratings

--Inserting into clean.src_bonds
 --a) Data Cleaning
 --b) Insert clean data into second layer(Clean)

select bond_id,
company_id,
issue_date,
maturity_date,
concat(round(coupon_rate,2),'%')coupon_rate   --Data Normalization--Removing Unwanted Decimals And Adding % for Understanding---
from finance.[src_bonds ]





