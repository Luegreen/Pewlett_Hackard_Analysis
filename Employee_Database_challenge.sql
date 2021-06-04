--Challenge_7_part_1
--finding all retirement age employees and a count of which titles are retiring. 

--create table of retires with titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ts.title,
	ts.from_date,
	ts.to_date
--INTO retirement_titles
FROM employees as e
INNER JOIN titles as ts
ON e.emp_no = ts.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--de-dupe table of retirees
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;



--count retirees by title
SELECT
COUNT(*)
AS "count",
title
INTO retiring_titles
FROM unique_titles as ut 
GROUP BY ut.title
ORDER BY "count" DESC;
SELECT * FROM unique_titles
;

--Challenge_7_part_2
--finding employees eligible for the mentorship program

--table of mentor eligible employees
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	ts.title,
	de.from_date,
	de.to_date
INTO mentorship_eligibility
FROM titles as ts
	INNER JOIN dept_emp as de
	ON ts.emp_no = de.emp_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY e.emp_no;

DROP TABLE mentorship_eligibility;
SELECT * FROM dept_cnt;
SELECT * FROM retirement_titles;

--de dupe mentor eligible employees table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (to_date ='9999-01-01')
ORDER BY e.emp_no
;


--count mentor potential candidates by title
SELECT
COUNT(*)
AS "count",
title
INTO mentorship_titles_cnt
FROM mentorship_eligibility as me 
GROUP BY me.title
ORDER BY "count" DESC;


SELECT * FROM mentorship_titles_cnt
;

--Challenge_7_part_3
--finding all retirement age employees and a count of how many in which department are retiring. 

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name,
	de.from_date,
	de.to_date
INTO retirement_depts
FROM departments as d
	INNER JOIN dept_emp as de
	ON d.dept_no = de.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	ORDER BY e.emp_no;


SELECT
COUNT(*)
AS "count",
dept_name
INTO retirement_depts_cnt
FROM retirement_depts as rd 
GROUP BY rd.dept_name
ORDER BY "count" DESC;

DROP TABLE retirement_depts_cnt;

SELECT * FROM retirement_depts_cnt;
;

--Challenge_7_part_4
--Count how many of mentor age from which depts. 

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name,
	de.from_date,
	de.to_date
INTO mentorship_depts
FROM departments as d
	INNER JOIN dept_emp as de
	ON d.dept_no = de.dept_no
	INNER JOIN employees AS e
	ON e.emp_no = de.emp_no
	WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY e.emp_no;

SELECT * FROM mentorship_depts;
SELECT * FROM retirement_titles;
SELECT * FROM mentorship_depts_cnt;


SELECT
COUNT(*)
AS "count",
dept_name
INTO mentorship_depts_cnt
FROM retirement_depts as rd 
GROUP BY rd.dept_name
ORDER BY "count" DESC;
