-- Demonstrates basic CREATE TABLE and INSERT usage from the README.

-- NOTE: Run these scripts while connected to the target database. To run against
-- a specific database, add a line like `USE your_database;` below.
-- Example: USE my_bootcamp_db;

-- Create table
CREATE TABLE IF NOT EXISTS cats (
    name VARCHAR(50),
    age INT
);

-- Single inserts
INSERT INTO cats (name, age) VALUES ('Blue Steele', 5);
INSERT INTO cats (name, age) VALUES ('Jenkins', 7);

-- Column order flexibility
INSERT INTO cats (age, name) VALUES (2, 'Beth');
INSERT INTO cats (name, age) VALUES ('Mittens', 3);

-- Multiple-row (batch) insert
INSERT INTO cats (name, age) VALUES
  ('Meatball', 5),
  ('Turkey', 1),
  ('Potato Face', 15);

-- Verify data
SELECT * FROM cats;

-- Clean up (optional)
-- DROP TABLE cats;
