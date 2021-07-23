-----------------------------
--1)	Create the following tables:
-------------------------------
create table Client_master (
client_no varchar2 (6) constraint prmKeyCNO primary key,
name varchar2 (20) not null,
address1 varchar2 (30),
address2 varchar2 (30),
city varchar2 (15),
state varchar2 (15),
pincode number (6),
bal_due number (10,2),
constraint  checkCNO check (client_no like 'C%')
);
==========================================
create table product_master(
product_no varchar2 (6) constraint prmKeyPNO primary key, constraint checkPNO check (product_no like 'P%'),
description varchar2 (50) not null,
profit_percent number (3,2) not null,
unit_measure varchar2 (10) not null,
qty_on_hand number (8)not null,
record_lvl number (8) not null,
sell_price number (8,2) not null constraint checkSELLPRICE check (sell_price>0),
cost_price number (8,2) not null constraint checkCOSTPRICE check (cost_price>0)
);
===============================================
create table salesman_master(
salesman_no varchar2(6) constraint prmKeySNO primary key,constraint checkSNO check (salesman_no like 'S%'),
salesman_name varchar2(20) not null,
address1 varchar2(30) not null,
address2 varchar2(30),
city varchar2(20),
pincode varchar2(6),
state varchar2 (20),
sal_amt number (8,2) not null,
tgt_to_get number (6,2) not null,
ytd_sales number (6,2) not null,
remarks varchar2 (60)
);
===============================================
create table sales_order(
s_order_no varchar2(6) constraint prmKeySONO primary key, constraint checkSONO check (s_order_no like 'O%'),
s_order_date date,
client_no varchar2 (6) constraint fornKeyCNO references Client_master(client_no),
dely_addr varchar2 (25),
salesman_no varchar2 (6) constraint fornKeySNO  references Salesman_master (salesman_no),
dely_type char (1) default 'F',
billed_yn char (1) default 'N',
dely_date date,
order_status varchar2 (10) constraint checkOSTATUS check (order_status in('in process','fullfilled','backOrder','canceled')),
constraint checkDELYTYPE check (dely_type in('P','F')),
constraint checkBILLYN check (billed_yn in('Y','N')),
constraint checkDELYDATE check (dely_date >s_order_date)
);
====================================================
create table sales_order_details(
s_order_no varchar2(6) constraint fornKeySONODetails 
references Sales_order(s_order_no),
product_no varchar2(6) constraint fornKeyPNODetails 
references product_master(product_no),
qty_ordered number (8),
qty_disp  number (8),
product_rate number (10,2),
constraint prmKeySONO_PNO primary key(s_order_no,product_no)
);
=========================================
create table Challan_Header(
challan_no varchar2 (6) constraint prmKey primary key,
s_order_no varchar2 (6) constraint fornKey references sales_order(s_order_no),
challan_date date not null,
billed_yn char (1) default 'N',
constraint checkCHALLAN_NO check (challan_no like 'CH%'),
constraint checkBILLED_YN check (billed_yn in ('Y','N'))
);
====================================================
create table challan_details(
challan_no varchar (6) constraint fornKeyCHALLANNO references Challan_header(challan_no),
product_no varchar (6) constraint fornKeyPRODUCRNO references product_master(product_no),
qty_disp number (4,2) not null,
constraint prmKeyCHALLANNO_PRODUCTNO primary key(challan_no,product_no)
);
=====================================================
-------------------------------------------------
--2	Insert the following data into their respective tables using the SQL insert statement:
----------------------------------------------
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00001','Ivan Bayross','Bombay',400054,'Maharashtra',15000);
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00002','Vandana Saitwal','Madras',780001,'Tamil Nadu',0);
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00003','Pramada Jaguste','Bombay',400057,'Maharashtra',5000);
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00004','Basu Navindgi','Bombay',400056,'Maharashtra',0);
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00005','Ravi Sreedharan','Delhi',100001,'Delhi',2000);
insert into client_master(client_no, name, city, pincode,state,bal_due)
values('C00006','Rukmini','Bombay',400050,'Maharashtra',0);

