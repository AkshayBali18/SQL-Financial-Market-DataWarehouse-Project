/*
===============================================================================
Data Cleaning: Clean the data of (src_bonds) for loading into next layer
===============================================================================
 Purpose:
    · Data Cleansing 
    · Data Standrization 
    . Data Normalization 
    . Derived Columns 
    . Data Enrichments
===============================================================================
*/



--Data Cleaning(src_bonds )---
--finding duplicate primary key--

select bond_id,
count(*)
from finance.src_bonds
group by bond_id
having count(*)>1

--Getting latest primary key(No duplicate)--
select* from(
select 
*,
ROW_NUMBER () over (partition by bond_id,company_id order by bond_id desc)flag
from finance.src_bonds)t
where flag=1
  

  --Check for Negative or Invalid Financial Values
select * 
from finance.src_bonds
where coupon_rate<=0 


--Handle NULL Values
select 
 *
    from finance.src_bonds
    where bond_id is null
or company_id is null
or issue_date is null
or maturity_date is null
or coupon_rate is null

--Remove Invalid Dates
--Example: issue date < maturity date

select *
from finance.[src_bonds ]
where issue_date > maturity_date




--Data Normalization
--Removing Unwanted Decimals
select round(coupon_rate,2)coupon_rate
from finance.src_bonds
