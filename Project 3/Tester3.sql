
Start : 'C:\Users\joand\Downloads\Project2\3304_Proj3StarterFile_sp2022.sql'  -- SQL file

spool : '\\Mac\Home\Documents\3304_Project3_jds.txt'  --It will be txt


--log all innputs (SQL statement) and output (feedback from orcle) to spooled text file
set echo on


/*Joan Sanchez
3304-001
Project 3
*/

--Part 1

--1. All column headings must show in their entirety--no truncated column headings. 
--Only CHAR or VARCHAR data types

COLUMN ProdCatID FORMAT a15
COLUMN CommClass FORMAT a10 --"a10" is the amount of space in the title
COLUMN CustID  FORMAT a10
COLUMN SalesRepFName FORMAT a35
COLUMN SalesRepLName FORMAT a35
COLUMN CustPhone FORMAT a15
--COLUMN " SalesRep Name " FORMAT a20

--2. Line 
SET LINESIZE 130

--4. Add a new Customer:
INSERT INTO CUSTOMER_jds 
 --VALUES(CustID, CustFName, CustLName, CustPhone, SalesRepID)
	VALUES('T104', 'Wes', 'Thomas', '4695551215', 14);

--5. Add a new Product:
INSERT INTO PRODUCT_jds
	VALUES(246, 'Milwaukee PowerDril1', 2, 179); 
	
--6. Add a new Order.  Generate the OrderID by incrementing the max OrderID by 1.
INSERT INTO ORDER_jds
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds) +1, ('28-JAN-2022','T104')

/*Add OrderDetails using the OrderID for the new Order above:
ProdID	ProdQty		ProdPrice
  618     1 		$1.25
  407     2 		$4.25
  124     1 		$6.50
*/
INSERT INTO ORDERDETAIL_jds
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 618, 1, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (618)  ))
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 407, 2, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (407)  ))
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 124, 1, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (124)  ))



--7. Add a new Order.  Generate the OrderID by incrementing the max OrderID by 1.  
INSERT INTO ORDER_jds
--the first add
VALUES ((SELECT MAX (OrderID) FROM ORDER_jds) +1, ('29-JAN-2022','S100')

/*Add OrderDetails using the OrderID for the new Order above:
ProdID	ProdQty		ProdPrice
  535     3 		$7.50
  246     1 		$???
  610     2 		$1.75
*/
INSERT INTO ORDERDETAIL_jds
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 535, 3, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (535) ))
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 246, 1, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (246) ))
	VALUES ((SELECT MAX (OrderID) FROM ORDER_jds), 124, 2, (SELECT (ProdPrice) FROM PRODUCT_jds WHERE ProdID (124) ))


--8 Change the phone number for Customer B200 to 817-555-8918.
UPDATE CUSTOMER_jds
  SET CustPhone= '817-555-8918'
 WHERE CustID= 'B200';

--9. Commit all changes above before proceeding to the next step.
COMMIT;  


--Part 2
/* 1 List the first name, last name, sales rep ID, commission class, and commission rate for all Sales 
Reps.  

Combine the first and last name into one column (include a space between them). 

 Sort by 
last name in ascending order, and use the following column headings:  SalesRep Name, Sales Rep 
ID, Commission Class, Commission Rate.*/ 

 --1 (Probably an error)
SELECT (SalesRepFName || '' || SalesRepLName) AS "SalesRep Name" , SalesRepID AS "Sales Rep ID", S.CommClass AS "Commission Class", C.CommRate AS "Commission Rate" --error in S. and C.
	FROM SALESREP_jds S, COMMCLASS_jds C --getting info from two different TABLES
 WHERE S.SALESREP_jds = C.COMMCLASS_jds
 ORDER BY AgentLName ; 
 
 --dot notation is need it when part info is find in two different tables
-- Line size should be set at least 125 and no more than 150 to minimize column wrapping.
-- Properly use table aliases and dot notation where applicable.


/*2. List all rows and all columns from OrderDetail; sort by Order ID then by Product ID, both in 
ascending order; format the Product Price as currency.  Use the following column headings:  Order 
ID, Product ID, Qty, Price*/
SELECT OrderID "Order ID", ProdID "Product ID", TO_CHAR(RateAmt, '$999.99') AS "Price"
  FROM ORDERDETAIL_jds 
