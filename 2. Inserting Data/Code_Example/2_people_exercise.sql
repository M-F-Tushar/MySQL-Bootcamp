-- 2_people_exercise.sql
-- Exercise from README: create `people` table and insert several records.

-- NOTE: Run these scripts while connected to the target database. To run against
-- a specific database, add a line like `USE your_database;` below.
-- Example: USE my_bootcamp_db;

-- Create table
CREATE TABLE IF NOT EXISTS people (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);

-- Verify structure
DESCRIBE people;

-- Single inserts
INSERT INTO people (first_name, last_name, age) VALUES ('Tina', 'Belcher', 13);
INSERT INTO people (first_name, last_name, age) VALUES ('Bob', 'Belcher', 42);

-- Multiple insert
INSERT INTO people (first_name, last_name, age) VALUES
    ('Linda', 'Belcher', 45),
    ('Philip', 'Frond', 38),
    ('Calvin', 'Fischoeder', 70);

-- Verify all data
SELECT * FROM people;

-- Clean up (optional)
-- DROP TABLE people;
