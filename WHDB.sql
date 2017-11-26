
/******** DB Schema Loading and Set Up********/
create database WHDB;

/****For re-entry into db *****/
use WHDB;

/******If you need to start a fresh, be sure to drop the tables ******/

drop table Employee;
drop table SalaryTable;

/*****Temp Table for loading Data ******/
create table TempHolding1
( ID mediumint not null auto_increment,
EmployeeName varchar(100),
EmployeeStatus varchar(25),
Salary int,
PayBasis varchar(25),
PositionTitle varchar(250),
primary key (ID)
);

/******Load Data into TempHolding1  NEED TO CHANGE THIS LOCATION TO WHEREVER YOU PLACE THE FILE******/
load data local infile '/Users/laurabishop/Desktop/WHData1CSV.csv' into 
table TempHolding1
fields terminated by ',' 
enclosed by '"' 
Lines terminated by '\n' 
(EmployeeName, EmployeeStatus, Salary, PayBasis, PositionTitle);

select * from TempHolding1;

/*****Create SalaryTable*******/


create table SalaryTable 
(SID mediumint,
PayBasis varchar(25),
Salary int,
Primary key (SID)
);

/*********Create Employee Table ******/
create table Employee (
EID mediumint,
EmployeeName varchar (100),
EmployeeStatus varchar (25),
PositionTitle varchar (250),
Salary_ID mediumint, 
Primary key (EID),
Foreign key (Salary_ID) References SalaryTable(SID)
);



/******** Populate SalaryTable and Employee table with content from .csv ********/

BEGIN;
INSERT INTO Employee (EID, EmployeeName, EmployeeStatus, PositionTitle) 
   SELECT TempHolding1.ID, TempHolding1.EmployeeName, TempHolding1.EmployeeStatus, TempHolding1.PositionTitle
   FROM TempHolding1;
COMMIT;
/****Test to see if works *****/
select * from Employee;

BEGIN;
Insert into SalaryTable (SID, Salary, PayBasis)
 Select TempHolding1.ID, TempHolding1.Salary, TempHolding1.PayBasis
 From TempHolding1;
 

 Commit;
 
 
 
 select * from SalaryTable;
 
 /*****Delete TempHolding1 Table ******/
 Drop table TempHolding1;
 
 
 
 /********ANALYSIS********/
 
 /******** Understanding the Positions and Titles *********/

Select Distinct Employee.PositionTitle as Title
From Employee
order by Title asc;


/******Analysis based on Salary********/
/******Basic Joins to Test the Output *******/
Select * from Employee Inner Join SalaryTable on (Employee.EID = SalaryTable.SID);

/* Single Table with All information*/
Select * from Employee Left Join SalaryTable on (Employee.EID = SalaryTable.SID)
Union
Select * from Employee Right Join SalaryTable on (Employee.EID = SalaryTable.SID);

/* This is the Max, Min and Avg of all*/
Select MAX(Salary) as MaxPay, Min(Salary) MinPay, AVG(Salary) as AvgPay From SalaryTable;


/* Outputs TItle, Salary for Specific Title Granularity-Works*/
 SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Legislative Assistant%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Legislative Assistant%'
Group By PositionTItle;



/*Deputy Assistant*/
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Deputy Assistant%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Deputy Assistant%'
Group By PositionTItle;


/*Assistant Director */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Assistant Director%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Assistant Director%'
Group By PositionTItle;

/*Deputy Director */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Deputy Director%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '% Deputy Director%'
Group By PositionTItle;

/*Deputy Associate */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Deputy Associate%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Deputy Associate%'
Group By PositionTItle;

/* Policy Assistant*/
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Policy Assistant%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Policy Assistant%'
Group By PositionTItle;

/* Director - Assistant, Associate, Boards & Commissions, Communications, Deputy, Executive Assistant To Director, */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE  '%Director%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Director%'
Group By PositionTItle;