ORDER BY ProdID ASC; 
 
 
/*3. For all customers, list the customer ID, customer first name, customer last name, and customer 
phone number, along with the sales rep ID, sales rep first name, and sales rep last name of the sales 
rep to whom that customer belongs; sort by Customer ID in ***ascending order***; format the phone 
number as ‘(###) ###-####’ by using concatenation and the SUBSTR function.  Use the following 
column headings:  CustID, CustFirstName, CustLastName, CustPhone, SalesRepID, 
SalesRepFirstName, SalesRepLastName.*/

--fix this to ascending order
SELECT CustID AS "CustID" , CustF/Name AS "CustFirstName", CustL/Name AS "CustLastName" , ( '(' ||SUBSTR(CustPhone, 1,3) ||') ' || SUBSTR (CustPhone, 4,3) || '-' SUBSTR (CustPhone, 7,4)) AS "CustPhone",
		C.SalesRepID AS "SalesRepID", SalesRepF/Name AS "SalesRepFirstName", SalesRepL/Name AS "SalesRepLastName"
  FROM CUSTOMER_jds C, SALESREP_jds SR
 WHERE C.SalesRepID = SR.SalesRepID; 
ORDER BY SalesRepL/Name ASC; 

/*4. List the department ID, department name, sales rep ID, first name, last name, commission class, 
and commission rate of the sales rep(s) who earn the highest commission in each department.  Use 
the following column headings:  Dept_ID, Dept_Name, Sales_Rep_ID, First_Name, Last_Name, 
Commission_Class, Commission_Rate. */

SELECT SR.DeptID AS "Dept_ID", DeptName AS "Dept_Name", SalesRepID AS "Sales_Rep_ID", SalesRepF/Name AS "First_Name", 
       SalesRepL/Name AS "Last_Name", CommClass AS "Commission_Class", CommRate AS "Commission_Rate"
 FROM DEPTID_jds D, SALESREP_jds SR, COMMCLASS_jds C
WHERE D.DeptID= SR.DeptID AND
	  SR.CommClass = C.CommClass
	  (DeptID, CommRate) IN 
	    (SELECT D.DeptID, MAX (C.CommRate)
	     FROM SalesRep SR, COMMCLASS C
		WHERE  D.DeptID = SR.DeptID
		GROUP BY SR.DeptID); 
		
OR

SELECT d.DeptID AS "Dept_ID", d.DeptName AS "Dept_Name", s.SalesRepID AS "Sales_Rep_ID", s.SalesRepFName 
      AS "First_Name", s.SalesRepLName AS "Last_Name", c.CommClass AS "Commission_Class", c.CommRate 
      AS "Commission_Rate"



/*
COMMCLASS**Commision Table**(CommClass, CommRate)
DEPTID(DeptID, DeptName)
SALER**SALEREP**(SalesRepID, SalesRepF/Name, SalesRepL/Name, CommClass, DeptID)


/*5. List the product ID, product name, category name, and price for the highest priced product(s) sold 
in order 100.  Show the price formatted as currency, and use the following column headings:  
Product_ID, Product_Name, Category, Price. */

SELECT P.ProdID AS Product_ID, P.ProdName AS "Product_Name", PC.ProdCatName AS "Category",
       TO_CHAR(MAX(od.ProdPrice), $'$999.99')  AS "Price"
 FROM ORDERDETAIL OD, PRODUCT_jds P, PRODUCTCAT_jds PC
 
WHERE OD.ProdID = P.ProdID AND
      P.ProductCatID = PC.ProductCatID AND 
	  OrderID = 100

GROUP BY (P.ProdID, P.ProdName, PC.ProdCatName)
 
/* 
ORDERDETAIL (OrderID, ProdID, ProdPrice, ProdQty)	
PRODUCT(ProdID, ProdName, ProdCatID, ProdPrice )	
PRODUCTCAT(ProdCatID, ProdCatName)
*/

/*
OR
select p.ProdID as Product_ID, p.ProdName as Product_Name, pc.ProdCatName as Category, to_char(od.ProdPrice,'L99G999D99MI', 'NLS_NUMERIC_CHARACTERS = ''.''''''NLS_CURRENCY = ''$''') as Price
from ORDERDETAIL od      
on od.ProdID = p.ProdID 
inner join PRODCAT pc    
on p.ProdCatID = pc.ProdCatID  
where od.OrderID = 100   
and od.ProdPrice =       
(select MAX(ProdPrice)   
from ORDERDETAIL        
where OrderID = 100);																																												
*/

