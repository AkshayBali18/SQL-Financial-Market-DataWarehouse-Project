/*
===============================================================================
DDL : Create Finance Tables
===============================================================================
 Purpose:
    This script creates tables in the 'Finance' schema.
	  Run this script to define the DDL structure of 'Finance' Tables
===============================================================================
*/

--CREATE THE DATABASE

create database Financial Market_DataWarehouse

--CREATE THE FIRST SCHEMA

create schema finance

--CREATE TABLE finance.scr_comapany_financials

create table finance.scr_comapany_financials(
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
--CREATE TABLE finance.src_credit_ratings
create table finance.src_credit_ratings(
rating_id int,
company_id int,
rating_code nvarchar(50),
rating_date date
)

--CREATE TABLE finance.scr_bonds
create table finance.scr_bonds(
bond_id int,
company_id int,
issue_date date,
maturity_date date,
coupon_rate decimal(20,2)
)