==============================
insert into product_master values('P00001','1.44 Floppies',5,'Piece',100,20,525,500);
insert into product_master values('P03453','Monitors',6,'Piece',10,3,12000,11280);
insert into product_master values('P06734','Mouse',5,'Piece',20,50,1050,1000);
insert into product_master values('P07865','1.22 Floppies',5,'Piece',100,20,525,500);
insert into product_master values('P07868','Keyboards',2,'Piece',10,3,3150,3050);
insert into product_master values('P07885','CD Drive',2.5,'Piece',10,3,5250,5100);
insert into product_master values('P07965','540 HDD',4,'Piece',10,3,8400,8000);
insert into product_master values('P07975','1.44 Drive',5,'Piece',10,3,1050,1000);
insert into product_master values('P08865','1.22 Drive',5,'Piece',2,3,1050,1000);
==================================
insert into salesman_master values('S00001','Kiran','A/14','Worli','Bombay',400002,'MAH',3000,100,50,'Good');
insert into salesman_master values('S00002','Manish','65','Nariman','Bombay',400001,'MAH',3000,200,100,'Good');
insert into salesman_master values('S00003','Ravi','P-7','Bandra','Bombay',400032,'MAH',3000,200,100,'Good');
insert into salesman_master values('S00004','Ashish','A/5','Juhu','Bombay',400044,'MAH',3500,200,150,'Good');
======================================
insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O19001','12-Jan-1996','C00001','F','N','S00001','20-Jan-1996','in process');

insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O19002','25-Jan-1996','C00002','P','N','S00002','27-Jan-1996','canceled');

insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O46865','18-Feb-1996','C00003','F','Y','S00003','20-Feb-1996','fullfilled');

insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O19003','03-Apr-1996','C00001','F','Y','S00001','07-Apr-1996','fullfilled');

insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O46866','20-May-1996','C00004','P','N','S00002','22-May-1996','canceled');

insert into sales_order(s_order_no,s_order_date,client_no,dely_type,billed_Yn,salesman_no,dely_date,order_status)
values('O10008','24-May-1996','C00005','F','N','S00004','26-May-1996','in process');
============================================
insert into sales_order_details values('O19001','P00001',4,4,525);
insert into sales_order_details values('O19001','P07965',2,1,8400);
insert into sales_order_details values('O19001','P07885',2,1,5250);
insert into sales_order_details values('O19002','P00001',10,0,525);
insert into sales_order_details values('O46865','P07868',3,3,3150);
insert into sales_order_details values('O46865','P07885',3,1,5250);
insert into sales_order_details values('O46865','P00001',10,10,525);
insert into sales_order_details values('O46865','P03453',4,4,1050);
insert into sales_order_details values('O19003','P03453',2,2,1050);
insert into sales_order_details values('O19003','P06734',1,1,12000);
insert into sales_order_details values('O46866','P07965',1,0,8400);
insert into sales_order_details values('O46866','P07975',1,0,1050);
insert into sales_order_details values('O19003','P00001',10,4,525);
insert into sales_order_details values('O19003','P07975',5,3,1050);
===================================================
insert into challan_header values('CH9001','O19001','12-Dec-1995','Y');
insert into challan_header values('CH6865','O46865','12-Nov-1995','Y');
insert into challan_header values('CH3965','O10008','12-Oct-1995','Y');
=================================================
insert into challan_details values('CH9001','P00001',4);
insert into challan_details values('CH9001','P07965',1);
insert into challan_details values('CH9001','P07885',1);
insert into challan_details values('CH6865','P07868',3);
insert into challan_details values('CH6865','P03453',4);
insert into challan_details values('CH6865','P00001',10);
insert into challan_details values('CH3965','P00001',5);
insert into challan_details values('CH3965','P07975',2);
=====================================================
select * from Client_master;
select * from product_master;
select * from salesman_master;
select * from sales_order;
select * from sales_order_details;
select * from Challan_header;
select * from Challan_details;
======================================================
drop table client_master
drop table product_master
drop table salesman_master
drop table sales_order
drop table sales_order_details
drop table Challan_Details
drop table challan_details
=================================
-----------------------------------------
-- SIXTY SELF REVIEW SQL SENTENCE CONSTRUCTS FOR PRACTICE
-----------------------------------------
--1. Single Table retrieval
--------1---------------------
--Find out the names of all the clients.

select name from client_master
--------2-----------------------
-- Print the entire client_master table.

select * from client_master
---------3---------------------
--Retrieve the list of names and the cities of all the clients

select name, city from client_master
----------4---------------------------
--List the various products available from the product_master table.

select description "Product Name" from product_master;
----------5---------------------------
--Find the names of all clients having ‘a’ as the second letter in their table.

select name from client_master where name like '_a%'
-----------6----------------------------
--Find the names of all clients who stay in a city whose second letter is ‘a’

select name,city from client_master where city like '_a%'
------------7--------------------------
--Find out the clients who stay in a city ‘Bombay’ or city ‘Delhi’ or city ‘Madras’.

