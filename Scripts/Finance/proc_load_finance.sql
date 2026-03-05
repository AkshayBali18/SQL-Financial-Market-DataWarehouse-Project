/*
===============================================================================
 Load Finance Layer (Source -> Finance)
===============================================================================
 Purpose:
    This is the procedure of loading the data into the 'Finance' schema from external CSV files. 
    It performs the following action:
    - Uses the `BULK INSERT` command to load data from csv Files to Finance tables.

===============================================================================
*/


--Insert data by directly through Object Explorer (Shortcut)
-- OR
--By BULK INSERT (Systematic Approch) the csv file 

bulk insert finance.scr_comapany_financials
from '"C:\Users\anshb\Downloads\company_financials_200 (1).csv"'
with(
firstrow=2,
fieldterminator = ',',
tablock)

bulk insert finance.src_credit_ratings
from '"C:\Users\anshb\Downloads\src_credit_ratings.csv"'
with(
firstrow=2,
fieldterminator = ',',
tablock)

bulk insert finance.scr_bonds
from '"C:\Users\anshb\Downloads\scr_bonds.csv"'
with(
firstrow=2,
fieldterminator = ',',
tablock)
