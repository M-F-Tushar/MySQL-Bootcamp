# MySQL Section 1: Databases and Tables - Complete Guide

## Section Overview

This section marks a crucial turning point in the MySQL course, moving from basic setup to real database operations. You'll learn to create, manage, and work with databases and tables - the fundamental building blocks of any SQL system.

**Key Topics Covered:**
- Database creation, deletion, and selection
- Understanding table structure and data types
- Creating and managing tables
- MySQL comments for code documentation

---

## 1. Understanding Databases

### What is a Database?

A **database** is a self-contained silo of information within a MySQL server. Think of databases as separate containers that organize related data while keeping different applications' data completely isolated.

**Key Concepts:**
- Multiple databases can exist on one MySQL server
- Each database is independent - no data contamination between them
- Databases contain tables, which hold the actual data

**Real-World Example:**
```
MySQL Server
├── dog_walker_database
│   ├── dogs table
│   ├── walkers table
│   └── users table
├── soap_shop_database
│   ├── products table
│   ├── customers table
│   └── orders table
└── practice_database
    └── test_table
```

Even if both databases have "users" and "payments" tables, they remain completely separate.

---

## 2. Database Operations

### 2.1 Viewing Existing Databases

**Command:** `SHOW DATABASES;`

```sql
SHOW DATABASES;
```

**What you'll see:**
- `information_schema` - MySQL system database
- `mysql` - MySQL system database  
- `performance_schema` - MySQL system database
- `sys` - MySQL system database

*Note: Don't worry about these system databases - you won't need to modify them.*

**Access Methods:**
1. **Command Line:** Use MySQL shell after logging in
2. **MySQL Workbench:** Run the command in the query editor
3. **DbGate:** Visual interface shows databases in sidebar

### 2.2 Creating Databases

**Syntax:** `CREATE DATABASE <database_name>;`

```sql
CREATE DATABASE pet_shop;
CREATE DATABASE slime_store;
CREATE DATABASE chicken_coop;
```

**Naming Best Practices:**
- Use meaningful, descriptive names
- Avoid spaces (causes problems)
- Use underscores for separation: `dog_walker_app`
- CamelCase is acceptable: `DogWalkerApp`
- SQL keywords should be capitalized for readability

**Example Creation Process:**
```sql
-- Creating multiple databases
CREATE DATABASE pet_shop;
CREATE DATABASE tea_shop;
CREATE DATABASE chicken_coop;

-- Verify creation
SHOW DATABASES;
```

### 2.3 Deleting Databases

**Syntax:** `DROP DATABASE <database_name>;`

```sql
DROP DATABASE slime_store;
```

**⚠️ WARNING:** This permanently deletes the entire database and ALL its contents. Use with extreme caution!

**Example:**
```sql
-- Delete a database
DROP DATABASE pet_shop;

-- Verify deletion
SHOW DATABASES;
```

### 2.4 Using/Selecting Databases

**Syntax:** `USE <database_name>;`

```sql
USE chicken_coop;
```

**Why This Matters:**
- You must "use" a database before creating tables or inserting data
- Think of it as "opening" or "entering" the database
- Only one database is active at a time per connection

**Verification:**
```sql
-- Check which database you're currently using
SELECT DATABASE();
```

**GUI Alternative:**
- **MySQL Workbench:** Double-click database name
- **DbGate:** Click on database name to select it

**Complete Example:**
```sql
-- Create and use a database
CREATE DATABASE tea_shop;
USE tea_shop;
SELECT DATABASE(); -- Returns: tea_shop

-- Switch to different database
USE chicken_coop;
SELECT DATABASE(); -- Returns: chicken_coop
```

---

## 3. Understanding Tables

### What are Tables?

Tables are the **heart of SQL** - they're structured containers that hold your actual data within databases.

**Key Concepts:**
- Tables define the **structure/schema** of your data
- They consist of **columns** (fields) and **rows** (records)
- Each column has a specific **data type**
- Tables start empty and you add data following the defined structure

**Visual Example - Cats Table:**
```
+--------+---------------+-----+
| name   | breed         | age |
+--------+---------------+-----+
| Blue   | Scottish Fold | 1   |
| Rocket | Persian       | 3   |
| Max    | Tabby         | 2   |
+--------+---------------+-----+
```

**Terminology:**
- **Columns:** The headers (name, breed, age)
- **Rows:** Individual data entries (each cat)
- **Fields:** Individual data points (Blue, Scottish Fold, 1)

### Real-World Database Examples

**Wikipedia Database Tables:**
- `user` - User accounts and information
- `page` - Wikipedia articles
- `revision` - Article edit history  
- `image` - Uploaded files
- `category` - Article categorization

**Social Media App Tables:**
- `users` - User profiles and authentication
- `posts` - User-generated content
- `comments` - Post responses
- `likes` - User interactions
- `friends` - User relationships

---

## 4. Data Types - The Foundation

### Why Data Types Matter

Data types ensure **consistency** and enable **operations** on your data.

