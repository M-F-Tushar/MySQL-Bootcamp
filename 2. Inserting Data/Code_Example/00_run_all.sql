-- 00_run_all.sql
-- Wrapper file to run the lesson scripts in a sensible order.
-- IMPORTANT: Edit or add a USE statement to target your database before running.
-- Example:
-- USE my_bootcamp_db;

-- NOTE: This file concatenates other scripts. If you prefer, run each script separately.

-- (1) Cats basic inserts
SOURCE "e:/Git Clone/MySQL-Bootcamp/2. Inserting Data/Code_Example/1_create_and_insert_cats.sql";

-- (2) People exercise
SOURCE "e:/Git Clone/MySQL-Bootcamp/2. Inserting Data/Code_Example/2_people_exercise.sql";

-- (3) NOT NULL and DEFAULT examples
SOURCE "e:/Git Clone/MySQL-Bootcamp/2. Inserting Data/Code_Example/3_not_null_and_defaults.sql";

-- (4) Primary key and AUTO_INCREMENT examples
SOURCE "e:/Git Clone/MySQL-Bootcamp/2. Inserting Data/Code_Example/4_primary_key_and_autoinc.sql";

-- (5) Employees exercise
SOURCE "e:/Git Clone/MySQL-Bootcamp/2. Inserting Data/Code_Example/5_employees_exercise.sql";

-- End
