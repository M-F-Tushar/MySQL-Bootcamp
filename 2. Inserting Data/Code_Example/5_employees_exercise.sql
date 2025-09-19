-- 5_employees_exercise.sql
-- Comprehensive exercise from README: employees table with AUTO_INCREMENT, NOT NULL, DEFAULT.

-- NOTE: Run these scripts while connected to the target database. To run against
-- a specific database, add a line like `USE your_database;` below.
-- Example: USE my_bootcamp_db;


CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    age INT NOT NULL,
    current_status VARCHAR(100) NOT NULL DEFAULT 'employed'
);

-- Verify structure
DESCRIBE employees;

-- Test with a complete insert
INSERT INTO employees (first_name, last_name, age) VALUES ('Thomas', 'Chickenman', 87);

-- This should fail (missing required age) if uncommented
-- INSERT INTO employees (first_name, last_name) VALUES ('Jane', 'Doe');

-- Multiple inserts
INSERT INTO employees (first_name, last_name, age, current_status) VALUES
    ('Alice', 'Johnson', 30, 'contractor'),
    ('Bob', 'Smith', 45, 'on leave'),
    ('Carol', 'Brown', 28, 'employed');

-- Verify
SELECT * FROM employees;

-- Clean up (optional)
-- DROP TABLE employees;