**Problem Without Data Types:**
```
Age Column Values:
- 1 (number)
- "ten" (text)
- "I am young cat" (text)

Calculation: age * 7 (cat to human years)
- 1 * 7 = 7 ✓
- "ten" * 7 = ERROR ✗
- "I am young cat" * 7 = ERROR ✗
```

### MySQL Data Type Categories

**Numeric Types:**
- `TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, `BIGINT`
- `DECIMAL`, `NUMERIC`, `FLOAT`, `DOUBLE`
- `BIT`

**String/Text Types:**
- `CHAR`, `VARCHAR`, `BINARY`, `VARBINARY`
- `BLOB`, `TINYBLOB`, `MEDIUMBLOB`, `LONGBLOB`
- `TEXT`, `TINYTEXT`, `MEDIUMTEXT`, `LONGTEXT`
- `ENUM`

**Date/Time Types:**
- `DATE`, `DATETIME`, `TIMESTAMP`, `TIME`, `YEAR`

### Focus Data Types for Beginners

#### INT (Integer)
- **Purpose:** Whole numbers only (no decimals)
- **Range:** -2,147,483,648 to 2,147,483,647
- **Examples:** `12`, `-9999`, `0`, `42`

```sql
age INT
```

#### VARCHAR (Variable Character)
- **Purpose:** Text of variable length
- **Format:** `VARCHAR(max_length)`
- **Examples:** 
  - `VARCHAR(100)` - up to 100 characters
  - `VARCHAR(50)` - up to 50 characters

```sql
name VARCHAR(100),
breed VARCHAR(50)
```

**VARCHAR Examples:**
```sql
-- These are all valid VARCHAR values:
'Colt'           -- 4 characters
'SuperLongUsername123' -- 20 characters  
'A'              -- 1 character
'The quick brown fox jumps' -- 26 characters
```

---

## 5. Data Types Challenge - Tweets Table

### Challenge Requirements

Model a **tweets table** with these specifications:

1. **Username:** Maximum 15 characters
2. **Content:** Maximum 140 characters  
3. **Favorites:** Number of people who liked the tweet

### Solution

```sql
CREATE TABLE tweets (
    username VARCHAR(15),
    content VARCHAR(140),
    favorites INT
);
```

### Sample Data

| username      | content           | favorites |
|---------------|-------------------|-----------|
| coolguy       | My first tweet    | 1         |
| guitar_queen  | I love music 😊   | 10        |
| lonely_heart  | still looking 4 love | 0     |

**Analysis:**
- **VARCHAR(15):** Perfect for Twitter usernames (limited length)
- **VARCHAR(140):** Accommodates tweet character limit
- **INT:** Favorites count is always a whole number

---

## 6. Creating Tables

### Basic Syntax

```sql
CREATE TABLE table_name (
    column_name data_type,
    column_name data_type,
    column_name data_type
);
```

### Practical Examples

#### Example 1: Cats Table
```sql
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);
```

#### Example 2: Dogs Table  
```sql
CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);
);
```

### Step-by-Step Creation Process

**Step 1: Ensure you're in the right database**
```sql
USE pet_shop;
SELECT DATABASE(); -- Verify
```

**Step 2: Create the table**
```sql
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);
```

**Step 3: Verify creation**
```sql
SHOW TABLES;
```

### Formatting Best Practices

**Good Formatting:**
```sql
CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);
```

**Also Valid (but harder to read):**
```sql
CREATE TABLE dogs (name VARCHAR(50), breed VARCHAR(50), age INT);
```

**Key Points:**
- MySQL ignores whitespace and line breaks
- Use commas to separate columns
- Terminate with semicolon
- Formatting improves readability

---

## 7. Inspecting Tables

### Command Line Methods

#### Method 1: Show All Tables
```sql
SHOW TABLES;
```
*Shows all tables in current database*

#### Method 2: Show Table Structure  
```sql
SHOW COLUMNS FROM table_name;
```

Example:
```sql
SHOW COLUMNS FROM cats;
```

Output:
```
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| name  | varchar(50) | YES  |     | NULL    |       |
| age   | int(11)     | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
```

#### Method 3: Describe Table (Shortcut)
```sql
DESC table_name;
-- or
DESCRIBE table_name;
```

Example:
```sql
DESC cats;
DESCRIBE dogs;
```

### GUI Methods

**MySQL Workbench:**
- Tables appear in left sidebar under database
- Click table name to see structure
- No commands needed

**DbGate:**
- Database tree shows tables
- Click table to view structure
- Clean, readable format

### Complete Inspection Example

```sql
-- 1. Check what database you're in
SELECT DATABASE();

-- 2. See all tables
SHOW TABLES;

-- 3. Inspect specific table structure
DESC cats;
DESC dogs;

-- 4. Detailed column information
SHOW COLUMNS FROM dogs;
```

---

## 8. Dropping Tables

### Syntax and Usage

```sql
DROP TABLE table_name;
```

**⚠️ CRITICAL WARNING:** 
- This **permanently deletes** the table and ALL data
- No confirmation prompt
- No undo option
- Always double-check before dropping

### Examples

```sql
-- Drop a single table
DROP TABLE cats;

