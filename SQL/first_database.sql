CREATE DATABASE lucas;
USE lucas;
SHOW DATABASES;
SHOW TABLES;

## CREATING A NEW TABLE
CREATE TABLE students(
	student_id INT,
    student_name VARCHAR(100),
    student_username VARCHAR(100),
    student_email VARCHAR(100),
    student_phone VARCHAR(100)
);
ALTER TABLE students ADD PRIMARY KEY(student_id); # a way to add a primary key after creating the table
DESCRIBE students; # details about the table

CREATE TABLE schools(
	school_id INT,
    school_country_id INT,
    school_name VARCHAR(100),
	school_address VARCHAR(255),
    school_phone VARCHAR(100)
);
ALTER TABLE schools ADD PRIMARY KEY(school_id);

CREATE TABLE countries (
	country_id INT,
    country_code VARCHAR(4),
    country_name VARCHAR(100),
    country_region VARCHAR(100)
);
ALTER TABLE countries ADD PRIMARY KEY(country_id);

CREATE TABLE companies(
	company_id INT,
    company_name VARCHAR(100),
    company_address VARCHAR(255),
    company_country_id VARCHAR(100),
    company_phone VARCHAR(100)
);
ALTER TABLE companies ADD PRIMARY KEY(company_id);

CREATE TABLE student_details(
	sd_id INT,
    sd_school_id INT,
    company_id INT
);
ALTER TABLE student_details RENAME COLUMN sd_student_id TO sd_id; ## changing column name
ALTER TABLE student_details ADD PRIMARY KEY(sd_id); ## setting primary key for student_details table
ALTER TABLE student_details ADD COLUMN  sd_course_id INT; ## add new column
ALTER TABLE student_details ADD COLUMN  sd_score FLOAT;

CREATE TABLE courses (
	course_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100)
);

# insert values into all columns of the students table
INSERT INTO students VALUES (1, "Lucas", "vitantoniolucas", "lucas@gmail.com", "+4917225555"); #inserting values into all fields

# inserting values into specific columns
INSERT INTO schools(school_id, country_id, school_name) 
VALUES 	(1, 1, "Elemntary school 1"), 
		(2, 1, "Elementary School 2"),
        (3, 4, "Elementary school 3");

# delete rows
DELETE FROM schools WHERE school_name IN ("Secondary School of Witchcraft", "3", "4");

# update values
UPDATE schools
SET school_name = "Elementary School 1"
WHERE school_id = 1;


ALTER TABLE schools RENAME COLUMN school_country_id TO country_id;  ## CHANGE COLUMN NAME
ALTER TABLE company RENAME TO companies; 							## CHANGE TABLE NAME
/* it's always better to rename columns with separate queries, so if 
	we need to correct something we can do it separetly and not with a command executing 
	all changes at the same time 
*/
                                            

CREATE TABLE students2(id INT PRIMARY KEY AUTO_INCREMENT, 
					first_name varchar(100) NOT NULL, 
                    last_name varchar(100) NOT NULL, 
                    gender char(1) CHARACTER SET ASCII);
ALTER TABLE students2 ADD COLUMN add_date DATE;
ALTER TABLE students2 ADD COLUMN add_date_2 DATETIME;
ALTER TABLE students2 DROP COLUMN add_date_2; # deleting a column from table


INSERT INTO students2 VALUES
	(1, 'David', 'Langer', 'M', '2022-12-01'), 
	(2, 'Teresa', 'May', 'F', '2022-12-01');
    
# CURRENT DATE FUNCTIONS
SELECT CURDATE();
SELECT current_timestamp();
SELECT current_time();

SELECT * FROM students WHERE student_name LIKE '%'; ## LIKE operator for pattern search

## TYPE CONVERTIONS
SELECT '123ABC' * 2; # output=123*2 (sql converts the numbers and ignores the letters'
SELECT 'abc123' * 2; # output= 0 (sql cannot convert a and multiply so it returns 0)

# USER QUERIES
create user lucas@localhost identified by 'lucas'; # create an user and asign a password 'lucas'
select user from mysql.user; # shows all the users
SELECT user(); # show current user
grant all privileges on *.* to lucas@localhost; # *.* means on all schemas and tables.
grant create, select, insert on *.* to lucas@localhost; # grant certain priviligies to the user
flush privileges; # deletes current user's priviligies
show grants for lucas@localhost; # shows granted priviligies
drop user lucas@localhost; # deletes an user
select user,host,account_locked,password_Expired from mysql.user; # shows certain parameters from all users
select user,host,db,command from information_schema.processlist; # see some parametrs from all users

# CHANGING USER PASSWORD
USE mysql;
ALTER USER root@localhost IDENTIFIED BY 'lucas';

# MAKE A COPY OF A TABLE
USE lucas;
CREATE TABLE students3
SELECT * FROM students;
DROP TABLE students2, students3;

## UPDATING ENGINES, SHOWING TABLE INFORMATION AND REPAIRING TABLES AFTER UPDATE
select * from information_schema.tables 				## check engines and other parameters from students table
where table_name='students'; 							
alter table students ENGINE='InnoDB';					## changing a table's engine
repair table students quick extended;					## repairing tables after updating engine
show engines;											## show all engines
show table status;										## shows information of all tables in the current DB

