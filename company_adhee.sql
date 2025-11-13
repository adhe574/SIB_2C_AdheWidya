create table employees (
	id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) unique not null,
	department varchar(50),
	position varchar(50),
	salary decimal(10,2),
	hire_date date,
	created_at timestamp default current_timestamp
);

create table projects (
	id serial primary key,
	project_name varchar(100) not null,
	department varchar(50),
	budget decimal(12,2),
	start_date date,
	end_date date,
	status varchar(20) default 'Active'
);

-- Mengisi data employees (20 records) 
INSERT INTO employees (first_name, last_name, email, department, position, 
salary, hire_date) VALUES 
('Ahmad', 'Hidayat', 'ahmad.hidayat@company.com', 'IT', 'Software Engineer', 
8500000, '2022-01-15'), 
('Siti', 'Rahayu', 'siti.rahayu@company.com', 'HR', 'HR Manager', 9500000, 
'2021-03-20'), 
('Budi', 'Santoso', 'budi.santoso@company.com', 'Finance', 'Accountant', 
7500000, '2022-06-10'), 
('Dewi', 'Anggraini', 'dewi.anggraini@company.com', 'Marketing', 'Marketing 
Specialist', 7000000, '2023-02-01'), 
('Rizki', 'Pratama', 'rizki.pratama@company.com', 'IT', 'System Administrator', 
8000000, '2021-11-05'), 
('Maya', 'Sari', 'maya.sari@company.com', 'Finance', 'Financial Analyst', 
8200000, '2022-08-15'), 
('Joko', 'Widodo', 'joko.widodo@company.com', 'Operations', 'Operations 
Manager', 11000000, '2020-05-12'), 
('Linda', 'Permata', 'linda.permata@company.com', 'Marketing', 'Digital 
Marketer', 6800000, '2023-01-30'), 
('Fajar', 'Nugroho', 'fajar.nugroho@company.com', 'IT', 'Web Developer', 
7800000, '2022-09-22'), 
('Rina', 'Wulandari', 'rina.wulandari@company.com', 'HR', 'Recruitment 
Specialist', 6500000, '2023-03-10'), 
('Hendra', 'Kurniawan', 'hendra.kurniawan@company.com', 'Finance', 'Tax 
Officer', 7200000, '2022-04-18'), 
('Dian', 'Puspita', 'dian.puspita@company.com', 'IT', 'Database Administrator', 
9000000, '2021-07-25'), 
('Eko', 'Supriyanto', 'eko.supriyanto@company.com', 'Operations', 'Logistics 
Coordinator', 6000000, '2023-05-05'), 
('Fitri', 'Handayani', 'fitri.handayani@company.com', 'Marketing', 'Content 
Creator', 5800000, '2023-04-12'), 
('Gita', 'Maharani', 'gita.maharani@company.com', 'HR', 'Training Officer', 
6200000, '2022-12-01'), 
('Irfan', 'Setiawan', 'irfan.setiawan@company.com', 'IT', 'Network Engineer', 
8300000, '2021-09-14'), 
('Kartika', 'Dewi', 'kartika.dewi@company.com', 'Finance', 'Auditor', 7700000, 
'2022-03-08'), 
('Lukman', 'Hakim', 'lukman.hakim@company.com', 'Operations', 'Warehouse 
Manager', 7300000, '2021-12-20'), 
('Nina', 'Zahra', 'nina.zahra@company.com', 'Marketing', 'Social Media 
Specialist', 5900000, '2023-06-25'), 
('Oscar', 'Fernando', 'oscar.fernando@company.com', 'IT', 'Mobile Developer', 
8100000, '2022-11-11');

-- Mengisi data projects (10 records) 
INSERT INTO projects (project_name, department, budget, start_date, end_date, 
status) VALUES 
('Website Redesign', 'IT', 150000000, '2024-01-01', '2024-06-30', 'Active'), 
('Employee Training Program', 'HR', 75000000, '2024-02-01', '2024-05-31', 
'Active'), 
('Financial System Upgrade', 'Finance', 200000000, '2024-03-01', '2024-08-31', 
'Planning'), 
('Digital Marketing Campaign', 'Marketing', 120000000, '2024-01-15', '2024-04-30', 'Active'), 
('Warehouse Optimization', 'Operations', 90000000, '2024-02-20', '2024-07-15', 
'Active'), 
('Mobile App Development', 'IT', 180000000, '2024-03-10', '2024-09-30', 
'Planning'), 
('Recruitment Drive 2024', 'HR', 50000000, '2024-04-01', '2024-06-30', 
'Active'), 
('Customer Satisfaction Survey', 'Marketing', 40000000, '2024-03-15', '2024-05-31', 'Active'), 
('Network Infrastructure', 'IT', 220000000, '2024-05-01', '2024-12-31', 
'Planning'), 
('Annual Audit Preparation', 'Finance', 60000000, '2024-04-15', '2024-07-31', 
'Active'); 

select * from employees;
select * from projects;

-- VIEW 1: Employee Summary dengan informasi lengkap 
CREATE VIEW employee_summary AS 
SELECT  
    id, 
    CONCAT(first_name, ' ', last_name) AS full_name, 
    department, 
    position, 
    salary, 
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) AS years_of_service, 
    CASE  
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) >= 3 THEN 'Senior' 
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) >= 1 THEN 
'Intermediate' 
        ELSE 'Junior' 
    END AS experience_level 
FROM employees 
ORDER BY department, salary DESC; 

select * from employee_summary;

-- VIEW 2: Department Statistics
CREATE VIEW department_stats AS 
SELECT 
	department,
	COUNT(*) as total_employees,
	ROUND(AVG(salary), 2) as avg_salary,
	MIN(salary) as min_salary,
	MAX(salary) as max_salary,
	SUM(salary) as total_salary_budget
FROM employees
GROUP BY department
ORDER BY total_employees DESC;

select * from department_stats;

-- MATERIALIZED VIEW 1: Dashboard Summary
CREATE MATERIALIZED VIEW dashboard_summary AS
SELECT
    -- Total counts
    (SELECT COUNT(*) FROM employees) as total_employees,
    (SELECT COUNT(*) FROM projects) as total_projects,
    (SELECT COUNT(DISTINCT department) FROM employees) as total_departments,

    -- Salary statistics
    (SELECT ROUND(AVG(salary), 2) FROM employees) as company_avg_salary,
    (SELECT MAX(salary) FROM employees) as highest_salary,
    (SELECT MIN(salary) FROM employees) as lowest_salary,

    -- Project statistics
    (SELECT SUM(budget) FROM projects) as total_project_budget,
    (SELECT COUNT(*) FROM projects WHERE status = 'Active') as active_projects,
    (SELECT COUNT(*) FROM projects WHERE status = 'Planning') as planning_projects,

    -- Employee tenure
    (SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date))), 1) FROM employees) as avg_years_service;

-- Refresh materialized view 
REFRESH MATERIALIZED VIEW dashboard_summary;

CREATE MATERIALIZED VIEW salary_stats_mv AS
SELECT 
    department,
    ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

REFRESH MATERIALIZED VIEW salary_stats_mv;

SELECT COUNT(*) FROM employees;

CREATE MATERIALIZED VIEW tenure_stats_mv AS
SELECT 
    CASE
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) < 1 THEN 'Junior'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) BETWEEN 1 AND 3 THEN 'Middle'
        ELSE 'Senior'
    END AS experience_level,
    COUNT(*) AS total_employees
