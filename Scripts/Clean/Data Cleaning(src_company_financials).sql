/*
======================================================================================
Data Cleaning: Clean the data of (src_company_financials) for loading into next layer
======================================================================================
 Purpose:
    · Data Cleansing 
    · Data Standrization 
    . Data Normalization 
    . Derived Columns 
    . Data Enrichments
=======================================================================================
*/

--finding duplicate primary key--

select company_id ,
count(*)
from finance.src_company_financials
group by company_id
having count(*)>1

--Getting latest primary key(No duplicate)--
select* from(
select 
*,
ROW_NUMBER () over (partition by company_id,fiscal_year order by company_id desc)flag
from finance.src_company_financials)t
where flag=1
  

  --Check for Negative or Invalid Financial Values
select * 
from finance.src_company_financials
where revenue<=0 or total_equity<=0 or interest_expense<=0


--Handle NULL Values
select 
  revenue = ISNULL(revenue, 0),
    net_income = ISNULL(net_income, 0),
    total_debt = ISNULL(total_debt, 0),
    total_equity = ISNULL(total_equity, 0),
    interest_expense = ISNULL(interest_expense, 0),
    ebit = ISNULL(ebit, 0)
    from finance.src_company_financials

--Remove Invalid Records
--Example: Revenue cannot be negative.

DELETE FROM Stg_Company_Financials
WHERE revenue < 0

--Data Standardization
--Standardize Company Name
select company_name
from finance.src_company_financials
where company_name != trim(company_name)

--IF found then trim and put it in UPPER()
select 
case
when company_name != trim(company_name) then upper(trim(company_name))
else company_name
end company_name
from finance.src_company_financials

--Data Normalization
--Removing Unwanted Decimals
select round(revenue,0)revenue,
round(net_income,0)net_income,
round(total_debt,0)total_debt,
round(total_equity,0)total_equity,
round(interest_expense,1)intrest_expense,
round(ebit,0)ebit

from finance.src_company_financials

