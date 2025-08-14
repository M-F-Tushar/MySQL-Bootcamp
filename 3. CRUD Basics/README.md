# Complete MySQL CRUD Operations Guide

## Table of Contents
1. [Introduction to CRUD](#introduction-to-crud)
2. [Setting Up the Dataset](#setting-up-the-dataset)
3. [READ Operations (SELECT)](#read-operations-select)
4. [UPDATE Operations](#update-operations)
5. [DELETE Operations](#delete-operations)
6. [Comprehensive Exercises](#comprehensive-exercises)

---

## 1. Introduction to CRUD

### What is CRUD?
**CRUD** is an acronym that stands for the four fundamental operations we perform on data:

- **C**reate - Adding new data (INSERT)
- **R**ead - Retrieving existing data (SELECT)
- **U**pdate - Modifying existing data (UPDATE)
- **D**elete - Removing data (DELETE)

### Why CRUD Matters
These four operations are the foundation of any database interaction. Whether you're building a website, mobile app, or any system that stores data, you'll need to perform these operations. CRUD is not specific to SQL - it's a universal concept used across all programming languages and database systems.

### What We Already Know
- **CREATE**: We've learned `INSERT INTO` to add new rows
- **READ**: We've used basic `SELECT *` to view data

### What We'll Learn
- Advanced **READ** operations with `SELECT`
- **UPDATE** operations to modify existing data
- **DELETE** operations to remove data

---

## 2. Setting Up the Dataset

### Creating Our Practice Table
To ensure we all get the same results, we'll start with a fresh `cats` table:

```sql
-- Drop existing cats table if it exists
DROP TABLE cats;

-- Create new cats table
CREATE TABLE cats (
    cat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT
);

-- Insert sample data
INSERT INTO cats (name, breed, age)
VALUES 
    ('Ringo', 'Tabby', 4),
    ('Cindy', 'Maine Coon', 10),
    ('Dumbledore', 'Maine Coon', 11),
    ('Egg', 'Persian', 4),
    ('Misty', 'Tabby', 13),
    ('George Michael', 'Ragdoll', 9),
    ('Jackson', 'Sphynx', 7);
```

### Verify the Data
```sql
SELECT * FROM cats;
```

**Expected Output:**
| cat_id | name           | breed      | age |
|--------|----------------|------------|-----|
| 1      | Ringo          | Tabby      | 4   |
| 2      | Cindy          | Maine Coon | 10  |
| 3      | Dumbledore     | Maine Coon | 11  |
| 4      | Egg            | Persian    | 4   |
| 5      | Misty          | Tabby      | 13  |
| 6      | George Michael | Ragdoll    | 9   |
| 7      | Jackson        | Sphynx     | 7   |

---

## 3. READ Operations (SELECT)

### 3.1 Basic SELECT Syntax

#### Select All Columns
```sql
SELECT * FROM cats;
```
The `*` (asterisk) means "all columns". This retrieves every column for every row.

#### Select Specific Columns
```sql
-- Select only names
SELECT name FROM cats;

-- Select only ages
SELECT age FROM cats;

-- Select multiple specific columns
SELECT name, age FROM cats;
SELECT name, breed FROM cats;
```

**Key Points:**
- Column order in your SELECT determines output order
- You don't need to select all columns - choose only what you need
- Column names must match exactly (case-insensitive in MySQL)

### 3.2 The WHERE Clause

The `WHERE` clause allows us to filter rows based on conditions.

#### Basic WHERE with Numbers
```sql
-- Find all cats that are exactly 4 years old
SELECT * FROM cats WHERE age = 4;
```

**Output:**
| cat_id | name  | breed   | age |
|--------|-------|---------|-----|
| 1      | Ringo | Tabby   | 4   |
| 4      | Egg   | Persian | 4   |

#### Basic WHERE with Text
```sql
-- Find the cat named Egg
SELECT * FROM cats WHERE name = 'Egg';
```

**Important Notes:**
- Text values must be enclosed in quotes (single or double)
- MySQL is case-insensitive by default for text comparisons
- `'Egg'`, `'egg'`, and `'EGG'` all match the same value

#### Combining WHERE with Column Selection
```sql
-- Get only names of 4-year-old cats
SELECT name FROM cats WHERE age = 4;

-- Get name and breed of cats named 'Egg'
SELECT name, breed FROM cats WHERE name = 'Egg';
```

**Important Concept:** You don't need to SELECT a column to use it in WHERE. The WHERE filtering happens first, then SELECT determines what columns to show.

### 3.3 Rapid Fire SELECT Exercises

#### Exercise 1: Select all cat_ids
**Challenge:** Write a query to select only the cat_id column for all cats.

**Solution:**
```sql
SELECT cat_id FROM cats;
```

**Expected Output:**
```
cat_id
------
1
2
3
4
5
6
7
```

#### Exercise 2: Select names and breeds
**Challenge:** Write a query to select name and breed columns for all cats.

**Solution:**
```sql
SELECT name, breed FROM cats;
```

**Expected Output:**
| name           | breed      |
|----------------|------------|
| Ringo          | Tabby      |
| Cindy          | Maine Coon |
| Dumbledore     | Maine Coon |
| Egg            | Persian    |
| Misty          | Tabby      |
| George Michael | Ragdoll    |
| Jackson        | Sphynx     |

#### Exercise 3: Find Tabby cats
**Challenge:** Select name and age for all cats with breed 'Tabby'.

**Solution:**
```sql
SELECT name, age FROM cats WHERE breed = 'Tabby';
```

**Expected Output:**
| name  | age |
|-------|-----|
| Ringo | 4   |
| Misty | 13  |

#### Exercise 4: Cats where ID equals age
**Challenge:** Find cats where cat_id equals age, show only cat_id and age.

**Solution:**
```sql
SELECT cat_id, age FROM cats WHERE cat_id = age;
```

**Expected Output:**
| cat_id | age |
|--------|-----|
| 4      | 4   |
| 7      | 7   |

**Advanced Concept:** You can compare two columns in a WHERE clause. MySQL evaluates this condition for each row.

### 3.4 Aliases

Aliases allow you to rename columns in your output using the `AS` keyword.

#### Basic Alias Usage
```sql
-- Rename cat_id to just id
SELECT cat_id AS id, name FROM cats;
```

**Output:**
| id | name           |
|----|----------------|
| 1  | Ringo          |
| 2  | Cindy          |
| 3  | Dumbledore     |
| ... | ...           |

#### Creative Aliases
```sql
-- Give columns more descriptive names
SELECT name AS kitty_name, breed AS cat_breed FROM cats;
```

**Key Points:**
- Aliases only affect the output display
- The actual column names in the database remain unchanged
- Useful for making reports more readable
- Essential for complex queries with calculated fields (covered later)

---

## 4. UPDATE Operations

### 4.1 Basic UPDATE Syntax

The `UPDATE` statement modifies existing data in a table.

**Basic Structure:**
```sql
UPDATE table_name
SET column_name = new_value
WHERE condition;
```

### 4.2 Single Column Updates

#### Update One Specific Row
```sql
-- Change Misty's age from 13 to 14 (birthday!)
UPDATE cats 
SET age = 14 
WHERE name = 'Misty';
```

**Verification:**
```sql
SELECT * FROM cats WHERE name = 'Misty';
```

### 4.3 Multiple Column Updates

You can update several columns in one statement:

```sql
-- Update multiple columns at once
UPDATE employees 
SET last_name = 'Smith', current_status = 'Active'
WHERE employee_id = 1;
```

### 4.4 Mass Updates (Be Careful!)

#### Update ALL Rows
```sql
-- THIS UPDATES EVERY ROW! Use with caution
UPDATE cats SET age = 5;
```

**Warning:** Without a WHERE clause, UPDATE affects every row in the table!

### 4.5 Important Safety Rule

**Always SELECT before you UPDATE!**

```sql
-- Step 1: Test your WHERE clause first
SELECT * FROM cats WHERE name = 'Misty';

-- Step 2: If the selection looks correct, then update
UPDATE cats SET age = 14 WHERE name = 'Misty';
```

This prevents accidental mass updates that could destroy your data.

### 4.6 UPDATE Exercise

#### Exercise Tasks:
1. Change Jackson's name to 'Jack'
2. Change Ringo's breed to 'British Shorthair'
3. Update both Maine Coon cats to age 12

#### Solution 1: Update Jackson's name
```sql
-- First, verify which rows we'll update
SELECT * FROM cats WHERE name = 'Jackson';

-- Then perform the update
UPDATE cats SET name = 'Jack' WHERE name = 'Jackson';
```

#### Solution 2: Update Ringo's breed
```sql
-- Verify the target row
SELECT * FROM cats WHERE name = 'Ringo';

-- Update the breed
UPDATE cats SET breed = 'British Shorthair' WHERE name = 'Ringo';
```

#### Solution 3: Update Maine Coon ages
```sql
-- Verify which cats will be affected
SELECT * FROM cats WHERE breed = 'Maine Coon';

-- Update both cats at once
UPDATE cats SET age = 12 WHERE breed = 'Maine Coon';
```

**Final verification:**
```sql
SELECT * FROM cats;
```

---

## 5. DELETE Operations

### 5.1 Basic DELETE Syntax

The `DELETE` statement removes rows from a table.

**Basic Structure:**
```sql
DELETE FROM table_name
WHERE condition;
```

### 5.2 Delete Specific Rows

#### Delete One Row
```sql
-- Delete the cat named Egg
DELETE FROM cats WHERE name = 'Egg';
```

#### Delete Multiple Rows
```sql
-- Delete all 4-year-old cats
DELETE FROM cats WHERE age = 4;
```

### 5.3 Delete ALL Rows (Dangerous!)

```sql
-- THIS DELETES EVERYTHING! The table remains but is empty
DELETE FROM cats;
```

**Important Distinction:**
- `DELETE FROM table` - Removes all data, keeps table structure
- `DROP TABLE table` - Removes the entire table and its structure

### 5.4 Safety First with DELETE

Just like with UPDATE, always SELECT first:

```sql
-- Step 1: See what you're about to delete
SELECT * FROM cats WHERE age = 4;

-- Step 2: If that's what you want to delete, then:
DELETE FROM cats WHERE age = 4;
```

### 5.5 DELETE Exercise

#### Exercise Tasks:
1. Delete all 4-year-old cats
2. Delete cats where age equals cat_id
3. Delete all remaining cats (but keep the table)

#### Solution 1: Delete 4-year-old cats
```sql
-- Verify what we're deleting
SELECT * FROM cats WHERE age = 4;

-- Delete them
DELETE FROM cats WHERE age = 4;
```

#### Solution 2: Delete cats where age equals cat_id
```sql
-- Check which cats match this condition
SELECT * FROM cats WHERE age = cat_id;

-- Delete them
DELETE FROM cats WHERE age = cat_id;
```

#### Solution 3: Delete all cats
```sql
-- This empties the table completely
DELETE FROM cats;

-- Verify it's empty
SELECT * FROM cats;  -- Should return "Empty set"
```

---

## 6. Comprehensive Summary

### CRUD Operations Quick Reference

| Operation | SQL Command | Purpose | Example |
|-----------|-------------|---------|---------|
| **Create** | `INSERT INTO` | Add new data | `INSERT INTO cats (name, age) VALUES ('Fluffy', 3);` |
| **Read** | `SELECT` | Retrieve data | `SELECT name FROM cats WHERE age > 5;` |
| **Update** | `UPDATE ... SET` | Modify existing data | `UPDATE cats SET age = 6 WHERE name = 'Fluffy';` |
| **Delete** | `DELETE FROM` | Remove data | `DELETE FROM cats WHERE name = 'Fluffy';` |

### Best Practices

1. **Always use WHERE clauses** unless you intentionally want to affect all rows
2. **Test with SELECT first** before running UPDATE or DELETE
3. **Use meaningful aliases** to make output more readable
4. **Be specific with column selection** - don't always use SELECT *
5. **Back up important data** before performing mass operations

### Common Mistakes to Avoid

1. **Forgetting WHERE clause** - This affects ALL rows!
2. **Forgetting FROM in DELETE** - Write `DELETE FROM table`, not `DELETE table`
3. **Case sensitivity confusion** - MySQL is generally case-insensitive for data, but be consistent
4. **Not verifying results** - Always check your work with SELECT statements

### Next Steps

With these four CRUD operations mastered, you now have the fundamental tools to:
- Build dynamic web applications
- Manage user data
- Create data-driven systems
- Handle real-world database scenarios

Practice these operations regularly, and always remember the golden rule: **SELECT before you UPDATE or DELETE!**
