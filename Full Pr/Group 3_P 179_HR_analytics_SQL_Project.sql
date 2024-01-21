create database emp;
select * from hr1;
select * from hr2;

#Q1 Avg Attrition rate of all department
create view KPI_1
as
select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr1 ) as a
group by a.department;


#Q2 Average Hourly rate of male research scientist
create view KPI_2
as
select avg(hourlyrate) ,gender,JobRole from hr1
where JobRole='Research Scientist' and Gender="male";


#Q3 attrition rate vs monthly income stats
create view KPI_3
as
select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(b.monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,employeeid,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr1) as a
inner join hr2 as b on b.employeeid = a.employeeid
group by a.department;


#Q4 Average working years for each department
create view KPI_4
as
select a.department, format(avg(b.TotalWorkingYears),1) as Average_Working_Year
from hr1 as a
inner join hr2 as b on b.EmployeeID=a.Employeeid
group by a.department;


#Q5 Job role Vs Work life balance
create view KPI_5
as
select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr1 as a
inner join hr2 as b on b.EmployeeID = a.Employeeid
group by a.jobrole;


#Q6 Attrition rate vs last years since promotion
create view KPI_6
as
select a.JobRole,concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.YearsSinceLastPromotion),2) as Average_YearsSinceLastPromotion
from ( select JobRole,attrition,employeeid,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr1) as a
inner join hr2 as b on b.employeeid = a.employeeid
group by a.JobRole;