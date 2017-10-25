
/* Create DB. Run 1x only*/
create database WHdata;

/*Set DB. Run each time.*/
use WHdata;


create table SalaryData4 (
ID mediumint not null auto_increment,
EmployeeName varchar (50),
EmployeeStatus varchar (15),
Salary text,
PayBasis varchar (15),
PositionTitle varchar (250),
Primary key (ID)
);
/*Select SalaryData4.Salary convert (SalaryData4.Salary, decimal(10,2));

select ID
       CAST(REPLACE(REPLACE(IFNULL(Salary,0),',',''),'$','') AS DECIMAL(10,2)) as SalaryFloat
FROM SalaryData2
WHERE CAST(REPLACE(REPLACE(IFNULL(Salary,0),',',''),'$','') AS DECIMAL(10,2)) >0*/

/* Load command in CLI in case need it again.
NOTE - I DELETED THE COLUMN HEADER ROW IN THE .CSV FILE SO NO SKIP
OR IGNORE STATEMENT IN THIS LOAD COMMAND.
 ALSO CHANGED Salary type
from Currency to 'General Number' with 2 decimal point precision in the .CSV file BEFORE
importing.

load data local infile '/Users/laurabishop/Desktop/WHdataCSV.csv' into 
table WHdata.SalaryData2 
fields terminated by ',' 
enclosed by '"' 
Lines terminated by '\n' 
(EmployeeName, EmployeeStatus, Salary, PayBasis, PositionTitle);

*/
load data local infile '/Users/laurabishop/Desktop/WHdataCSV.csv' into 
table WHdata.SalaryData4
fields terminated by ',' 
enclosed by '"' 
Lines terminated by '\n' 
(EmployeeName, EmployeeStatus, Salary, PayBasis, PositionTitle);


/*Data dump to ensure we got the whole file. Confirmed.*/
Select *
from SalaryData4;

/*Pull All Unique Titles To See Patterns*/
Select Distinct SalaryData4.PositionTitle as Title
From SalaryData4
order by Title asc;

Select PositionTItle, Salary 
from SalaryData4;

/*Output all positions with Assistant in the name.*/

SELECT EmployeeName, EmployeeStatus, PositionTItle, Salary as Pay
from SalaryData4 
WHERE PositionTItle LIKE '%Assistant%'
Order By Pay asc;

    
/*Count number of Salaries for title) DO NOT PUT SPACE BETWEEN COUNT & ( */ 
 Select COUNT(Salary)
    From SalaryData4
    Where PositionTItle LIKE '%Assistant%';
    
/*Salary Average*/
SELECT PositionTitle, AVG(salary) 
FROM SalaryData4
Where PositionTItle LIKE '%Assistant%'
Group By PositionTItle;

/*Salary Min & Max*/
Select PositionTItle,  Min(Salary)
from SalaryData4
Where PositionTItle LIKE '%Assistant%'
Group By PositionTItle;

 Select PositionTItle,  Max(Salary)
from SalaryData4
Where PositionTItle LIKE '%Assistant%'
Group By PositionTItle;
 
 /*All combined Salary Min, Max, Average to show up on 1 output*/
 Select PositionTitle, 
   max(Salary) as max,
   min(Salary) as min,
   avg(Salary) as avg
from SalaryData4
Where PositionTItle LIKE '%Assistant%'
Group By PositionTItle;  