select * from client_master where city in('Bombay','Delhi','Madras')
-------------8---------------------------
--8)	List all the clients who are located in Bombay.

select * from client_master where city='Bombay'
--------------9--------------------------
--9)	Print the list of clients whose bal_due are greater than value 10000

select * from client_master where bal_due>10000
--------------10--------------------------
--10)	Print the information from sales_order table of orders placed in the month of January.
select s_order_no from sales_order where to_char(s_order_date,'Mon')='Jan';
---------------11----------------------
--11)	Display the order information for client_no ‘C00001’ and ‘C00002’
select * from sales_order where client_no in ('C00001', 'C00003')
---------------12----------------------
--12)	Find the products with description as ‘1.44 Drive’ and ‘1.22 Drive’
select * from product_master where description in ('1.44 Drive','1.22 Drive') 
---------------13------------------------
--13)	Find the products whose selling price is greater than 2000 and less than or equal to 5000
select * from product_master where sell_price > 2000 and sell_price <=5000
---------------14-------------------------
--14)	Find the products whose selling price is more than 1500 and also find the new selling price as original selling price * 15
select Description as "Product Name", 
sell_price "Selling Price ", 
sell_price*.15+sell_price as "New Selling Price" 
from product_master where sell_price>1500
----------------15-------------------------
--15)	Rename the new column in the above query as new_price
select Description as "Product Name", 
sell_price "Selling Price ", 
sell_price*.15+sell_price as "New Selling Price" 
from product_master where sell_price>1500
-------------------16------------------------
--16)	Find the products whose cost price is less than 1500
select * from product_master where cost_price <1500
--------------------17-------------------------
--17)	List the products in sorted order of their description.
select * from product_master order by DESCRIPTION 
select * from product_master order by 2
--------------------18-----------------
--18)	Calculate the square root the price of each product.
select sqrt(sell_price) "Price" from product_master order by DESCRIPTION 
--------------------19-----------------
--19)	Divide the cost of product ‘540 HDD’ 
--by difference between its price and 100 (COSHENT)
 SELECT SELL_PRICE ,ROUND( SELL_PRICE / (SELL_PRICE-100),2) AS "COSHENT" 
 FROM PRODUCT_MASTER
--------------------20-----------------
--20)	List the names, city and state of clients not in the state of Maharashtra
 SELECT NAME, CITY, STATE FROM CLIENT_MASTER 
 WHERE NOT STATE='Maharashtra';
--------------------21-----------------
--21)	List the product_no, description, sell_price of products 
--whose description begin with letter ‘M’
SELECT pRODUCT_NO, DESCRIPTION, SELL_PRICE FROM PRODUCT_MASTER
WHERE DESCRIPTION LIKE 'M%';
--------------------22-----------------
--22)	List all the orders that were canceled in the month of May.
SELECT * FROM SALES_ORDER
WHERE ORDER_STATUS = 'canceled' AND TO_CHAR(DELY_DATE,'MM')=05
--------------------Set Functions and Concatenation-----------------
--2.	Set Functions and Concatenation :
--------------------23-----------------
23)	Count the total number of orders.
SELECT COUNT(*) FROM SALES_ORDER;
--------------------24-----------------
24)	Calculate the average price of all the products.
SELECT AVG(SELL_PRICE) FROM PRODUCT_MASTER;
--------------------25-----------------
25)	Calculate the minimum price of products.
select min(sell_price) "Minimum Price" from product_master
--------------------26-----------------
26)	Determine the maximum and minimum product prices. 
Rename the title as max_price and min_price respectively.
SELECT MIN(SELL_PRICE) "Minimum Price", max(sell_price) "Maximum Price"
from product_master;

--------------------27-----------------
27)	Count the number of products having price greater than or equal to 1500.
select count(*) from product_master 
where sell_price >= 1500;
--------------------28-----------------
28)	Find all the products whose qty_on_hand is less than reorder level.
select * from product_master
where qty_on_hand < reorder_lvl;
--------------------29-----------------
29)	Print the information of client_master, product_master, sales_order table in the following formate for all the records
{cust_name} has placed order {order_no} on {s_order_date}.
select name ||' has placed order '||s_order_no||' on '||s_order_date
from client_master, sales_order
where client_master.client_no = sales_order.client_no;


--------------------3.	Having and Group by:-----------------
--------------------30-----------------
30)	Print the description and total qty sold for each product.

select description, sum(qty_disp) "Total Quantity Sold"
from product_master, sales_order_details
where product_master.product_no = sales_order_details.product_no
group by description;
--------------------31-----------------
31)	Find the value of each product sold.
select description, sum(qty_disp * product_rate) "Total Worth"
from product_master, sales_order_details
where product_master.product_no = sales_order_details.product_no
group by description;


