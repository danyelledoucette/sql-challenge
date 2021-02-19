-- DROP TABLES IF THEY ALREADY EXIST/REFRESH TABLES
DROP TABLE departments

-- CREATE TABLES TO INPUT CSV FILES
CREATE TABLE departments (
	dept_no VARCHAR,
	dept_name VARCHAR
);

-- IMPORT DATA TO CHART AND CHECK TO SEE IF DATA IS THERE
SELECT * FROM departments;

-- REPEAT FOR OTHER CHARTS & FILES
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT
);

SELECT * FROM dept_manager;

CREATE TABLE employees (
	emp_no INT,
	emp_title_id VARCHAR,
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date VARCHAR
);

SELECT * FROM employees;


CREATE TABLE salaries (
	emp_no INT,
	salary INT
);

SELECT * FROM salaries;


CREATE TABLE titles (
	title_id VARCHAR,
	title VARCHAR
);

SELECT * FROM titles;

-- DATA ANALYSIS
-- LIST DETAILS OF EACH EMPLOYEE:
-- EMPLOYEE NUMBER, LAST NAME, FIRST NAME, SEX, AND SALARY
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary 
FROM 
	salaries AS s
INNER JOIN 
	employees AS e ON
e.emp_no=s.emp_no;

-- LIST FIRST NAME, LAST NAME, AND HIRE DATE FOR EMPLOYEES HIRED IN 1986
SELECT 
	e.first_name, 
	e.last_name, 
	e.hire_date  
FROM 
	employees AS e	
WHERE 
	hire_date BETWEEN '01/01/1986' AND '12/31/1986'


