-- 4_primary_key_and_autoinc.sql
-- Demonstrates PRIMARY KEY and AUTO_INCREMENT behavior.

-- NOTE: Run these scripts while connected to the target database. To run against
-- a specific database, add a line like `USE your_database;` below.
-- Example: USE my_bootcamp_db;

-- Primary key inline
CREATE TABLE IF NOT EXISTS unique_cats (
    cat_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Primary key separate definition
CREATE TABLE IF NOT EXISTS unique_cats2 (
    cat_id INT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);

-- AUTO_INCREMENT example
CREATE TABLE IF NOT EXISTS unique_cats3 (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Insert examples
INSERT INTO unique_cats (cat_id, name, age) VALUES (1, 'Bingo', 2);
-- Duplicate primary key would fail:
-- INSERT INTO unique_cats (cat_id, name, age) VALUES (1, 'Bongo', 3);
INSERT INTO unique_cats (cat_id, name, age) VALUES (2, 'Bongo', 3);

-- AUTO_INCREMENT inserts (no id provided)
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
INSERT INTO unique_cats3 (name, age) VALUES ('Muffin', 2);
INSERT INTO unique_cats3 (name, age) VALUES ('Shadow', 3);

SELECT * FROM unique_cats;
SELECT * FROM unique_cats3;

-- Clean up (optional)
-- DROP TABLE unique_cats;
-- DROP TABLE unique_cats2;
-- DROP TABLE unique_cats3;
