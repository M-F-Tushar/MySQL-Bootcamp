# Complete MySQL INSERT and Table Creation Guide

## Section Overview

This section covers two fundamental MySQL operations:
1. **INSERT**: Adding data into tables
2. **SELECT**: Retrieving data from tables (basic preview)

### Learning Goals
- Master the INSERT command for adding data to tables
- Understand basic SELECT queries to verify inserted data
- Learn table constraints (NOT NULL, DEFAULT, PRIMARY KEY)
- Practice with hands-on exercises

---

## 1. INSERT Statement Basics

### What is INSERT?
The INSERT statement is used to add new rows of data into existing tables. It follows a specific syntax pattern.

### Basic INSERT Syntax
```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

### Key Components
- **INSERT INTO**: Keywords to start the insert operation
- **table_name**: The target table where data will be inserted
- **Column list**: Specifies which columns will receive data and their order
- **VALUES**: Keyword followed by the actual data values
- **Semicolon (;)**: Terminates the SQL statement

### Example: Creating and Inserting into a Cats Table

First, create a simple table:
```sql
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);
```

Insert a single cat:
```sql
INSERT INTO cats (name, age) 
VALUES ('Blue Steele', 5);
```

Insert another cat:
```sql
INSERT INTO cats (name, age) 
VALUES ('Jenkins', 7);
```

### Formatting Flexibility
All these formats are equivalent:
```sql
-- Single line
INSERT INTO cats (name, age) VALUES ('Blue Steele', 5);

-- Multiple lines
INSERT INTO cats (name, age) 
VALUES ('Blue Steele', 5);

-- With different spacing
INSERT INTO cats 
(name, age) 
VALUES 
('Blue Steele', 5);
```

---

## 2. Previewing SELECT (Quick Introduction)

### Why Learn SELECT Now?
To verify that our INSERT operations worked correctly, we need a way to view the data. SELECT is fully covered in the next section, but here's the basic usage.

### Basic SELECT Syntax
```sql
SELECT * FROM table_name;
```

- **SELECT**: Keyword to retrieve data
- **\***: Asterisk means "all columns"
- **FROM**: Keyword followed by table name

### Verifying Our Inserts
```sql
SELECT * FROM cats;
```

**Expected Output:**
```
+------------+-----+
| name       | age |
+------------+-----+
| Blue Steele| 5   |
| Jenkins    | 7   |
+------------+-----+
```

This confirms:
- Names are in the name column
- Ages are in the age column
- Both rows were inserted successfully

---

## 3. Understanding Column Order and Multiple Inserts

### Column Order Flexibility
The order of columns in your INSERT statement can be changed, but values must match the specified order.

**Example 1: Age first, then name**
```sql
INSERT INTO cats (age, name) 
VALUES (2, 'Beth');
```

**Example 2: Standard order (name first)**
```sql
INSERT INTO cats (name, age) 
VALUES ('Mittens', 3);
```

### What Happens with Wrong Order?
If you specify columns in one order but provide values in a different order:

```sql
-- This will cause an ERROR
INSERT INTO cats (name, age) 
VALUES (8, 'Linus');  -- age value where name expected
```

**Error Message:**
```
ERROR: Incorrect integer value 'Linus' for column 'age'
```

This error prevents the row from being inserted, protecting data integrity.

### Multiple Inserts (Batch Insert)
Instead of multiple INSERT statements, you can insert several rows at once:

```sql
INSERT INTO cats (name, age) 
VALUES 
  ('Meatball', 5), 
  ('Turkey', 1), 
  ('Potato Face', 15);
```

### Formatting Multiple Inserts
For readability with many values, you can align them:
```sql
INSERT INTO cats (name, age) 
VALUES 
  ('Meatball',     5), 
  ('Turkey',       1), 
  ('Potato Face', 15);
```

**Benefits of Multiple Inserts:**
- More efficient than separate INSERT statements
- Reduces network overhead
- Faster execution
- Cleaner code

---

## 4. Exercise: People Table Creation and Population

### Exercise Requirements
Create a table called `people` with these specifications:

**Table Structure:**
- `first_name`: Text, maximum 20 characters
- `last_name`: Text, maximum 20 characters  
- `age`: Integer (whole number)

**Data to Insert:**
1. Single insert: Tina Belcher, age 13
2. Single insert: Bob Belcher, age 42
3. Multiple insert: Linda Belcher (45), Philip Frond (38), Calvin Fischoeder (70)

### Exercise Solution

**Step 1: Create the table**
```sql
CREATE TABLE people (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
);
```

**Step 2: Verify table structure**
```sql
DESCRIBE people;
```

**Step 3: Insert first person**
```sql
INSERT INTO people (first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13);
```

**Step 4: Insert second person**
```sql
INSERT INTO people (first_name, last_name, age)
VALUES ('Bob', 'Belcher', 42);
```

**Step 5: Multiple insert for remaining people**
```sql
INSERT INTO people (first_name, last_name, age)
VALUES
    ('Linda', 'Belcher', 45),
    ('Philip', 'Frond', 38),
    ('Calvin', 'Fischoeder', 70);
