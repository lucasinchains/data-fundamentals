USE classicmodels;

## GROUP BY, HAVING and AGG FUNCTIONS
SELECT *, AVG(amount) AS 'avg'
FROM payments
WHERE customerNumber > 115
GROUP BY customerNumber
HAVING avg > 15000
ORDER BY customerNumber
;

SELECT firstName AS employee_firstname, 
	lastName AS employee_lastname, 
	customers.customerName, 
	payments.checkNumber, 
	payments.amount 
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
LEFT JOIN payments p ON p.customerNumber = c.customerNumber
ORDER BY customerName, checkNumber;

SELECT *
FROM (
SELECT employeeNumber, 
	customerNumber, 
    customerName, 
    SUM(amount) AS total_amount, 
    rank() OVER (ORDER BY SUM(amount) DESC) AS rank_
FROM customers c
JOIN payments p USING (customerNumber)
JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeNumber, customerNumber, customerName
) AS q1
WHERE q1.rank_ = 1;



## REG EXPRESSIONS and RLiKE
SELECT * FROM employees WHERE lastName regexp '^[mb]'; # find last names that begin with M or B

SELECT * FROM employees WHERE lastName regexp 's$'; # find last names ending with letter S

SELECT * FROM employees WHERE lastName regexp '^.{5}$'; # find last names beginning and having any chrs, but with 5 letters max

SELECT * FROM employees WHERE lastName regexp 'So'; # Find last names that contains "so" in it

SELECT ('A' REGEXP '[A-Z]') AS MATCH_;
SELECT ('A' RLIKE '[B-Z]') AS NOT_MATCH;

SELECT REGEXP_LIKE('Petter', '^P', 'c'); ## check 

SHOW indexes FROM employees;
EXPLAIN SELECT employeeNumber FROM employees;
EXPLAIN SELECT customerNumber FROM customers;
EXPLAIN SELECT textDescription FROM productlines;
SELECT last_insert_id();

SHOW indexes FROM customers;