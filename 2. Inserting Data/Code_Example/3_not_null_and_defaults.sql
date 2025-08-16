-- 3_not_null_and_defaults.sql
-- Demonstrates NOT NULL constraints and DEFAULT values.

-- NOTE: Run these scripts while connected to the target database. To run against
-- a specific database, add a line like `USE your_database;` below.
-- Example: USE my_bootcamp_db;

-- Create tables
CREATE TABLE IF NOT EXISTS cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE IF NOT EXISTS cats3 (
    name VARCHAR(100) DEFAULT 'mystery',
    age INT DEFAULT 99
);

CREATE TABLE IF NOT EXISTS cats4 (
    name VARCHAR(20) NOT NULL DEFAULT 'unnamed',
    age INT NOT NULL DEFAULT 99
);

-- Test NOT NULL behavior (expected to fail if uncommented)
-- INSERT INTO cats2 (name) VALUES ('Bilbo');
-- Correct insert
INSERT INTO cats2 (name, age) VALUES ('Bilbo', 19);

-- Test DEFAULT behavior
INSERT INTO cats3 (age) VALUES (2);
INSERT INTO cats3 () VALUES ();
SELECT * FROM cats3;

-- Test DEFAULT + NOT NULL
INSERT INTO cats4 () VALUES ();
-- This would fail if uncommented:
-- INSERT INTO cats4 (name, age) VALUES (NULL, NULL);

-- Verify structure
DESCRIBE cats2;
DESCRIBE cats3;
DESCRIBE cats4;

-- Clean up (optional)
-- DROP TABLE cats2;
-- DROP TABLE cats3;
-- DROP TABLE cats4;
