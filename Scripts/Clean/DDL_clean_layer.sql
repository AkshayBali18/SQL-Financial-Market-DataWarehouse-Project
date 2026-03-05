/*
===============================================================================
DDL : Create Clean Schema & Tables
===============================================================================
Purpose:
    This script creates tables in the 'Clean' schema
	  Run this script to define the DDL structure of 'Finance' Tables
===============================================================================
*/



--Create second Schema as Clean--

create schema clean

--Create table clean.src_company_financials--

create table clean.src_company_financials(
comapny_id int,
comapny_name nvarchar(50),
fiscal_year int,
revenue decimal(20,2),
net_income decimal(20,2),
total_debt decimal(20,2),
total_equity decimal(20,2),
interest_expense decimal(20,2),
ebit decimal(20,2)
)

--Create table clean.scr_credit_ratings--

create table clean.scr_credit_ratings(
rating_id int,
company_id int,
rating_code nvarchar(50),
rating_date date
)

--Create table clean.scr_bonds--

create table clean.scr_bonds(
bond_id int,
company_id int,
issue_date date,
maturity_date date,
coupon_rate decimal(20,2)
)