/* Anaylst, Senior, Records Management, Legislative, */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Analyst%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Analyst%'
Group By PositionTItle;

/*Chief of Staff - Deputy, Assistant, Special */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE '%Chief of Staff%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Chief of Staff%'
Group By PositionTItle;

/*Assistant to the President - Deputy, Special, Assistant*/
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE  '%Assistant to the President%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Assistant to the President%'
Group By PositionTItle;

/*Deputy Assistant to the President */
SELECT PositionTitle AS Title, Salary AS Pay
FROM Employee, SalaryTable
WHERE Employee.EID = SalaryTable.SID AND PositionTitle LIKE  '%Deputy Assistant to the President%'
ORDER BY PositionTitle;

SELECT PositionTitle, Count(*)
FROM Employee
Where PositionTItle LIKE '%Deputy Assistant to the President%'
Group By PositionTItle;

/*NOT WORKING AT THIS TIME */
/*SELECT Distinct EmployeeName, PositionTItle,
       (SELECT COUNT(*) 
          FROM SalaryTable
         WHERE  Employee.EID = SalaryTable.SID)
  FROM Employee;   */


    
/*Only returns list of Position Titles
SELECT Distinct PositionTItle FROM Employee, SalaryTable  WHERE Salary <> (Select AVG(Salary) From SalaryTable) 
Group by PositionTItle, Salary;*/

/* These 3 do not return the MaxPay for the Where Clause Title, rather they return the MaxPay for the whole set of entries -- 179,700.
SELECT PositionTitle, MAX(Salary) as MaxPay
FROM Employee, SalaryTable
Where PositionTItle LIKE '%Director of Special Projects and Special Assistant to the Office of the Chief of Staff%'
GROUP BY PositionTitle;


SELECT PositionTitle, MAX(Salary) as MaxPay
FROM Employee, SalaryTable
Where PositionTItle LIKE '%Advisor%'
GROUP BY PositionTitle;

SELECT PositionTitle, MAX(Salary) as MaxPay
FROM Employee, SalaryTable
Where PositionTItle LIKE '%Special Assistant%'  
GROUP BY PositionTitle;
*/

/* This sets up the headings but the return is empty

Select PositionTitle, Salary, Count(*), Min(Salary) as MinPay from Employee, SalaryTable
Where PositionTitle = 'ADVISOR'
Group by PositionTitle, Salary
Having Min(Salary) = Salary;
*/

/*Returns Header, Position Title, Max or Min of the whole set, not just the Position Title 
Select Distinct Salary, PositionTitle from Employee, SalaryTable
Where Salary = (
 select Min(Salary) as MinPay from SalaryTable where PositionTItle LIKE '%Director of Special Projects and Special Assistant to the Senior Advisor%' )
 group by PositionTitle, Salary
 having Min(Salary) = Salary;
 
 Select Distinct Salary, PositionTitle from Employee, SalaryTable
Where Salary = (
 select Max(Salary) as MaxPay from SalaryTable where PositionTItle LIKE '%Director of Special Projects and Special Assistant to the Senior Advisor%' )
 group by PositionTitle, Salary
 having Max(Salary) = Salary;
 */

/* No output even though no errors. Just OK...what does that mean?? 
Select Distinct Salary, PositionTitle from Employee, SalaryTable
Where Salary = (
	select Max(Salary) as MaxPay from SalaryTable 
	where PositionTItle LIKE '%Director of Special Projects and Special Assistant to the Senior Advisor%' 
	group by PositionTitle, Salary
	having Max(Salary) = Salary)
 Group by PositionTitle, Salary;
*/


/*Where PositionTItle LIKE '%Director of Special Projects and Special Assistant to the Senior Advisor%'*/


/* Outputs all Titles and the Max & Min of the whole set, not  the PositionTitle
SELECT PositionTitle, MAX(Salary) as MaxPay, MIN(Salary) as MinPay
FROM Employee, SalaryTable
GROUP BY PositionTitle;
*/


 

