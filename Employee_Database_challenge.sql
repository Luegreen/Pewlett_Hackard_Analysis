
--Challenge_7_part_1
--finding all retirement age employees and a count of which titles are retiring. 

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


SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

--INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;




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