--------------------32-----------------
32)	Calculate the average qty sold for each client that has a maximum order value of 15000.00
select client_master.client_no, avg(qty_disp), sum(qty_disp*product_rate)
from client_master, sales_order, sales_order_details
where client_master.client_no = sales_order.client_no and
sales_order.s_order_no = sales_order_details.s_order_no
group by client_master.client_no
having sum(qty_disp * product_rate) <= 15000

--------------------33-----------------
--33)	Find out the total sales amount receivable for the month of jan. it will be the 
--sum total of all the billed orders for the month.
--select  s_order_date,sum(qty_dispatched*product_rate)
--from sales_order, sales_order_details
--where sales_order.s_order_no = sales_order_details.s_order_no
--and billed_yn='y' and to_char(s_order_dt,mon)='jan';
--------------------34-----------------
34)	Print the information of product_master, order_detail table in the following format for all the records
{Description} worth Rs. {Total sales for the product} was sold.
select description||' worth Rs.'||sum(qty_dispatched*product_rate)||
' for the product was sold '
from client_master,sales_order, sales_order_details, product_master
where client_master.client_no = sales_order.client_no and
product_master.product_no = sales_ordeR_details.product_no and
sales_order.s_order_no = sales_order_details.s_order_no
group by description

--------------------35-----------------
35)	Print the information of product_master, order_detail table in the following format for all the records
{Description} worth Rs. {Total sales for the product} was produced in the 
month of {s_order_date} in month format.

 select description||' worth Rs.'||to_char(sum(qty_disp*product_rate))||
 ' was produced in the month'|| to_char(s_order_date,'month')
 from client_master,sales_order, sales_order_details, product_master
 where client_master.client_no = sales_order.client_no and
 product_master.product_no = sales_ordeR_details.product_no and
 sales_order.s_order_no = sales_order_details.s_order_no
 group by description, s_order_date;

--------------------4.	Joins and Correlation :-----------------
--------------------36-----------------
36)	Find out the products which has been sold to ‘Ivan Bayross’

select name, description
from client_master, product_master, sales_order, sales_order_details
where client_master.client_no = sales_order.client_no and
product_master.product_no = sales_order_details.product_no and
sales_order.s_order_no = sales_order_details.s_order_no and
name='Ivan Bayross';
--------------------37-----------------
37)	Find out the products and their quantities that will have to deliver in the 
current month.

 select description, qty_disp, dely_date
 from product_master, sales_order_details, sales_order
 where product_master.product_no = sales_order_details.product_no and
 sales_order.s_order_no = sales_order_details.s_order_no  and
 to_char(dely_date,'month')=to_char(sysdate,'month')
 --------------------38-----------------
38)	Find the product_no and description of moving products.
select * from product_master where product_no in(select product_no from 
sales_order_details);
--------------------39-----------------
39)	Find the names of clients who have purchased ‘CD Drive’
select name, description 
from client_master, product_master, sales_order, sales_order_details
where client_master.client_no = sales_order.client_no and
product_master.product_no = sales_order_details.product_no and
sales_order.s_order_no = sales_order_details.s_order_no and
description ='CD Drive';
--------------------40-----------------
40)	List the product_no and s_order_no of customers 
having qty_ordered less than 5 from the order details  table 
for the product ‘1.44 floppies’
select p.product_no, s.s_order_no,sod.qty_ordered, c.name,p.description from
client_master c, product_master p, sales_order s, sales_order_details sod
where (s.client_no=c.client_no and sod.product_no=p.product_no and sod.s_order_no=s.s_order_no)
and sod.qty_ordered<5 and p.description='1.44 Floppies'
--------------------41-----------------
41)	Find the products and their quantities for the orders placed 
by ‘Vandana Saitwal’ and ‘Ivan Bayross’
select p.description, sod.qty_ordered, c.name from
client_master c, product_master p, sales_order s, sales_order_details sod
where (s.client_no=c.client_no and sod.product_no=p.product_no and sod.s_order_no=s.s_order_no)
and c.name in('Vandana Saitwal','Ivan Bayross')
--------------------42-----------------
42)	Find the products and their quantities for the orders placed 
by client_no ‘C00001’ and ‘C00002’
select p.description, sod.qty_ordered, c.client_no from
client_master c, product_master p, sales_order s, sales_order_details sod
where (s.client_no=c.client_no and sod.product_no=p.product_no and sod.s_order_no=s.s_order_no)
and c.client_no in('C00001','C00002')
--------------------5.	Nested Queries :-----------------
--------------------43-----------------
43)	Find the product_no and description of non-moving products.
select product_no , description from product_master where product_no in
(select product_no from sales_order_details where s_order_no in
(select s_order_no from sales_order where order_status='IP') 
);
--------------------44-----------------
44)	Find the customer name, address1, address2, city and pin code 
for the client who has placed order no ‘O19001’
select name, address1,address2, city, pincode  from client_master where client_no in(
select client_no from sales_order where s_order_no ='O19001');
--------------------45-----------------
45)	Find the client names who have placed orders before the month of May, 1996
select * from client_master where client_no in(
select client_no from sales_order where to_char(s_order_date,'mm')<05);
--with join
select c.name, to_char(s.s_order_date,'month') "Month" from
client_master c, sales_order s
where c.client_no =s.client_no and to_char(s_order_date,'mm')<05
--------------------46-----------------
46)	Find out if product ‘1.44 Drive’ is ordered by client and 
print the client_no, name to whom it is was sold.
select client_no , name  from client_master where client_no in(
	select client_no from sales_order where s_order_no in(
		select s_order_no from sales_order_details where product_no in(
			select product_no from product_master where description !='1.44 Drive'
			)
		)
	)
	
	---with join
	
	select c.client_no , c.name, p.description from
