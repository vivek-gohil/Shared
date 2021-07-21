-- SQL - 
create database TrainingDB;


-- DDL 
--1.Create 
--2.Alter 
--3.Drop

use TrainingDB;

create table employee_master(
	employee_id int,
	first_name varchar(20),
	last_name varchar(20),
	date_of_birth date,
	salary float
);

drop table employee_master;

select * from employee_master;

--SQL Server ALTER TABLE DROP COLUMN
ALTER TABLE employee_master
DROP COLUMN date_of_birth;

--SQL Server ALTER TABLE ADD COLUMN
ALTER TABLE employee_master
ADD date_of_birth date;

ALTER TABLE employee_master
ADD 
	gender char(1),
	designation varchar(20);

ALTER TABLE employee_master
ALTER COLUMN gender varchar(5) DEFAULT 'Male';

ALTER TABLE employee_master
DROP COLUMN date_of_birth,gender,designation;

select * from employee_master;

sp_help employee_master;

--Constraints
--SQL Server PRIMARY KEY

CREATE TABLE activities(
	activity_id int primary key,
	activity_name varchar(50) not null,
	activity_date date not null
);

sp_help activities;

insert into activities values (101, 'backup of file system' , GETDATE());

select * from activities;

--testing primary key
insert into activities values(101, 'restart the system' , GETDATE());
insert into activities values(NULL, 'restart the system' , GETDATE());

--testing not null
insert into activities(activity_id,activity_name) values(102, 'restart the system');

--SQL SERVER FOREIGN KEY
--vendors and vendor_groups

--vendor_groups
--group_id - PK

CREATE TABLE vendor_group(
	group_id int primary key,
	group_name varchar(100)
);

INSERT INTO vendor_group(group_id ,group_name)
VALUES(1,'Third-Party Vendors'),
      (2,'Interco Vendors'),
      (3,'One-time Vendors');

select * from vendor_group;

--vendors
--vendor_id - PK
--group_id - FK

CREATE TABLE vendors(
	vendor_id int primary key,
	vendor_name varchar(50),
	group_id int,
	CONSTRAINT fk_group_vendor FOREIGN KEY(group_id) REFERENCES vendor_group(group_id)
);

INSERT INTO vendors(vendor_id , vendor_name , group_id)
values	(101 , 'ABC Corp' , 1),
		(102 , 'XYZ Corp' , 3),
		(103 , 'XXX Corp' , 3);

SELECT * FROM vendors;
INSERT INTO vendors(vendor_id , vendor_name , group_id)
values	(105 , 'MNO Corp' , 2);


--SQL SERVER CHECK CONSTRAINT , IDENTITY
CREATE TABLE products(
	product_id int primary key IDENTITY(1,1),
	product_name varchar(50),
	unit_price int,
	CONSTRAINT positive_price_check CHECK(unit_price > 0)
);

INSERT INTO products(product_name,unit_price)
values	('Lux' , 10),
		('Nirma' , 20),
		('Rin' , 30);

select * from products;

INSERT INTO products(product_name,unit_price)
values	('Vim' ,0);

ALTER TABLE products
DROP CONSTRAINT positive_price_check;

ALTER TABLE products
ADD CONSTRAINT positive_price_check CHECK(unit_price > 0);

DELETE products WHERE unit_price = 0;


--SQL SERVER UNIUEQE
CREATE TABLE subscriber_details(
	subscriber_id int unique,
	subscriber_name varchar(20)
);

INSERT INTO subscriber_details values(1,'BornToCode');
INSERT INTO subscriber_details values(2,'RaceToWin');
INSERT INTO subscriber_details values(NULL,'Be a voice not echo');

select * from subscriber_details;

--SQL SERVER DEFAULT CONSTRAINT

DROP TABLE EMPLOYEE;
CREATE TABLE employee(
	employee_id int primary key identity,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	age int,
	city varchar(50) DEFAULT 'Mumbai',
);

SP_HELP employee;

ALTER TABLE employee
drop column city;

ALTER TABLE employee
DROP CONSTRAINT DF_CITY;

insert into employee(first_name, last_name,age) 
values('Vivek' , 'Gohil' , 31);

insert into employee values('Shreeyansh' , 'Parihar' , 23 , 'Ajmer');
insert into employee values('Nikhil' , 'Rane' , 23 , DEFAULT);
insert into employee values('Vinayak' , 'Navada' , 23 , DEFAULT);

select * from employee;

ALTER TABLE employee
ADD city varchar(50);

ALTER TABLE employee
ADD CONSTRAINT DF_CITY
DEFAULT 'MUMBAI' FOR city;

--UPDATE 
UPDATE employee
set first_name = 'Vivek' , last_name = 'Gohil'
where employee_id = 2;

UPDATE employee
set age = 31
where first_name = 'Vivek';

DELETE FROM employee
WHERE employee_id > 5;

select * from employee;
