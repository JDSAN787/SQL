
start : '\\Mac\Home\Documents\3304_Project2_jds.txt'

--create  the output file (this is what you'll print and turn in)
spool : '\\Mac\Home\Documents\3304_Project3_jds.txt'

--log all innputs (SQL statement) and output (feedback from orcle) to spooled text file
set echo on


/*Joan Sanchez
3304-001
Project 3
*/

--Part 1
--1. All column headings must show in their entirety--no truncated column headings.
--(a) alfa character
--This will be for character 

COLUMN CustType FORMAT a10 --"a10" is the amount of space in the title
COLUMN RateType FORMAT a9


-- 6. 
INSERT INTO RESERVATION_jds
--the first add
VALUES ((SELECT MAX (ResNum) FROM RESERVATION_jds) +1, (1012, '24-SEP-2022', '26-SEP-2022', 101, 23, 2, 'S')

/*Add ResDetail using the OrderID for the new Order above:
RoomNum RateAmt
   224  $109

Note: you'll    */
   
 

INSERT INTO RESDETAIL_jds
VALUES ((SELECT MAX (ResNum) FROM RESERVATION_jds), 224, 109); 


--7. 	Like 6

--8.Change the phone number for Customer B200 to 817-555-8918. (LIKE PROJECT 2) UPDATE


--Part 2
/* 10. List the first name, last name, sales rep ID, commission class, and commission rate for all Sales 
Reps.  

Combine the first and last name into one column (include a space between them). 

 Sort by 
last name in ascending order, and use the following column headings:  SalesRep Name, Sales Rep 
ID, Commission Class, Commission Rate.*/ 

 --1 
 SELECT AgentFName, AgentLName, AgentID, A,DeptID, DeptID
	* FROM AGENT_jds A, DEPT_jds --getting info from two different TABLES
 WHERE CommClass = CommClass = COMMCLASS_jds.CommClass; 
 ORDER BY ; 
 
 --dot notation is need it when part info is find in two different tables
 