```

**Step 6: Verify all data**
```sql
SELECT * FROM people;
```

**Step 7: Clean up (optional)**
```sql
DROP TABLE people;
```

---

## 5. Working with NOT NULL Constraints

### Understanding NULL Values
- **NULL**: Represents "no value" or "unknown value"
- Different from zero (0) or empty string ('')
- NULL means the absence of any data

### Current Table Behavior
When you describe a table:
```sql
DESCRIBE cats;
```

You'll see:
```
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(50) | YES  |     | NULL    |       |
| age   | int         | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
```

**"Null: YES"** means NULL values are allowed.

### Problems with Allowing NULL
You can insert incomplete data:
```sql
-- Insert cat with name but no age
INSERT INTO cats (name) VALUES ('Todd');

-- Insert completely empty cat
INSERT INTO cats () VALUES ();
```

**Result:**
```sql
SELECT * FROM cats;
```
```
+------------+------+
| name       | age  |
+------------+------+
| Blue Steele| 5    |
| Jenkins    | 7    |
| Todd       | NULL |
| NULL       | NULL |
+------------+------+
```

### Adding NOT NULL Constraints
Create a table that requires values:

```sql
CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
```

### Testing NOT NULL Constraints
**Attempt to insert incomplete data:**
```sql
INSERT INTO cats2 (name) VALUES ('Bilbo');
```

**Error Message:**
```
ERROR: Field 'age' doesn't have a default value
```

**Successful insert with all required data:**
```sql
INSERT INTO cats2 (name, age) VALUES ('Bilbo', 19);
```

### Verifying NOT NULL Constraints
```sql
DESCRIBE cats2;
```

**Output:**
```
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(100)| NO   |     | NULL    |       |
| age   | int         | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
```

Notice **"Null: NO"** - NULL values are not permitted.

---

## 6. MySQL Quotes and Text Handling

### Quote Rules in MySQL
- **Always use single quotes** for text values in MySQL
- Double quotes work in MySQL but not in other SQL databases
- Single quotes ensure compatibility across all SQL systems

### Basic Text Insertion
```sql
INSERT INTO shops (name) VALUES ('Shoe Emporium');
```

### Handling Quotes Within Text
**Problem:** What if your text contains an apostrophe?
```sql
-- This will cause an ERROR
INSERT INTO shops (name) VALUES ('Mario's Pizza');
```

**Solution:** Escape the quote with a backslash
```sql
INSERT INTO shops (name) VALUES ('Mario\'s Pizza');
```

### Mixing Quote Types
**Double quotes inside single quotes (no escaping needed):**
```sql
INSERT INTO shops (name) VALUES ('She said "Hello"');
```

### Best Practices
1. Always use single quotes for text
2. Escape internal single quotes with backslash (\')
3. Double quotes inside single quotes don't need escaping

---

## 7. DEFAULT Values

### Understanding DEFAULT Constraints
DEFAULT values are automatically used when no value is provided for a column during INSERT.

### Syntax for DEFAULT Values
```sql
CREATE TABLE table_name (
    column_name datatype DEFAULT default_value
);
```

### Example: Cats Table with Defaults
```sql
CREATE TABLE cats3 (
    name VARCHAR(100) DEFAULT 'mystery',
    age INT DEFAULT 99
);
```

### Testing DEFAULT Values

**Insert with missing name:**
```sql
INSERT INTO cats3 (age) VALUES (2);
SELECT * FROM cats3;
```

**Result:**
```
+---------+-----+
| name    | age |
+---------+-----+
| mystery | 2   |
+---------+-----+
```

**Insert with no values at all:**
```sql
INSERT INTO cats3 () VALUES ();
SELECT * FROM cats3;
```

**Result:**
```
+---------+-----+
| name    | age |
+---------+-----+
| mystery | 2   |
| mystery | 99  |
+---------+-----+
```

### DEFAULT vs NOT NULL
**Important:** DEFAULT doesn't prevent NULL values unless combined with NOT NULL.

**You can still manually insert NULL:**
```sql
INSERT INTO cats3 (name, age) VALUES (NULL, NULL);
```

### Combining DEFAULT with NOT NULL
```sql
CREATE TABLE cats4 (
    name VARCHAR(20) NOT NULL DEFAULT 'unnamed',
    age INT NOT NULL DEFAULT 99
);
```

**Benefits:**
- Provides default values when no input given
- Prevents NULL values from being manually inserted
- Ensures data consistency

**Testing the combination:**
```sql
-- This works (uses defaults)
INSERT INTO cats4 () VALUES ();

-- This fails (manual NULL not allowed)
INSERT INTO cats4 (name, age) VALUES (NULL, NULL);
```

### Viewing DEFAULT Values
```sql
DESCRIBE cats4;
```

**Output shows default values:**
```
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(20) | NO   |     | unnamed |       |
| age   | int         | NO   |     | 99      |       |
+-------+-------------+------+-----+---------+-------+
```

---

## 8. PRIMARY KEY Concepts

### What is a PRIMARY KEY?
A PRIMARY KEY is a column (or combination of columns) that uniquely identifies each row in a table.

### Problems Without Unique Identifiers
Consider this data:
```
+----------+-----+
| name     | age |
+----------+-----+
| unnamed  | 99  |
| unnamed  | 99  |
| unnamed  | 99  |
+----------+-----+
```

**Issues:**
- Cannot distinguish between rows
- Difficult to update or delete specific rows
- No way to reference individual records

### PRIMARY KEY Characteristics
1. **UNIQUE**: No two rows can have the same primary key value
2. **NOT NULL**: Primary key cannot be empty (automatically enforced)
3. **IMMUTABLE**: Should not change after creation
4. **SIMPLE**: Usually a single integer column

### Creating Tables with PRIMARY KEY

**Method 1: Inline definition**
```sql
CREATE TABLE unique_cats (
    cat_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
```

**Method 2: Separate definition**
```sql
CREATE TABLE unique_cats2 (
    cat_id INT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);
```

### Testing PRIMARY KEY Constraints

**First insert (works fine):**
```sql
INSERT INTO unique_cats (cat_id, name, age) 
VALUES (1, 'Bingo', 2);
```

**Duplicate primary key (causes error):**
```sql
INSERT INTO unique_cats (cat_id, name, age) 
VALUES (1, 'Bongo', 3);
```

**Error Message:**
```
ERROR: Duplicate entry '1' for key 'PRIMARY'
```

**Successful insert with unique key:**
```sql
INSERT INTO unique_cats (cat_id, name, age) 
VALUES (2, 'Bongo', 3);
```

### Viewing PRIMARY KEY Information
```sql
DESCRIBE unique_cats;
```

**Output:**
```
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| cat_id | int          | NO   | PRI | NULL    |       |
| name   | varchar(100) | NO   |     | NULL    |       |
| age    | int          | NO   |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
```

Notice **"Key: PRI"** indicates the primary key column.

---

## 9. AUTO_INCREMENT Feature

### The Problem with Manual IDs
Manually managing unique ID values is:
- Error-prone
- Time-consuming
- Difficult to coordinate in multi-user environments

### AUTO_INCREMENT Solution
AUTO_INCREMENT automatically generates sequential, unique values starting from 1.

### Syntax
```sql
CREATE TABLE table_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    other_columns...
);
```

### Example: Cats with AUTO_INCREMENT
```sql
CREATE TABLE unique_cats3 (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);
```

### Using AUTO_INCREMENT

**Insert without specifying ID:**
```sql
INSERT INTO unique_cats3 (name, age) VALUES ('Boingo', 1);
INSERT INTO unique_cats3 (name, age) VALUES ('Muffin', 2);
INSERT INTO unique_cats3 (name, age) VALUES ('Shadow', 3);
```

**Verify automatic ID assignment:**
```sql
SELECT * FROM unique_cats3;
```

**Result:**
```
+--------+--------+-----+
| cat_id | name   | age |
+--------+--------+-----+
|      1 | Boingo |   1 |
|      2 | Muffin |   2 |
|      3 | Shadow |   3 |
+--------+--------+-----+
```

### AUTO_INCREMENT Behavior
- Starts at 1 by default
- Increments by 1 for each new row
- Never reuses values (even if rows are deleted)
- Works automatically - no manual intervention needed

### Alternative Syntax
```sql
CREATE TABLE unique_cats4 (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) DEFAULT 'unnamed',
    age INT DEFAULT 99
);
```

### Important Notes
1. AUTO_INCREMENT columns must be indexed (PRIMARY KEY satisfies this)
2. Only one AUTO_INCREMENT column per table
3. Still enforces uniqueness - manual duplicates will fail
4. Gaps in sequence are normal and expected

---

## 10. Comprehensive Exercise: Employee Table

### Exercise Requirements
Create an `employees` table with these specifications:

**Columns:**
- `id`: Integer, Primary Key, Auto-increment
- `last_name`: Text (100 chars), Required
- `first_name`: Text (100 chars), Required  
- `middle_name`: Text (100 chars), Optional (can be NULL)
- `age`: Integer, Required
- `current_status`: Text (100 chars), Required, Default value 'employed'

### Exercise Solution

**Step 1: Create the table**
```sql
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    age INT NOT NULL,
    current_status VARCHAR(100) NOT NULL DEFAULT 'employed'
);
```

**Step 2: Verify table structure**
```sql
DESCRIBE employees;
```

**Expected Output:**
```
+----------------+--------------+------+-----+----------+----------------+
| Field          | Type         | Null | Key | Default  | Extra          |
+----------------+--------------+------+-----+----------+----------------+
| id             | int          | NO   | PRI | NULL     | auto_increment |
| last_name      | varchar(100) | NO   |     | NULL     |                |
| first_name     | varchar(100) | NO   |     | NULL     |                |
| middle_name    | varchar(100) | YES  |     | NULL     |                |
| age            | int          | NO   |     | NULL     |                |
| current_status | varchar(100) | NO   |     | employed |                |
+----------------+--------------+------+-----+----------+----------------+
```

**Step 3: Test with a complete insert**
```sql
INSERT INTO employees (first_name, last_name, age) 
VALUES ('Thomas', 'Chickenman', 87);
```

**Step 4: Verify the insert**
```sql
SELECT * FROM employees;
```

**Expected Result:**
```
+----+-----------+------------+-------------+-----+----------------+
| id | last_name | first_name | middle_name | age | current_status |
+----+-----------+------------+-------------+-----+----------------+
|  1 | Chickenman| Thomas     | NULL        |  87 | employed       |
+----+-----------+------------+-------------+-----+----------------+
```

**Step 5: Test constraint violations**
```sql
-- This should fail (missing required age)
INSERT INTO employees (first_name, last_name) 
VALUES ('Jane', 'Doe');
```

**Error Expected:**
```
ERROR: Field 'age' doesn't have a default value
```

**Step 6: Test multiple inserts**
```sql
INSERT INTO employees (first_name, last_name, age, current_status) 
VALUES 
    ('Alice', 'Johnson', 30, 'contractor'),
    ('Bob', 'Smith', 45, 'on leave'),
    ('Carol', 'Brown', 28, 'employed');
