
--create  the output file (this is what you'll print and turn in)
spool '\\Mac\Home\Documents\3304_Project2_jds.txt'

--log all innputs (SQL statement) and output (feedback from orcle) to spooled text file
set echo on


/*Joan Sanchez
3304-001
Project 2
*/


--DROP all the tables ***in the opposite order** they're being created.

DROP TABLE ORDERDETAIL_jds;
DROP TABLE ORDER_jds;
DROP TABLE CUSTOMER_jds; 
DROP TABLE SALESREP_jds;
DROP TABLE PRODUCT_jds;
DROP TABLE DEPARTMENT_jds; 
DROP TABLE COMMISSION_jds;
DROP TABLE PRODCAT_jds;


-- IA.  Create table
CREATE TABLE PRODCAT_jds(
ProdCatID		NUMBER(1)		NOT NULL, 
ProdCatName		VARCHAR(20)		NOT NULL,
PRIMARY KEY (ProdCatID)
);

CREATE TABLE COMMISSION_jds(
CommClass		CHAR(1)			NOT NULL,
CommRate		NUMBER(2,2)		NOT NULL,
PRIMARY KEY (CommClass)
);

CREATE TABLE DEPARTMENT_jds(
DeptID			NUMBER(2)		NOT NULL,			
DeptName		VARCHAR(15)		NOT NULL,
PRIMARY KEY (DeptID)
);


--With foreing keys


CREATE TABLE PRODUCT_jds(
ProdID			NUMBER(3)		NOT NULL,
ProdName		VARCHAR(20) 	NOT NULL,
ProdCatID		NUMBER(1)		NOT NULL,
ProdPrice		NUMBER(4,2)		NOT NULL,
PRIMARY KEY (ProdID),
FOREIGN KEY (ProdCatID) REFERENCES PRODCAT_jds
);


CREATE TABLE SALESREP_jds(
SalesRepID		NUMBER(3)		NOT NULL,
SalesRepFName	VARCHAR(20) 	NOT NULL,
SalesRepLName	VARCHAR(20) 	NOT NULL,
CommClass		CHAR(1)			NOT NULL,
DeptID			NUMBER(2)		NOT NULL,
PRIMARY KEY (SalesRepID),
FOREIGN KEY (CommClass) REFERENCES COMMISSION_jds,
FOREIGN KEY (DeptID) 	 REFERENCES DEPARTMENT_jds
);


CREATE TABLE CUSTOMER_jds(
CustID			CHAR(4)			NOT NULL,
CustFName		VARCHAR(10)		NOT NULL,
CustLName		VARCHAR(10) 	NOT NULL,
CustPhone		CHAR(10),
SalesRepID		NUMBER(3)		NOT NULL,
PRIMARY KEY (CustID),
FOREIGN KEY (SalesRepID) REFERENCES SALESREP_jds
);


CREATE TABLE ORDER_jds(
OrderID		NUMBER(4)	NOT NULL,
OrderDate	DATE		NOT NULL,
CustID		CHAR(4)		NOT NULL,
PRIMARY KEY (OrderID),
FOREIGN KEY (CustID) REFERENCES CUSTOMER_jds
);

--With two primary key that one of them is also a foreing key

CREATE TABLE ORDERDETAIL_jds(
OrderID		NUMBER(3)		NOT NULL,
ProdID		NUMBER(3)	 	NOT NULL,
ProdQty		NUMBER(3)		NOT NULL,
ProdPrice	Number(4,2)		NOT NULL,
PRIMARY KEY (OrderID, ProdID),
FOREIGN KEY (ProdID) REFERENCES PRODUCT_jds,
FOREIGN KEY (OrderID) REFERENCES ORDER_jds
);


-- IB. Describe the tables
--Utility statement 
DESCRIBE PRODCAT_jds
DESCRIBE COMMISSION_jds
DESCRIBE DEPARTMENT_jds
DESCRIBE PRODUCT_jds
DESCRIBE SALESREP_jds
DESCRIBE CUSTOMER_jds
DESCRIBE ORDER_jds
DESCRIBE ORDERDETAIL_jds


--PartIIA. INSERT all the data from Project 1 into the table

-- 	INSERT rows into PRODCAT_jds
INSERT INTO PRODCAT_jds
	VALUES (1, 'Hand Tools');
INSERT INTO PRODCAT_jds
	VALUES (2, 'Power Tools');
INSERT INTO PRODCAT_jds
	VALUES (4, 'Fasteners');
INSERT INTO PRODCAT_jds
	VALUES (6, 'Misc');
INSERT INTO PRODCAT_jds
	VALUES (3, 'Measuring Tool');
INSERT INTO PRODCAT_jds
	VALUES (5, 'Hardware');


-- INSERT rows into COMMISSION_jds
INSERT INTO COMMISSION_jds
	VALUES ('A', .01);
INSERT INTO COMMISSION_jds
	VALUES ('B', 0.08);
INSERT INTO COMMISSION_jds
	VALUES ('Z', 0);
INSERT INTO COMMISSION_jds
	VALUES ('C', 0.05);


--INSERT rows into DEPARTMENT_jds 
INSERT INTO DEPARTMENT_jds 
	VALUES (10, 'Store Sales');
INSERT INTO DEPARTMENT_jds
	VALUES (14, 'Corp Sales');
INSERT INTO DEPARTMENT_jds
	VALUES (16, 'Web Sales');


--INSERT rows into PRODUCT_jds 
INSERT INTO PRODUCT_jds 
	VALUES (121, 'BD Hammer', 1,7.00);
INSERT INTO PRODUCT_jds 	
	VALUES (228, 'Makita Power Drill', 2,65.00);
INSERT INTO PRODUCT_jds 
	VALUES (480, '1# BD Nails', 4,3.00);
INSERT INTO PRODUCT_jds 	
	VALUES (407, '1# BD Screws', 4,4.25);
INSERT INTO PRODUCT_jds 	
	VALUES (610, '3M Duct Tape', 6,1.75);
INSERT INTO PRODUCT_jds 	
	VALUES (618, '3M Masking Tape', 6,1.25);
INSERT INTO PRODUCT_jds 
	VALUES (380, 'Acme Yard Stick', 3,1.25);
INSERT INTO PRODUCT_jds 	
	VALUES (535, 'Schlage Door Knob', 5,7.50);
INSERT INTO PRODUCT_jds 	
	VALUES (123, 'Acme Pry Bar', 1,5.00);
INSERT INTO PRODUCT_jds 	
	VALUES (124, 'Acme Hammer', 1,6.50);
INSERT INTO PRODUCT_jds 	
	VALUES (229, 'BD Power Drill', 2,59.00);
INSERT INTO PRODUCT_jds 
	VALUES (235, 'Makita Power Drill 2', 2,65.00);


--INSERT rows into SALESREP_jds
INSERT INTO SALESREP_jds
	VALUES (10, 'Alice', 'Jones','A', 10);
INSERT INTO SALESREP_jds
	VALUES (12, 'Greg', 'Taylor','B', 14);
INSERT INTO SALESREP_jds
	VALUES (14, 'Sara', 'Day','Z', 10);
INSERT INTO SALESREP_jds
	VALUES (8, 'Kay', 'Price','C', 14);
INSERT INTO SALESREP_jds
	VALUES (20, 'Bob', 'Jackson','B', 10);
INSERT INTO SALESREP_jds
	VALUES (22, 'Micah', 'Moore','Z', 16);


--INSERT rows into CUSTOMER_jds 
INSERT INTO CUSTOMER_jds
	VALUES ('S100', 'John', 'Smith', 2145551212, 10);
INSERT INTO CUSTOMER_jds
	VALUES ('A120', 'Renee', 'Adams', 8175553434, 12);
INSERT INTO CUSTOMER_jds
	VALUES ('J090', 'William', 'Jones', NULL, 14);
INSERT INTO CUSTOMER_jds
	VALUES ('B200', 'Ann', 'Brown', 9725557979, 8);
INSERT INTO CUSTOMER_jds
	VALUES ('G070', 'Kate', 'Green', NULL, 20);
INSERT INTO CUSTOMER_jds
	VALUES ('S120', 'Wesley', 'Sims', 2145551234, 22);


--INSERT rows into ORDER_jds
INSERT INTO ORDER_jds
	VALUES (100, '24-JAN-2022', 'S100');
INSERT INTO ORDER_jds
	VALUES (101, '25-JAN-2022', 'A120');
INSERT INTO ORDER_jds
	VALUES (102, '25-JAN-2022', 'J090');
INSERT INTO ORDER_jds
	VALUES (103, '26-JAN-2022', 'B200');
INSERT INTO ORDER_jds
	VALUES (104, '26-JAN-2022', 'S100');
INSERT INTO ORDER_jds
	VALUES (105, '26-JAN-2022', 'B200');
INSERT INTO ORDER_jds
	VALUES (106, '27-JAN-2022', 'G070');
INSERT INTO ORDER_jds
	VALUES (107, '27-JAN-2022', 'J090');
INSERT INTO ORDER_jds
	VALUES (108, '27-JAN-2022', 'S120');


--ORDERDETAIL
--(100)
INSERT INTO ORDERDETAIL_jds
	VALUES (100, 121, 2, 7.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (100, 228, 1, 65.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (100, 480, 4, 3.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (100, 407, 4, 4.25);

--(101)
INSERT INTO ORDERDETAIL_jds
	VALUES (101, 610, 200, 1.75);
INSERT INTO ORDERDETAIL_jds
	VALUES (101, 618, 100, 1.25);

--(102)
INSERT INTO ORDERDETAIL_jds
	VALUES (102, 380, 2, 1.25);
INSERT INTO ORDERDETAIL_jds
	VALUES (102, 121, 1, 7.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (102, 535, 4, 7.50);

--(103)
INSERT INTO ORDERDETAIL_jds
	VALUES (103, 121, 50, 7.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (103, 618, 100, 6.25);

--(104)
INSERT INTO ORDERDETAIL_jds
	VALUES (104, 229, 1, 50.00);
INSERT INTO ORDERDETAIL_jds
	VALUES (104, 610, 200, 1.75);
INSERT INTO ORDERDETAIL_jds
	VALUES (104, 380, 2, 1.25);
INSERT INTO ORDERDETAIL_jds
	VALUES (104, 535, 4, 7.50);

--(105)
INSERT INTO ORDERDETAIL_jds
	VALUES (105, 610, 200, 1.75);
INSERT INTO ORDERDETAIL_jds
	VALUES (105, 123, 40, 5.00);

--(106)
INSERT INTO ORDERDETAIL_jds
	VALUES (106, 124, 1, 6.50);

--(107)
INSERT INTO ORDERDETAIL_jds
	VALUES (107, 229, 1, 59.00);

--(108)
INSERT INTO ORDERDETAIL_jds
	VALUES (108, 235, 1, 65.00);


-- COMMIT the data to save it to disk (COMMIT applies only to INSERT, UPDATE, and DELETE statements)
COMMIT; 

--IIB. Retrive all data from each table
SELECT * FROM PRODCAT_jds;
SELECT * FROM COMMISSION_jds;
SELECT * FROM DEPARTMENT_jds;
SELECT * FROM PRODUCT_jds;
SELECT * FROM SALESREP_jds;
SELECT * FROM CUSTOMER_jds;
SELECT * FROM ORDER_jds;
SELECT * FROM ORDERDETAIL_jds;

--III.
/*change the CUSTOMER phone from  B200 to 2145551234 AND  
Add Customer G119 (Amanda Green, no phone number), SalesRep 14
*/
--CUSTOMER
UPDATE CUSTOMER_jds
  SET CustPhone= '2145551234'
 WHERE CustID= 'B200';

INSERT INTO CUSTOMER_jds 
 --VALUES(CustID, CustFName, CustLName, CustPhone, SalesRepID)
 VALUES('G119', 'Amanda', 'Green', NULL, 14);

--ORDER
UPDATE ORDER_jds
  SET OrderDate= '28-JAN-2022'
 WHERE OrderDate= 108

INSERT INTO ORDER_jds
 --VALUES(OrderID, OrderDate, CustID)
 VALUES(109, '28-JAN-2022', 'G119');

--ORDERDETAIL
UPDATE ORDERDETAIL_jds
  SET ProdPrice= 62.00
 WHERE ProdID = 235 AND OrderID = 108


--Order 108 
INSERT INTO ORDERDETAIL_jds
	VALUES(407, 1, 5.25);
INSERT INTO ORDERDETAIL_jds
	VALUES(108, 618, 2, 2.15);

--Order 109
INSERT INTO ORDERDETAIL_jds
  VALUES(121, 1, 8.25);
INSERT INTO ORDERDETAIL_jds 
  VALUES(109, 480, 1, 3.75),

--Write these changes to disk
COMMIT;


--IV. Retrive all data from each table, sorting by the primary key

-- ORDER BY PRODCAT ;
SELECT * FROM PRODCAT_jds
 ORDER BY ProdCatID ;

-- ORDER BY COMMISSION ;
SELECT * FROM COMMISSION_jds
 ORDER BY CommClass ;
 

SELECT * FROM DEPARTMENT_jds
 ORDER BY DeptID ;
 
 
SELECT * FROM PRODUCT_jds
 ORDER BY ProdID ;
 
 
SELECT * FROM SALESREP_jds
 ORDER BY SalesRepID ;
 
 
SELECT * FROM CUSTOMER_jds
 ORDER BY CustID ;
 
 
SELECT * FROM ORDER_jds
 ORDER BY OrderID ;
 
 
SELECT * FROM ORDERDETAIL_jds
 ORDER BY OrderID, ProdID ;



--stop logging to the output command
set echo off

--close the spooled output file 
spool off