client_master c, product_master p, sales_order s, sales_order_details sod
where (s.client_no=c.client_no and sod.product_no=p.product_no and
sod.s_order_no=s.s_order_no)and  p.description != '1.44 Floppies'
--------------------47-----------------
47)	Find the names of clients who have placed orders worth Rs. 10000 or more.

select name from client_master where client_no in(
	select client_no from sales_order where s_order_no in(
		select s_order_no from sales_order_details 
				where product_rate*qty_ordered>=10000
		)
	);
	
	---with join
	select c.name, sod.product_rate*qty_ordered  "Amount" from
client_master c, product_master p, sales_order s, sales_order_details sod
where (s.client_no=c.client_no and sod.product_no=p.product_no and sod.s_order_no=s.s_order_no)
and product_rate*qty_ordered>=10000
--------------------6.	Queries using Date:-----------------
--------------------48-----------------
48)	Display the order number and day on which clients placed their order.
select s.s_order_no, to_char(s.s_order_date,'ddth')  "Day"
from sales_order s, sales_order_details sod
where s.s_order_no=sod.s_order_no;
--------------------49-----------------
49)	Display the month (in alphabets) and date when the order must deliver.
select to_char(dely_date,'month'), to_char(dely_date,'dd')
from sales_order
--------------------50-----------------
50)	Display the s_order_date in the format . E.g. 12-February-1996 
select to_char(s_order_Date,'dd-month-yyyy') from sales_order

--------------------51-----------------
51)	Find the date, 15 days after today’s date.
select sysdate+15 from dual
--------------------52-----------------
52)	Find the number of days elapsed between today’s date 
and the delivery date of the orders placed by the clients.
select dely_date, (sysdate-dely_date) from sales_order;
--------------------7.	Table Updations:-----------------
--------------------53-----------------
53)	Change the s_order_date of client_no ‘C00001’ to 24/07/96.

ALTER TABLE SALES_ORDER DISABLE CONSTRAINT CHECKDELYDATE;
 update sales_order
 set s_order_date='24-jul-1996'
 where client_no='C00001';
--------------------54-----------------
54)	Change the selling price of ‘1.44 Floppy Drive’ to Rs. 1150.00
 update product_master
 set sell_price=1150
 where description='1.44 Floppies';
--------------------55-----------------
55)	Delete the records with order number ‘O19001’ from the order table.
delete from sales_order
where s_order_no='O19001';
--------------------56-----------------
56)	Delete all the records having delivery date before 10th July’96
 delete from sales_order
 where dely_date='10-JUL-1996';
--------------------57-----------------
57)	Change the city of client_no ‘C00005’ to ’Bombay’.
update client_master
set city='Bombay'
where client_no='C00005';
--------------------58-----------------
58)	Change the delivery date of order number ‘O10008” to 16/08/96
 update sales_order
 set dely_date='16-aUG-1996'
 where s_order_no='O10008';
--------------------59-----------------
59)	Change the bal_due of client_no ‘C00001’ to 1000
update client_master
set bal_due=1000
where client_no='C00001';
--------------------60-----------------
60)	Change the cost price of ‘1.44 Floppy Drive’ to Rs. 950.00.
 update product_master
 set cost_price=950.00
 where description='1.44 Floppies';
-------------------------------------











