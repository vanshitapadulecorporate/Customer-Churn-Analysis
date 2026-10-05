create database customer_chrun;
use customer_chrun;


create table customers (
    customerID varchar(20),
    gender varchar(10),
    SeniorCitizen int,
    Partner varchar(10),
    Dependents varchar(10),
    tenure int,
    PhoneService varchar(10),
    MultipleLines varchar(30),
    InternetService varchar(30),
    OnlineSecurity varchar(30),
    OnlineBackup varchar(30),
    DeviceProtection varchar(30),
    TechSupport varchar(30),
    StreamingTV varchar(30),
    StreamingMovies varchar(30),
    Contract varchar(30),
    PaperlessBilling varchar(10),
    PaymentMethod varchar(50),
    MonthlyCharges decimal(10,2),
    TotalCharges decimal(10,2),
    Churn varchar(10)
);

#How many customers have churned?
select*from customers;
select Churn, count(*) as customer_count from customers group by Churn;

#What is the overall churn rate?
select count(case when Churn = 'Yes' then  1 end) as churned_customers,
    count(*) as total_customers,
    round(count(case when Churn = 'Yes' then  1 end) * 100.0 / count(*),2) as churn_rate
from customers;


#Is churn higher for month-to-month customers?
select Contract,
    count(*) as total_customers,
    sum(case when Churn = 'Yes' then  1 else  0 end ) as churned_customers,
    round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by Contract
order by churn_rate desc;

#Is churn higher among customers with short tenure?
select case
when tenure <= 12 then '0-12 months'
when tenure <= 24 then '13-24 months'
when tenure <= 48 then '25-48 months'
else '49+ months'
end as tenure_group,
count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by tenure_group
order by churn_rate desc;

#Does internet service type have a relationship with churn?
select InternetService, count(*) AS total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by InternetService
order by churn_rate desc;

#Does the payment method have any relationship with customer churn?
select PaymentMethod,
count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by PaymentMethod
order by churn_rate desc;

#Churn by Tech Support
select TechSupport,
count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by TechSupport
order by churn_rate desc;

#Churn by Monthly Charges
select
case when MonthlyCharges < 30 THEN 'Low (<30)'
when MonthlyCharges < 70 THEN 'Medium (30-70)'
else 'High (70+)'
end as charge_group,
count(*) as total_customers,
sum(case when Churn = 'Yes' then  1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by charge_group
order by churn_rate desc;

#Churn by Online Security.
select OnlineSecurity,
count(*) as total_customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as churned_customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as churn_rate
from customers
group by OnlineSecurity
order by churn_rate desc;	

#Is churn higher among senior citizens?
select
case when SeniorCitizen = 1 then 'Senior Citizen'
else 'Non-Senior Citizen'
end as Customer_Group,
count(*) as Total_Customers,
sum(case when Churn = 'Yes' then 1 else 0 end) as Churned_Customers,
round(sum(case when Churn = 'Yes' then 1 else 0 end) * 100.0 / count(*),2) as Churn_Rate
from customers
group by SeniorCitizen;









