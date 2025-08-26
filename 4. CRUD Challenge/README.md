# Complete SQL CRUD Operations Tutorial

## Table of Contents
1. [Introduction](#introduction)
2. [Database and Table Setup](#database-and-table-setup)
3. [CREATE Operations](#create-operations)
4. [READ Operations](#read-operations)
5. [UPDATE Operations](#update-operations)
6. [DELETE Operations](#delete-operations)
7. [Complete Exercise Walkthrough](#complete-exercise-walkthrough)

---

## Introduction

This tutorial focuses on practicing the fundamental CRUD operations (Create, Read, Update, Delete) in SQL through a practical exercise involving a shirt inventory management system. Instead of working with simple examples, we'll create a more realistic scenario where we manage a closet inventory.

### Learning Objectives
- Master all basic CRUD operations
- Practice database and table creation
- Learn proper SQL syntax and best practices
- Understand how to structure and manipulate data effectively

### Scenario
We're creating a database system to manage a shirt inventory for spring cleaning. This involves tracking different types of shirts with their properties like color, size, and when they were last worn.

---

## Database and Table Setup

### 1. Creating the Database

```sql
CREATE DATABASE shirts_db;
USE shirts_db;
```

**Explanation:**
- `CREATE DATABASE shirts_db;` - Creates a new database named "shirts_db"
- `USE shirts_db;` - Switches to using this database for all subsequent operations
- Always remember to USE the database after creating it, otherwise your tables might be created in the wrong database

### 2. Creating the Table Structure

```sql
CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50),
    color VARCHAR(50),
    shirt_size VARCHAR(5),
    last_worn INT
);
```

**Column Explanations:**
- **shirt_id**: Primary key that auto-increments for each new record
- **article**: Type of shirt (t-shirt, polo shirt, tank top, etc.)
- **color**: Color of the shirt (white, green, black, etc.)
- **shirt_size**: Size designation (S, M, L, XS, etc.)
- **last_worn**: Number of days ago the shirt was last worn (integer)

**Design Decisions:**
- `VARCHAR(50)` for article and color provides enough space for descriptive text
- `VARCHAR(5)` for shirt_size accommodates sizes like "XS", "XXL"
- `INT` for last_worn since we're tracking days as whole numbers
- `AUTO_INCREMENT` ensures unique IDs without manual assignment

### 3. Verifying Table Structure

```sql
DESC shirts;
```

This command shows the table structure and confirms all columns were created correctly.

---

## CREATE Operations

### 1. Bulk Data Insertion

```sql
INSERT INTO shirts (article, color, shirt_size, last_worn)  
VALUES 
    ('t-shirt', 'white', 'S', 10),
    ('t-shirt', 'green', 'S', 200),
    ('polo shirt', 'black', 'M', 10),
    ('tank top', 'blue', 'S', 50),
    ('t-shirt', 'pink', 'S', 0),
    ('polo shirt', 'red', 'M', 5),
    ('tank top', 'white', 'S', 200),
    ('tank top', 'blue', 'M', 15);
```

**Key Points:**
- Multiple rows inserted in a single statement for efficiency
- Column order must match the order specified in the INSERT statement
- shirt_id is not specified because it auto-increments
- Values must be in the correct data type (strings in quotes, numbers without)

### 2. Single Record Insertion

```sql
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('polo shirt', 'purple', 'M', 50);
```

**Exercise Explanation:**
- Adding a new purple polo shirt, size M, last worn 50 days ago
- This demonstrates adding individual records after initial bulk insertion
- Always specify column names to avoid errors if table structure changes

---

## READ Operations

### 1. Basic Selection with Specific Columns

```sql
SELECT article, color FROM shirts;
```

**Purpose:** 
- Retrieves only the article and color columns from all shirts
- More efficient than SELECT * when you don't need all data
- Useful for generating reports or summaries

### 2. Conditional Selection with WHERE Clause

```sql
SELECT * FROM shirts WHERE shirt_size = 'M';
```

**Explanation:**
- Filters results to show only medium-sized shirts
- The WHERE clause is case-sensitive for string comparisons
- Returns all columns for matching records

### 3. Selective Columns with Conditions

```sql
SELECT article, color, shirt_size, last_worn FROM shirts WHERE shirt_size = 'M';
```

**Key Concept:**
- Combines column selection with row filtering
- Excludes shirt_id from results while filtering for medium shirts
- Demonstrates how to be specific about both rows and columns needed

---

## UPDATE Operations

### 1. Updating Multiple Records

```sql
UPDATE shirts 
SET shirt_size = 'L'
WHERE article = 'polo shirt';
```

**Detailed Explanation:**
- Changes ALL polo shirts to size L
- The WHERE clause is crucial - without it, ALL shirts would become size L
- Always test your WHERE clause with SELECT first to verify which records will be affected

**Best Practice Example:**
```sql
-- First, check what will be updated
SELECT * FROM shirts WHERE article = 'polo shirt';
-- Then perform the update
UPDATE shirts SET shirt_size = 'L' WHERE article = 'polo shirt';
```

### 2. Updating Based on Specific Values

```sql
UPDATE shirts 
SET last_worn = 0
WHERE last_worn = 15;
```

**Scenario:**
- Finding the shirt last worn exactly 15 days ago
- Setting it to 0 (meaning we wore it today)
- Demonstrates updating based on current values

### 3. Multiple Column Updates

```sql
UPDATE shirts 
SET color = 'off white', shirt_size = 'XS'
WHERE color = 'white';
```

**Advanced Concept:**
- Updates two columns simultaneously in a single statement
- More efficient than separate UPDATE statements
- Comma-separated SET clauses for multiple column updates
- All white shirts become "off white" and size XS

---

## DELETE Operations

### 1. Conditional Deletion

```sql
SELECT * FROM shirts WHERE last_worn = 200;
DELETE FROM shirts WHERE last_worn = 200;
```

**Process:**
1. **First SELECT** - Always verify which records will be deleted
2. **Then DELETE** - Remove the identified records
3. This removes shirts that haven't been worn in exactly 200 days

### 2. Deletion by Category

```sql
SELECT * FROM shirts WHERE article = 'tank top';
DELETE FROM shirts WHERE article = 'tank top';
```

**Use Case:**
- Removing all tank tops regardless of other attributes
- Useful when eliminating entire categories of items
- The SELECT first approach prevents accidental deletions

### 3. Complete Table Deletion

```sql
DELETE FROM shirts;
```

**Warning:**
- Removes ALL records from the table
- Table structure remains intact
- This is different from DROP TABLE (which we'll cover next)
- Use with extreme caution in production environments

### 4. Table Destruction

```sql
DROP TABLE shirts;
```

**Critical Understanding:**
- Completely removes the table and all its data
- Cannot be undone without backups
- Different from DELETE (which removes data but keeps structure)
- After DROP TABLE, you cannot SELECT, INSERT, UPDATE, or DELETE

**Verification:**
```sql
SHOW TABLES;  -- shirts table will not appear
DESC shirts;  -- This will give an error - table doesn't exist
```

---

## Complete Exercise Walkthrough

### Phase 1: Setup and Initial Data
1. Create database and table structure
2. Insert initial 8 shirt records
3. Add one additional shirt (purple polo)
4. Verify data with basic SELECT statements

### Phase 2: Reading and Filtering
1. **Select specific columns:** Get only article and color for all shirts
2. **Filter by size:** Show all medium shirts with most columns (excluding ID)
3. **Practice WHERE clauses:** Understanding conditional selection

### Phase 3: Modifying Data
1. **Bulk updates:** Change all polo shirts to size L
2. **Targeted updates:** Update specific shirt (last_worn = 15 to 0)
3. **Multi-column updates:** Change white shirts to off-white and XS

### Phase 4: Data Cleanup
1. **Conditional deletion:** Remove old shirts (last_worn = 200)
2. **Category deletion:** Remove all tank tops
3. **Complete cleanup:** Delete all remaining records
4. **Table removal:** Drop the entire table

### Expected Results at Each Step

**After Initial Setup:**
- Database: shirts_db exists and is in use
- Table: shirts with 9 total records
- Data includes various shirt types, colors, and sizes

**After Reading Operations:**
- Successfully retrieve specific data subsets
- Understand column selection and row filtering
- Verify data integrity

**After Updates:**
- 3 polo shirts changed to size L
- 1 shirt's last_worn changed from 15 to 0
- 2 white shirts changed to off-white XS

**After Deletions:**
- 2 shirts removed (200-day old ones)
- All tank tops removed
- Eventually: empty table, then no table

---

## Key Learning Points

### Best Practices
1. **Always SELECT before UPDATE/DELETE** - Verify your WHERE clause
2. **Use specific column names** - Avoid SELECT * in production
3. **Test with small datasets first** - Understand your queries before scaling
4. **Back up important data** - Especially before DELETE/DROP operations

### Common Mistakes to Avoid
1. **Forgetting WHERE clauses** - Can update/delete all records accidentally
2. **Wrong column names** - SQL is case-sensitive and exact-match required
3. **Mixing up DELETE vs DROP** - Very different operations with different results
4. **Not using the correct database** - Always USE the right database first

### SQL Command Summary

| Operation | Command Example | Purpose |
|-----------|-----------------|---------|
| Create DB | `CREATE DATABASE name;` | Make new database |
| Use DB | `USE database_name;` | Switch to database |
| Create Table | `CREATE TABLE name (...);` | Define table structure |
| Insert Data | `INSERT INTO table VALUES (...);` | Add new records |
| Select Data | `SELECT columns FROM table WHERE condition;` | Retrieve records |
| Update Data | `UPDATE table SET column=value WHERE condition;` | Modify existing records |
| Delete Records | `DELETE FROM table WHERE condition;` | Remove specific records |
| Drop Table | `DROP TABLE name;` | Remove entire table |

This comprehensive tutorial provides hands-on experience with all fundamental SQL operations while building practical skills for real-world database management.
