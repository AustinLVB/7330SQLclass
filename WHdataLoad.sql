
/* Create DB. Run 1x only*/
create database WHdata;

/*Set DB. Run each time.*/
use WHdata;

/*Create Table of Salary data. Primary Key is ID*/
create table SalaryData2 (
ID mediumint not null auto_increment,
EmployeeName varchar (50),
EmployeeStatus varchar (15),
Salary decimal (10,2),
PayBasis varchar (15),
PositionTitle varchar (250),
Primary key (ID)
);


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

/*Data dump to ensure we got the whole file. Confirmed.*/
Select * 
from SalaryData2;
