/*
===============================================================================
Data Cleaning: Clean the data of (src_credit_ratings) for loading into next layer
===============================================================================
 Purpose:
    · Data Cleansing 
    · Data Standrization 
    . Data Normalization 
    . Derived Columns 
    . Data Enrichments
===============================================================================
*/




--finding duplicate primary key--
select rating_id,
count(*)
from finance.[src_credit_ratings ]
group by rating_id
having count(*)>1

--Getting latest primary key(No duplicate)--
select* from(
select 
*,
ROW_NUMBER () over (partition by rating_id,company_id order by rating_id desc)flag
from finance.[src_credit_ratings ])t
where flag=1
  
--Handle NULL Values
select 
 *
    from finance.[src_credit_ratings ]
    where rating_id is null 
    or company_id is null 
    or rating_code is null 
    or rating_date is null

--Remove Invalid Records
--Example: Date Greater then today date

select *
from finance.[src_credit_ratings ]
where rating_date>getdate()


--Data Standardization
--Standardize Rating Code

select rating_code
from finance.[src_credit_ratings ]
where rating_code != trim(rating_code)

--IF found then trim and put it in UPPER()
select 
case
when rating_code != trim(rating_code) then upper(trim(rating_code))
else rating_code
end rating_code
from finance.[src_credit_ratings ]



