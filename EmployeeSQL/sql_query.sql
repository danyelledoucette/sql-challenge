-- DROP TABLES IF THEY ALREADY EXIST/REFRESH TABLES
DROP TABLE departments;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;
DROP TABLE department_employees;


-- CREATE TABLES TO INPUT CSV FILES
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR NOT NULL
);

CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE department_employees (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- IMPORT DATA TO TABLES THEN CHECK THAT DATA IS IN TABLES
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM department_employees;


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
	employees AS e 
	ON e.emp_no=s.emp_no;

-- CHANGE COLUMN TYPE TO 'DATE' FOR HIRE_DATE AND BIRTH_DATE
ALTER TABLE employees alter column hire_date type date using hire_date::date;
ALTER TABLE employees alter column birth_date type date using birth_date::date;



-- LIST FIRST NAME, LAST NAME, AND HIRE DATE FOR EMPLOYEES HIRED IN 1986

SELECT 
	e.first_name, 
	e.last_name, 
	e.hire_date  
FROM employees AS e	
WHERE hire_date BETWEEN '01/01/1986' AND '12/31/1986';

SELECT * FROM employees;



-- List the manager of each department with the following 
-- information: department number, department name, 
-- the manager's employee number, last name, first name.

SELECT 
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	e.last_name,
	e.first_name
FROM 
	dept_manager AS dm
JOIN 
	departments AS d 
	ON dm.dept_no=d.dept_no
JOIN
	employees as e 
	ON dm.emp_no=e.emp_no;



-- List the department of each employee with the following 
-- information: employee number, last name, first name, and department name.

SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM 
	employees AS e
JOIN 
	dept_manager AS dm 
	ON e.emp_no=dm.emp_no
JOIN
	departments as d 
	ON dm.dept_no=d.dept_no;



-- List first name, last name, and sex for employees whose first name is 
-- "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';



-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM 
	employees AS e
JOIN 
	department_employees AS de 
	ON e.emp_no = de.emp_no
JOIN departments AS d
	ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';



-- List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.

SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees as e
JOIN
	department_employees AS de
	ON e.emp_no = de.emp_no
JOIN
	departments as d
	ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales' 
	OR dept_name = 'Development';
	
	

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT
	last_name, COUNT(last_name) 
FROM employees
GROUP BY last_name
ORDER BY count(last_name) desc;

-- Epilogue: ...you hear the words, "Search your ID number." 
-- You look down at your badge to see that your employee ID number is 499942.

SELECT * 
FROM employees AS e
WHERE e.emp_no = '499942';