```

**Step 7: Verify auto-increment worked**
```sql
SELECT * FROM employees;
```

### Key Learning Points from Exercise
1. **AUTO_INCREMENT** automatically handles unique ID generation
2. **NOT NULL** prevents incomplete data entry
3. **DEFAULT** values provide sensible fallbacks
4. **NULL-allowed columns** (middle_name) provide flexibility
5. **PRIMARY KEY** ensures each employee has unique identifier

---

## Summary and Best Practices

### Core Concepts Mastered
1. **INSERT Statement**: Adding data to tables
2. **Column Constraints**: NOT NULL, DEFAULT, PRIMARY KEY
3. **AUTO_INCREMENT**: Automatic unique ID generation
4. **Data Validation**: MySQL enforces rules to maintain data integrity
5. **Quote Handling**: Proper text value insertion

### Best Practices
1. **Always use PRIMARY KEY** on tables for unique identification
2. **Combine AUTO_INCREMENT with PRIMARY KEY** for automatic ID management
3. **Use NOT NULL** for required fields
4. **Set reasonable DEFAULT values** for optional fields
5. **Use single quotes** for text values
6. **Test your constraints** to ensure they work as expected
7. **Use meaningful column names** and consistent naming conventions

### Common Patterns
```sql
-- Standard table creation pattern
CREATE TABLE table_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    required_field VARCHAR(100) NOT NULL,
    optional_field VARCHAR(100),
    status_field VARCHAR(50) NOT NULL DEFAULT 'active',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Standard insert pattern
INSERT INTO table_name (required_field, optional_field) 
VALUES ('value1', 'value2');

-- Multiple insert pattern
INSERT INTO table_name (field1, field2) 
VALUES 
    ('value1', 'value2'),
    ('value3', 'value4'),
    ('value5', 'value6');
```

This foundation prepares you for more advanced topics like complex SELECT queries, JOINs, and data manipulation operations.