FROM employees
GROUP BY experience_level
ORDER BY experience_level;

DROP MATERIALIZED VIEW IF EXISTS tenure_stats_mv;

CREATE MATERIALIZED VIEW tenure_stats_mv AS
SELECT 
    CASE
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) < 1 THEN 'Junior'
        WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) BETWEEN 1 AND 3 THEN 'Middle'
        ELSE 'Senior'
    END AS experience_level,
    COUNT(*) AS employee_count
FROM employees
GROUP BY 1;

DROP MATERIALIZED VIEW IF EXISTS tenure_stats_mv;

CREATE MATERIALIZED VIEW tenure_stats_mv AS
SELECT 
    CASE 
        WHEN AGE(CURRENT_DATE, hire_date) < INTERVAL '1 year' THEN 'Junior'
        WHEN AGE(CURRENT_DATE, hire_date) BETWEEN INTERVAL '1 year' AND INTERVAL '3 years' THEN 'Middle'
        ELSE 'Senior'
    END AS tenure_level,
    COUNT(*) AS total_employees,
    STRING_AGG(first_name || ' ' || last_name, ', ') AS employee_names
FROM employees
GROUP BY tenure_level
ORDER BY total_employees DESC;

CREATE MATERIALIZED VIEW employee_overview_mv AS
SELECT 
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) + 
              EXTRACT(MONTH FROM AGE(CURRENT_DATE, hire_date)) / 12), 2) AS avg_years_of_service
