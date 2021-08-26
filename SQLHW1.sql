CREATE TABLE departments(
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE employees(
	emp_no INT NOT NULL,
	emp_title VARCHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR (4) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles(
	title_id VARCHAR (5) NOT NULL,
	title VARCHAR(30) NOT NULL,
	PRIMARY KEY (title_id)
);

CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	PRIMARY KEY (emp_no)
);

--Question 1 --
SELECT emp.emp_no,
	emp.first_name, 
	emp.last_name, 
	emp.sex,
	sal.salary
	FROM employees AS emp
	LEFT JOIN salaries AS sal
	ON (emp.emp_no=sal.emp_no)
	ORDER BY emp.emp_no;

--Question 2 --
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/01/1986' AND '12/31/1986';

--Question 3 --
SELECT departs.dept_name,
	emp.first_name,
	emp.last_name,
	departm.emp_no,
	departm.dept_no 
	FROM dept_manager AS departm
	INNER JOIN departments AS departs
	ON (departs.dept_no = departm.dept_no)
	INNER JOIN employees AS emp
	ON (departm.emp_no = emp.emp_no);

	
--Question 4 --
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	departs.dept_name
	FROM employees AS emp
	INNER JOIN dept_emp AS departe
	ON (departe.emp_no = emp.emp_no)
	INNER JOIN departments AS departs
	ON (departs.dept_no = departe.dept_no);

--Question 5 --
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--Question 6 --
SELECT first_name, last_name, emp_no
FROM employees
INNER JOIN dept_emp AS departe
ON (employees.emp_no = departe.emp_no)
INNER JOIN departments AS departs
ON (departe.dept_no = departs.dept_no)
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
	(
		SELECT dept_no 
		FROM Departments
		Where dept_name = 'Sales'
	)
);

--Question 7 --
SELECT first_name, last_name, emp_no
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
	(
		SELECT dept_no 
		FROM Departments
		Where dept_name = 'Sales' OR dept_name = 'Development'
	)
);

--Question 8 --
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;