/*6. List the department name and the count of sales reps in each department; group by department 
name, and sort by sales rep count in ascending order.  Use the following column headings:  
Dept_Name, Sales_Rep_Count.
*/
SELECT DeptName AS "Dept_Name", COUNT(SalesRepID) AS "Sales_Rep_Count" 
	FROM DEPARTMENT 
JOIN SALESREP ON DEPARTMENT.DeptID = SALESREP.DeptID GROUP BY DeptName ORDER BY COUNT(SalesRepID)

 
/*7. List the sales rep ID, first name, last name, and commission rate for each sales rep who earns a 
commission rate less than or equal to 5%, but do NOT include sales reps who earn 0% 
commission.   Sort by commission rate in descending order.  Show the commission rate as a 
percentage (e.g., 5% instead of .05).  Use the following column headings:  Sales_Rep_ID, 
First_Name, Last_Name, Commission_Rate.
*/

SELECT SalesRepID AS "Sales_Rep_ID", SalesRepFName AS "First_Name", SalesRepLName AS "Last_Name", 
CommRate *100 || '%' AS "Commission_Rate" 

	FROM SALESREP JOIN COMMISSION ON SALESREP.CommClass = COMMISSION.CommClass 
 WHERE CommRate <= 0.05 AND CommRate > 0 ORDER BY CommRate DESC;
 
/* 8. For each order, list the order ID, order date, customer ID, customer first name, customer last name, 
sales rep ID, sales rep first name, and sales rep last name; sort by order ID; Format the order date 
as “mm/dd/yy” */ 

SELECT ORDER.OrderID, TO_CHAR(OrderDate, 'mm/dd/yy'), 
CUSTOMER.CustID, CustF/Name, CustL/Name, SALESREP.SalesRepID, SalesRepF/Name, SalesRepL/Name 

	FROM ORDER JOIN CUSTOMER 
 ON ORDER.CustID = CUSTOMER.CustID JOIN SALESREP
 ON CUSTOMER.SalesRepID = SALESREP.SalesRepID 
	ORDER BY ORDER.OrderID;

/* 9. List the order ID, product ID, product name, category ID, product price, product qty, and extended 
price (price * qty) for all products sold in order 104.  Sort by extended price and format the price as 
currency.  Use the following column headings:  OrderID, ProdID, ProdName, CatID, Price, Qty, 
ExtPrice. */

SELECT  OrderID AS "OrderID", PRODUCT.ProdID AS "ProdID", ProdName AS "ProdName", PRODCAT.ProdCatID AS "CatID", 
		FORMAT(ProdPrice, 'C') AS  "Price", ProdQty AS "Qty", FORMAT(ProdPrice * ProdQty, 'C') AS "ExtPrice"
	FROM ORDERDETAIL
	JOIN PRODUCT 
		ON ORDERDETAIL.ProdID = PRODUCT.ProdID 
	JOIN PRODCAT 
		ON PRODUCT.ProdCatID = PRODCAT.ProdCatID WHERE ORDER.OrderID = 104 ORDER BY ProdPrice * ProdQty;

/*10. List the department ID, department name, count of sales reps, and average commission rate for 
each department.  Group by department, and sort by average commission rate in ascending order.  
Show the average commission rate as a percentage (e.g., 3.5% instead of .035).  Use the following 
column headings:  DeptID, DeptName, SalesRepCount, AvgCommRate. */

SELECT d.DeptID AS "DeptID",d.DeptName AS "DeptName", COUNT(s.SalesRepID) AS "SalesRepCount",
	AVG (c.CommRate)*100 AS "AvgCommRate" 
 FROM SALESREP s
  INNER JOIN DEPARTMENT d ON d.DeptID=s.DeptID
  INNER JOIN COMMISSION c ON c.CommClass=s.CommClass
	GROUP BY s.DeptID ORDER BY AvgCommRate;
	
/* 11.List the sales rep ID, first name, last name, department name, commission class and commission 
rate for all sales reps that earn a commission greater than 0%.  Sort by sales rep ID in ascending 
order. */

SELECT s.SalesRepID, s.SalesRepFName,s.SalesRepLName,d.DeptName, s.CommClass,c.CommRate
 FROM SALESREP s
	INNER JOIN DEPARTMENT d ON d.DeptID=s.DeptName
	INNER JOIN COMMISSION c ON c.CommClass=s.CommClass
	
WHERE c.CommRate>0 ORDER BY s.SalesRepID;