FROM employees;

CREATE OR REPLACE FUNCTION get_employees_by_salary_range(
    min_salary DECIMAL,
    max_salary DECIMAL
)
RETURNS TABLE (
    id INT,
    full_name TEXT,
    department TEXT,
    "position" TEXT,
    salary DECIMAL
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.id,
        e.first_name || ' ' || e.last_name AS full_name,
        e.department,
        e."position",
        e.salary
    FROM employees e
    WHERE e.salary BETWEEN min_salary AND max_salary
    ORDER BY e.salary;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_employees_by_salary_range(3000000, 8000000);

DROP FUNCTION get_employees_by_salary_range(DECIMAL, DECIMAL);

CREATE OR REPLACE FUNCTION get_employees_by_salary_range(
    min_salary DECIMAL,
    max_salary DECIMAL
)
RETURNS TABLE (
    id INT,
    full_name VARCHAR(100),
    department VARCHAR(50),
    "position" VARCHAR(50),
    salary DECIMAL
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.id,
        (e.first_name || ' ' || e.last_name)::VARCHAR(100) AS full_name,
        e.department,
        e."position",
        e.salary
    FROM employees e
    WHERE e.salary BETWEEN min_salary AND max_salary
    ORDER BY e.salary;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_employees_by_salary_range(3000000, 8000000);

CREATE OR REPLACE FUNCTION get_department_summary()
RETURNS TABLE (
    department VARCHAR(50),
    employee_count BIGINT,
    avg_salary NUMERIC,
    total_budget NUMERIC
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.department,
        COUNT(*) AS employee_count,
        ROUND(AVG(e.salary), 2) AS avg_salary,
        SUM(e.salary) AS total_budget
    FROM employees e
    GROUP BY e.department
    ORDER BY e.department;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_department_summary();

DROP FUNCTION get_employees_by_salary_range(DECIMAL, DECIMAL);

CREATE OR REPLACE FUNCTION get_department_summary()
RETURNS TABLE (
    department VARCHAR(50),
    employee_count BIGINT,
    avg_salary NUMERIC,
    total_budget NUMERIC
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.department,
        COUNT(*) AS employee_count,
        ROUND(AVG(e.salary), 2) AS avg_salary,
        SUM(e.salary) AS total_budget
    FROM employees e
    GROUP BY e.department
    ORDER BY e.department;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION get_department_summary();

CREATE OR REPLACE FUNCTION get_department_summary()
RETURNS TABLE (
    department VARCHAR(50),
    employee_count BIGINT,
    avg_salary NUMERIC(15,2),
    total_budget NUMERIC(15,2)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.department,
        COUNT(*)::BIGINT AS employee_count,
        ROUND(AVG(e.salary), 2) AS avg_salary,
        SUM(e.salary) AS total_budget
    FROM employees e
    GROUP BY e.department
    ORDER BY e.department;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_department_summary();