ALTER TABLE courses ADD COLUMN description varchar(250) AFTER course_id; 		## adding a column after a specific column using the AFTER command
ALTER TABLE courses ALTER COLUMN description SET DEFAULT 'Course is active'; 	## setting a default value for the description field
ALTER TABLE courses ADD COLUMN row_id INT FIRST; 								## the FIRST command places the new column at the beginning of the table

INSERT INTO courses(row_id, course_id, course_name) VALUES 
	(1, 255, 'Data Fundamentals');


ALTER TABLE courses CHANGE COLUMN course_description c_description VARCHAR(500); ## changing column name and datatype with the CHANGE COLUMN clause.
/* 
	It’s a good practice to view the attributes of a column before modifying it (SHOW FULL COLUMNS).
    Be careful when changing a column because there might be information that will get
    override and could produce errors. EJ: changing datatype VARCHAR() to a smallest 
    amount of chr and there are already comments with more chrs than the specified new 
    value.
*/

SHOW FULL COLUMNS FROM courses;
/* 
	use this query to get full information about the columns of
    a table. 
    Collation = information about data types
    Extra = information related to the attribute
*/

LOCK TABLE students READ; ## lock table to be 'read only'. Useful to give access to clients where they can only read.
SELECT connection_id(); # I can see my connection ID. Can be useful to identify my ID and see if I'm the source of a certain problem.

## VIEWS. CREATING AND DROPPING VIEWS
CREATE VIEW students_view AS (
	SELECT *
    FROM students
	);
DROP VIEW students_view;

## SHOW COLUMN DETAILS AND DESCRIPTION FROM A TABLE
DESCRIBE courses;
SHOW FULL COLUMNS FROM courses;

## ANY clause (used with subqueries)
CREATE TABLE employees_it (name varchar(255), salary INT);
INSERT INTO employees_it VALUES ('Lucas', 25000), ('Pedro', 32000), ('Juan', 27000);
CREATE TABLE employees_logistic (name varchar(255), salary INT); 
INSERT INTO employees_logistic VALUES ('John', 35000), ('Mike', 82000), ('Joe', 30000);

SELECT *
FROM employees_it
WHERE NOT salary > ANY (SELECT salary FROM employees_logistic);

SELECT *
FROM employees_it
WHERE salary IS NULL;

## CAST() function allows to convert a data type (of any kind) into another type
SELECT CAST('2023-02-22' AS DATE);

## IF clause + strcmp() function to compare strings
SELECT IF(strcmp('Lucas', 'LUCAS') = 0, 'Equal', 'Not Equal');     
SELECT strcmp('Lucas', 'LUCAS'); ## output: 0					  	
SELECT 'Lucas' = 'LUCAS'; ## output: 1	
/* Note that strcmp and = don't work						
the same way. That's way the outputs are different */

## CASE statement
SELECT name, salary,
	CASE
		WHEN salary  > 30000 THEN 'High salary'
		WHEN salary BETWEEN 20000 AND 30000 THEN 'Avg salary'
		ELSE 'Low salary'
	END AS Salary
FROM employees_logistic;

## JOINS
create table customer_new(customer_id int, customer_name varchar(250) , address varchar(400));

create table order_new(order_id int, order_date date, customer_id int, shipper_id int);


insert into customer_new values(1,'agsagdhas', 'ashgdhagdhgagd cgda'),
(2,'ssdagsagdhas', 'ashgdhagdhgagd cgda'),
(3,'h5agegsagdhas', 'ashgdhagdhg agd cgda'),
(4,'qwagsagdhas', 'ashgdhagdhgagd cgda'),
(5,'bbragsagdhas', 'ashgdhagdhgagd cgda');


insert into order_new values(1,'2022-05-05',1,2),
(2,'2022-05-05',6,2),
(3,'2022-05-05',7,2),
(4,'2022-05-05',2,2),
(5,'2022-05-05',3,2);


SELECT o.order_id AS OrderNumber, c.customer_name AS CustomerName
FROM order_new o
RIGHT OUTER JOIN customer_new c
USING (customer_id);

## DELETING JOINS
delete o,c
from order_new o
right join customer_new c
on o.customer_id=c.customer_id
where o.order_id is NULL;

SELECT DISTINCT *
FROM order_new o
JOIN customer_new c USING (customer_id)
WHERE c.customer_name LIKE 'c%';

## PARTITION.
## this query creates a table with year partitions, and 
## each time we add a new record, will be  grouped within 
## the corresponding partition.
## This way of partitioning (in mySQL), works only when we create a new table.
create table sales(id int not null auto_increment,
sale_date date not null,
amount DECIMAL(10,2) not null,
PRIMARY KEY(id,sale_date))
partition by range(year(sale_date))
(
partition p0 values less than (2010),
partition p1 values less than (2011),
partition p2 values less than (2012),
partition p3 values less than (2013),
partition p4 values less than (2014),
partition p5 values less than (2015),
partition p6 values less than (2016),
partition p7 values less than (2017),
partition p8 values less than (2018),
partition p9 values less than (2019),
partition p10 values less than MAXVALUE
);