-- Verify it's gone
SHOW TABLES;
```

### GUI Methods

**DbGate:**
1. Right-click table name
2. Select "Drop table"
3. Review generated SQL
4. Execute

**MySQL Workbench:**
1. Right-click table
2. Choose "Drop Table"
3. Click "Drop Now" or review SQL first

### Best Practices

**Before Dropping:**
1. Check table contents (covered in later sections)
2. Backup important data
3. Verify you're in correct database
4. Double-check table name spelling

```sql
-- Safe dropping process
USE correct_database;
SELECT DATABASE(); -- Confirm
SHOW TABLES;       -- List tables
DESC table_name;   -- Check structure
-- Only then:
DROP TABLE table_name;
```

---

## 9. Tables Basics Activity

### Exercise Instructions

Create a **pastries table** with the following requirements:

1. **Table name:** `pastries`
2. **Columns:**
   - `name` - Name of the pastry (text)
   - `quantity` - Number in stock (integer)
3. **Tasks:**
   - Create the table
   - Inspect it to verify correctness
   - Delete the table when done

### Step-by-Step Solution

**Step 1: Create the table**
```sql
CREATE TABLE pastries (
    name VARCHAR(50),
    quantity INT
);
```

**Step 2: Verify creation**
```sql
-- Method 1: List all tables
SHOW TABLES;

-- Method 2: Describe table structure
DESC pastries;
```

Expected output:
```
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| name     | varchar(50) | YES  |     | NULL    |       |
| quantity | int(11)     | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
```

**Step 3: Clean up**
```sql
DROP TABLE pastries;

-- Verify deletion
SHOW TABLES; -- Should not show pastries
```

### Alternative Solutions

**Different VARCHAR length:**
```sql
CREATE TABLE pastries (
    name VARCHAR(100),  -- Longer pastry names
    quantity INT
);
```

**One-line format:**
```sql
CREATE TABLE pastries (name VARCHAR(50), quantity INT);
```

Both are valid - choose based on readability preference.

---

## 10. MySQL Comments

### Purpose and Usage

Comments allow you to:
- Add explanatory notes to your SQL code
- Temporarily disable code without deleting it  
- Document your queries for future reference
- Share code with explanations

### Syntax

```sql
-- This is a comment (note the space after dashes)
SHOW TABLES;
```

**Critical Rule:** Must have a **space** after the two dashes!

### Practical Examples

#### Example 1: Code Documentation
```sql
-- List all tables in current database
SHOW TABLES;

-- Get detailed structure of cats table  
DESC cats;

-- Switch to different database
USE pet_shop;
```

#### Example 2: Temporarily Disable Code
```sql
-- Don't run this right now
-- CREATE TABLE test (id INT);

-- This will run
SHOW TABLES;
```

#### Example 3: Multi-line Comments
```sql
-- Creating a comprehensive pets database
-- This includes cats, dogs, and other animals
-- Last updated: 2024

CREATE TABLE cats (
    name VARCHAR(50),    -- Pet's name
    breed VARCHAR(50),   -- Cat breed
    age INT             -- Age in years
);
```

### GUI Features

**MySQL Workbench:**
- Highlight code block
- Press `Cmd+/` (Mac) or `Ctrl+/` (PC)
- Toggles comments on/off for entire selection

**DbGate:**
- Same keyboard shortcuts available
- Visual indication of commented code

### Complete Example

```sql
-- =====================================
-- Pet Shop Database Setup
-- =====================================

-- Step 1: Create and use database
CREATE DATABASE pet_shop;
USE pet_shop;

-- Step 2: Create tables
CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);

-- Future table (not ready yet)
-- CREATE TABLE toys (
--     toy_name VARCHAR(100),
--     price DECIMAL(5,2)
-- );

-- Step 3: Verify setup
SHOW TABLES;
DESC cats;
```

---

## Summary and Key Takeaways

### Essential Commands Mastered

**Database Operations:**
```sql
SHOW DATABASES;
CREATE DATABASE database_name;
DROP DATABASE database_name;
USE database_name;
SELECT DATABASE();
```

**Table Operations:**
```sql
SHOW TABLES;
CREATE TABLE table_name (column data_type, ...);
DROP TABLE table_name;
DESC table_name;
SHOW COLUMNS FROM table_name;
```

**Comments:**
```sql
-- Single line comment
```

### Critical Concepts

1. **Database Isolation:** Each database is independent
2. **Data Types:** Define what kind of information each column stores
3. **Table Structure:** Columns define the schema, rows contain data
4. **Destructive Operations:** DROP commands are permanent
5. **Active Database:** Must USE a database before creating tables

### Best Practices Established

- **Naming:** Use descriptive, meaningful names
- **Formatting:** Capitalize SQL keywords, use consistent indentation
- **Safety:** Always verify database/table before DROP operations  
- **Documentation:** Use comments for complex operations
- **Verification:** Always check your work with DESC and SHOW commands

### What's Next

With databases and tables mastered, you're ready to:
- Insert data into tables
- Query and retrieve data  
- Update and delete records
- Work with more complex data types
- Understand table relationships

This foundation is crucial - every advanced MySQL concept builds on these fundamentals!