/* 12. List the sales rep ID, first name, last name, department ID, and department name for all sales reps 
whose commission class is ‘A.’  Concatenate the first and last names together, using 
SalesRep_Name as the column heading.  Sort by department ID then by sales rep ID.*/

SELECT s.SalesRepID, CONCAT(SalesRepFName,' ',SalesRepLName) AS "SalesRep_Name", s.DeptID,d.DeptName
 FROM SALESREP s
	INNER JOIN DEPARTMENT d ON d.DeptID=s.DeptID
	
WHERE s.CommClass='A' ORDER BY d.DeptID,s.SalesRepID;

/* 13. List the order ID and calculated total for all products sold in order 104.  Format the total as 
currency.  Use the following column headings:  Order_ID, Order_Total. */
SELECT o.OrderID AS "Order_ID", SUM(od.ProdPrice) AS "Order_Total"
 FROM ORDER o, ORDERDETAIL od
 
WHERE o.OrderID=od.OrderID AND OrderID=104


/* 14. List the average product price of all products sold, formatted as currency.  Use Avg_Price as the 
column heading. */

SELECT ProdID, AVG(ProdPrice) AS "Avg_Price"
	FROM ORDERDETAIL
GROUP BY ProdID

/* 15. List the product ID, product name, and current product price for the product(s) sold in more orders 
than any other products (based on number of order occurrences, not the quantity).  Format the price 
as currency, and use the following column headings:  ProductID, Name, Price. */

SELECT p.ProdID AS "ProductID", p.ProdName AS "Name", p.ProdPrice AS "Price"
	WHERE prodID=(SELECT ProdID FROM ORDERDETAILS GROUP BY ProdID HAVING COUNT (*)=(SELECT MAX(c)
FROM (SELECT ProdID, COUNT(*) AS c FROM ORDERDETAILS GROUP BYProdID))

/* 16. List the category ID, product ID, product name, and current product price for the lowest priced 
product in each category.  Format the price as currency, and use the following column headings:  
Cat_ID, Prod_ID, Prod_Name, Price. */

SELECT ProdCatId AS Cat_ID,ProductId AS Prod_ID, ProdName AS Prod_Name, FORMAT(min(ProdPrice),'C') AS Price FROM PRODUCT group by ProdCatId;

/* 17.  List the product ID, product name, category name, and current product price for all products which 
have a price greater than the average product price.  Format the price as currency. */

SELECT ProductId AS Prod_ID, ProdName AS Prod_Name, ProdCatName ,FORMAT(ProdPrice,'C') AS Price FROM PRODUCT JOIN PRODCAT ON PRODUCT.ProdCatId=PRODCAT.ProdCatId WHERE ProdPrice> ( Select avg(ProdPrice from PRODUCT);

/* 18. List the order ID, order date, customer ID, customer first name, customer last name, and customer 
phone number for all orders on or before 1/26/22.  Combine the first and last name into one column 
(include a space between them). Sort by order date then by customer ID, both in ascending order.  
Format the date as “mm-dd-yyyy” and use the following column headings:  Order ID, Order Date, 
Cust ID, Name, Phone. */

SELECT OrderID, OrderDate, CustID, CONCAT(CustFName," " ,CustLName) AS Name, CustPhone AS Phone FROM ORDER JOIN CUSTOMER ON ORDER.CustID=CUSTOMER.CustID WHERE  
	FORMAT ( OrderDate,'dd/MM/yyyy ') <='26-01-22' order by OrderDate ASC,CustID ASC;

/* 19. List the customer ID, first name, and last name of all customers whose first names start with the 
letter ‘A’ and sort by last name. Use the following column headings:  CustID, FirstName, 
LastName. */

SELECT CustID, CustFName AS FirstName, CustLName AS LastName FROM CUSTOMER
WHERE CustFName LIKE 'A%'
ORDER BY CustLName;

/* 20. List the customer ID, customer first name, customer last name, and phone number of all customers 
who belong to sales rep 12.  Combine the first and last name into one column (include a space 
between them). Format the phone number as ‘###-###-####’ by using concatenation and the 
SUBSTR function, and use the following column headings:  Customer ID, Name, Phone.. */

SELECT CustID AS "CustomerID", 
CONCAT(CustFName,' ',CustLName) AS "Name", CONCAT(SUBSTRING(CustPhone,1,3),'-',SUBSTRING(CustPhone,4,3),'-',SUBSTRING(CustPhone,7,4)) AS "Phone" 
 FROM CUSTOMER;


--stop logging to the output command
set echo off

--close the spooled output file 
spool off
