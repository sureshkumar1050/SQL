#Creating a Database 
create database customer_segment;

# Utlizing Database 
use customer_segment; 

#displaying tables 
show tables;

# Data Understanding 
select * from customer_segmentation_data;

#Cleaning 
#renaming table name 
rename table customer_segmentation_data to customer_segment;
select * from customer_segment;

#Changing data type of purchase and adding a new updated column 
ALTER TABLE customer_segment ADD COLUMN purchase_history DATE;

#Disable safe update mode temporarily for the session:
SET SQL_SAFE_UPDATES = 0;

#Updating a values in new purchase column 
UPDATE customer_segment
SET purchase_history = STR_TO_DATE(Purchase_date, '%m/%d/%Y');
Select * from customer_segment;
SET SQL_SAFE_UPDATES = 1;

#dropping a old purchase column 
ALTER TABLE customer_segment DROP COLUMN Purchase_date;

Select * from customer_segment;


#Altering the name of new column to actual name
ALTER TABLE customer_segment CHANGE purchase_history purchase_date  DATE;
describe customer_segment;

select * from customer_segment; 

#Understanding each features 

select distinct(Age) as Distinct_age from customer_segment order by age desc;

select distinct(Gender) , count(Gender) as Countno from customer_segment group by Gender;

Select distinct(Marital_status), count(Marital_status) as Marital_count from customer_segment group by Marital_status;

Select distinct(Education_level), count(Education_level) as Educated_count from customer_segment group by Education_level;

Select distinct(Geographic_info), count(Geographic_info) as Geographic_count from customer_segment group by Geographic_info order by Geographic_count desc;

select distinct(Occupation), count(Occupation) as Occupation_count from customer_segment group by Occupation order by Occupation_count desc;

select Sum(Income_level) as Total_income, Avg(Income_level), Gender from customer_segment group by Gender;

select Max(Income_level) as Max_income_level, min(Income_level) as Min_income_level from customer_segment;

Select Distinct(Interactions_customer), count(Interactions_customer) as Interaction_count from customer_segment group by Interactions_customer order by Interaction_count desc;

Select Distinct(Insurance_product), count(Insurance_product) as Product_count, Avg(Coverage_amount) as Average_coverage from customer_segment group by Insurance_product order by Average_coverage desc;

Select Max(Premium_amount) as Maximum_Premium, Min(Premium_amount) as Minimum_Premium from customer_segment;

Select Distinct(Insurance_product), count(Insurance_product) as Product_count, Avg(Premium_amount) as Average_Premium from customer_segment group by Insurance_product order by Average_Premium desc;

Select Distinct(Insurance_product), count(Insurance_product) as Product_count, Max(Premium_amount) as Max_premium, Min(Premium_amount) as Min_premium from customer_segment group by Insurance_product order by Max_premium, Min_premium desc;

Select distinct(Customer_prefrences), count(Customer_prefrences) as Contact_prefrences_count from customer_segment group by Customer_prefrences order by Contact_prefrences_count desc;

select distinct(Policy_type), count(Policy_type) as Policy_type_count, Sum(Premium_amount) as Total_premium from customer_segment group by Policy_type order by Total_premium desc;

select distinct(Policy_type), count(Policy_type) as Policy_type_count, Avg(Coverage_amount) as Average_coverage from customer_segment group by Policy_type order by Average_coverage desc;

select distinct(Preferred_Time), count(Preferred_Time) as Preferred_time_count from customer_segment group by Preferred_Time order by Preferred_time_count;

Select Max(purchase_date), min(purchase_date) from customer_segment;

Select Max(Coverage_amount), Min(Coverage_amount) from customer_segment where purchase_date between "2020-02-28" and "2022-02-28" ;

Select Max(Premium_amount) as Max_premium  , Min(Premium_amount) as Min_premium from customer_segment where purchase_date between "2020-02-28" and "2022-02-28" ;

Select Distinct(Occupation), Avg(Premium_amount) as Average_premium, Avg(Coverage_amount) as Average_coverage from customer_segment group by Occupation order by Average_premium, Average_coverage desc;

Select distinct(Segmentation_group), Avg(Premium_amount) as Average_premium, Avg(Coverage_amount) as Average_coverage from customer_segment group by Segmentation_group order by Average_premium, Average_coverage desc;

Select Max(Premium_amount) as Max_premium, Min(Premium_amount) as Min_premium from customer_segment where Customer_prefrences = "In-Person Meeting";

Select * from customer_segment; 

select Max(Coverage_amount) as Max_coverage, Min(Coverage_amount) as Min_coverage from customer_segment where Policy_type = "Group" ; 

select Max(Coverage_amount) as Max_coverage, Min(Coverage_amount) as Min_coverage from customer_segment where Policy_type = "Individual" ;

Select Max(Premium_amount) as Max_premium, Min(Premium_amount) as Min_premium, Sum(Premium_amount) as Total_premium from customer_segment where Preferred_language != "English";

Select Max(Premium_amount) as Max_premium, Min(Premium_amount) as Min_premium, Sum(Premium_amount) as Total_premium from customer_segment where Preferred_language = "English";

Select * from customer_segment;

Select Max(income_level) as Max_Income, Avg(Income_level) as Average_Income, Min(Income_level) as Min_Income from customer_segment;

#Creating a View for High income client 
Create view High_income_client as Select Customer_id, Gender, Age, Marital_status, Education_level, Income_level, Coverage_amount , Premium_amount, Policy_type, Segmentation_group from customer_segment where Income_level > 83000 ;

Select * from High_income_client;

Select Max(Premium_amount) as Max_premium , Min(Premium_amount) as Min_premium from High_income_client;

#Creating Index for Faster retrieval 
CREATE INDEX idx_age ON customer_segment (Age);
CREATE INDEX idx_income_level ON customer_segment (Income_level);

Select age, Income_level from customer_segment; 

#Age_group Segmentation 
SELECT 
    CASE 
        WHEN Age < 20 THEN 'Teenager'
        WHEN Age BETWEEN 20 AND 30 THEN 'Young Adult'
        WHEN Age BETWEEN 31 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_group,
    COUNT(*) AS count
FROM customer_segment
GROUP BY Age_group;

#Income_level , Policy type and Premium Amount 

Select distinct(Policy_type), Avg(Income_level) as Income, Avg(Premium_amount) as Average_premium from customer_segment Group by Policy_type order by Income, Average_premium ;

#Stored_Procedure 

DELIMITER //

Create Procedure GetCustomer (IN cust_id int) 
begin 
	Select * from customer_segment where customer_id = cust_id;

End //

Call GetCustomer(84966);






