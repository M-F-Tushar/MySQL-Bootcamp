# Complete MySQL String Functions Guide

## Table of Contents
1. [Introduction to String Functions](#introduction)
2. [Setting Up the Books Database](#database-setup)
3. [String Functions Overview](#functions-overview)
4. [Detailed Function Explanations](#detailed-functions)
5. [Combining String Functions](#combining-functions)
6. [SQL Formatting Guidelines](#formatting)
7. [Exercises and Solutions](#exercises)

---

## 1. Introduction to String Functions {#introduction}

### What are String Functions?
String functions are built-in MySQL operations that allow you to manipulate text (VARCHAR) columns. They help you:
- Transform text case (uppercase/lowercase)
- Find text length
- Reverse text
- Replace parts of text
- Extract portions of strings
- Combine multiple strings

### Key Concepts:
- **Non-destructive operations**: String functions don't modify the original data in tables
- **Used in SELECT statements**: Results are displayed but original data remains unchanged
- **Can be combined**: Multiple string functions can work together
- **Case-sensitive**: Many functions respect character casing

---

## 2. Setting Up the Books Database {#database-setup}

### Database Structure
```sql
CREATE TABLE books 
(
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT,
    PRIMARY KEY(book_id)
);
```

### Sample Data
```sql
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman', 2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
-- ... more books
```

### Loading Data Methods:

#### Method 1: GUI Tools (SQL Workbench, DbGate)
1. Open the SQL file in your preferred GUI
2. Ensure you're using the correct database
3. Click "Run" to execute

#### Method 2: Command Line
```bash
# Navigate to file location
mysql -u root -p
USE bookshop;
source book_data.sql;
```

---

## 3. String Functions Overview {#functions-overview}

### Core Functions Covered:
1. **CONCAT** - Combine strings
2. **CONCAT_WS** - Combine with separator
3. **SUBSTRING/SUBSTR** - Extract portions
4. **REPLACE** - Replace text portions
5. **REVERSE** - Reverse string order
6. **CHAR_LENGTH** - Count characters
7. **UPPER/LOWER** - Change case
8. **Additional Functions** - INSERT, LEFT, RIGHT, REPEAT, TRIM

---

## 4. Detailed Function Explanations {#detailed-functions}

### 4.1 CONCAT Function

#### Purpose
Combines multiple strings into one string.

#### Syntax
```sql
CONCAT(string1, string2, string3, ...)
```

#### Basic Examples
```sql
-- Simple concatenation
SELECT CONCAT('H', 'E', 'L');
-- Result: HEL

-- Concatenating columns
SELECT CONCAT(author_fname, author_lname) FROM books;
-- Result: JhumpaLahiri, NeilGaiman, etc.

-- Adding spaces
SELECT CONCAT(author_fname, ' ', author_lname) FROM books;
-- Result: Jhumpa Lahiri, Neil Gaiman, etc.

-- With alias
SELECT CONCAT(author_fname, ' ', author_lname) AS author_name FROM books;
```

#### Practical Use Cases
- Creating full names from separate fields
- Building display strings
- Combining multiple data points into readable format

### 4.2 CONCAT_WS Function

#### Purpose
Concatenates strings WITH a Separator - the separator is inserted between each value.

#### Syntax
```sql
CONCAT_WS(separator, string1, string2, string3, ...)
```

#### Examples
```sql
-- Basic example
SELECT CONCAT_WS('!', 'hi', 'bye', 'lol');
-- Result: hi!bye!lol

-- Creating URL-friendly strings
SELECT CONCAT_WS('-', title, author_fname, author_lname) FROM books;
-- Result: The-Namesake-Jhumpa-Lahiri
```

#### Key Differences from CONCAT
- First parameter is always the separator
- Separator appears BETWEEN values, not before or after
- More efficient for consistent separators

### 4.3 SUBSTRING Function

#### Purpose
Extracts a portion of a string based on position and length.

#### Syntax
```sql
SUBSTRING(string, start_position, length)
SUBSTRING(string, start_position)  -- Goes to end
SUBSTR(string, start_position, length)  -- Shorter alias
```

#### Position Rules
- **Positive numbers**: Count from beginning (1-based indexing)
- **Negative numbers**: Count from end
- **No length specified**: Goes to end of string

#### Examples
```sql
-- Basic substring
SELECT SUBSTRING('Hello World', 1, 4);
-- Result: Hell

SELECT SUBSTRING('Hello World', 7);
-- Result: World (from position 7 to end)

SELECT SUBSTRING('Hello World', -3);
-- Result: rld (last 3 characters)

-- With table data
SELECT SUBSTRING(title, 1, 15) FROM books;
-- Result: First 15 characters of each title

-- Getting initials
SELECT SUBSTRING(author_lname, 1, 1) AS initial FROM books;
-- Result: L, G, G, L, E, etc.
```

### 4.4 REPLACE Function

#### Purpose
Replaces all occurrences of a substring with another substring.

#### Syntax
```sql
REPLACE(original_string, search_string, replacement_string)
```

#### Key Points
- **Case-sensitive**: 'Hello' ≠ 'hello'
- **Replaces ALL occurrences**: Not just the first match
- **Non-destructive**: Original data unchanged

#### Examples
```sql
-- Basic replacement
SELECT REPLACE('Hello World', 'Hell', '%$#@');
-- Result: %$#@o World

-- Adding connectors
SELECT REPLACE('cheese bread coffee milk', ' ', ' and ');
-- Result: cheese and bread and coffee and milk

-- With table data
SELECT REPLACE(title, ' ', '->') FROM books;
-- Result: The->Namesake, Norse->Mythology, etc.
```

### 4.5 REVERSE Function

#### Purpose
Reverses the order of characters in a string.

#### Syntax
```sql
REVERSE(string)
```

#### Examples
```sql
-- Basic reversal
SELECT REVERSE('Hello World');
-- Result: dlroW olleH

-- With table data
SELECT REVERSE(author_fname) FROM books;
-- Result: apmuhJ, lieN, evaD, etc.

-- Creating palindromes
SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;
-- Result: JhumpaapmuhJ, NeilieN, etc.
```

### 4.6 CHAR_LENGTH Function

#### Purpose
Returns the number of characters in a string.

#### Syntax
```sql
CHAR_LENGTH(string)
```

#### CHAR_LENGTH vs LENGTH
- **CHAR_LENGTH**: Counts characters
- **LENGTH**: Counts bytes (important for multi-byte characters)

#### Examples
```sql
-- Basic character count
SELECT CHAR_LENGTH('Hello World');
-- Result: 11

-- With table data
SELECT title, CHAR_LENGTH(title) AS character_count FROM books;
-- Result: Shows each title with its character count

-- Multi-byte example
SELECT CHAR_LENGTH('海豚');  -- Chinese for dolphin
-- Result: 2 characters

SELECT LENGTH('海豚');
-- Result: 6 bytes
```

### 4.7 UPPER and LOWER Functions

#### Purpose
Changes the case of all characters in a string.

#### Syntax
```sql
UPPER(string)    -- or UCASE(string)
LOWER(string)    -- or LCASE(string)
```

#### Examples
```sql
-- Basic case conversion
SELECT UPPER('Hello World');
-- Result: HELLO WORLD

SELECT LOWER('Hello World');
-- Result: hello world

-- With table data
SELECT UPPER(title) FROM books;
-- Result: THE NAMESAKE, NORSE MYTHOLOGY, etc.

-- Combined example
SELECT CONCAT('I love ', UPPER(title), '!!!') FROM books;
-- Result: I love THE NAMESAKE!!!, I love NORSE MYTHOLOGY!!!, etc.
```

### 4.8 Additional String Functions

#### INSERT Function
Inserts a substring at a specified position, optionally replacing characters.

```sql
INSERT(original_string, position, length_to_replace, new_string)

-- Examples
SELECT INSERT('Hello Bobby', 6, 0, ' There');
-- Result: Hello There Bobby

SELECT INSERT('Hello Bobby', 7, 5, 'There');
-- Result: Hello There
```

#### LEFT and RIGHT Functions
Extract characters from the left or right side of a string.

```sql
LEFT(string, number_of_characters)
RIGHT(string, number_of_characters)

-- Examples
SELECT LEFT('Hello World', 5);    -- Result: Hello
SELECT RIGHT('Hello World', 5);   -- Result: World
SELECT LEFT(author_lname, 1) FROM books;  -- First letter of last name
```

#### REPEAT Function
Repeats a string a specified number of times.

```sql
REPEAT(string, count)

-- Examples
SELECT REPEAT('Ha', 4);  -- Result: HaHaHaHa
```

#### TRIM Function
Removes leading and/or trailing spaces (or specified characters).

```sql
TRIM(string)                              -- Removes spaces
TRIM(LEADING character FROM string)       -- Removes leading characters
TRIM(TRAILING character FROM string)      -- Removes trailing characters
TRIM(BOTH character FROM string)          -- Removes both

-- Examples
SELECT TRIM('  Boston  ');               -- Result: Boston
SELECT TRIM(LEADING '.' FROM '...text...'); -- Result: text...
SELECT TRIM(BOTH '.' FROM '...text...');    -- Result: text
```

---

## 5. Combining String Functions {#combining-functions}

### Nested Functions
String functions can be nested (functions within functions). The innermost function executes first.

#### Example 1: Short Titles with Ellipsis
```sql
SELECT 
    CONCAT(
        SUBSTRING(title, 1, 10), 
        '...'
    ) AS short_title 
FROM books;
-- Result: The Namesa..., Norse Myth..., American G...
```

#### Example 2: Author Initials
```sql
SELECT 
    CONCAT(
        SUBSTRING(author_fname, 1, 1), 
        '.', 
        SUBSTRING(author_lname, 1, 1), 
        '.'
    ) AS author_initials 
FROM books;
-- Result: J.L., N.G., N.G., J.L., D.E., etc.
```

#### Example 3: Complex Author Display
```sql
SELECT 
    CONCAT(
        LEFT(title, 10),
        '...'
    ) AS short_title,
    CONCAT(
        author_lname, 
        ',', 
        author_fname
    ) AS author,
    CONCAT(
        stock_quantity, 
        ' in stock'
    ) AS quantity
FROM books;
```

### Formatting for Readability
```sql
-- Well-formatted nested functions
SELECT 
    CONCAT(
        SUBSTRING(title, 1, 10),
        '...'
    ) AS short_title
FROM books;

-- Same query, harder to read
SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS short_title FROM books;
```

---

## 6. SQL Formatting Guidelines {#formatting}

### Why Format SQL Code?
- **Readability**: Easier to understand complex queries
- **Maintenance**: Simpler to modify and debug
- **Consistency**: Professional coding standards
- **Collaboration**: Better for team environments

### Formatting Tools

#### MySQL Workbench
- Use the "beautify" button (paintbrush icon)
- Automatically formats selected SQL

#### DbGate
- Right-click → "Format Code"
- Generally produces cleaner formatting

#### VS Code
- Install SQL formatter extension
- Use Command + Shift + P → "Format Document"

#### Online Tools
- Multiple web-based SQL formatters available
- Copy/paste your code for instant formatting

### Best Practices
```sql
-- Good formatting
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS full_name,
    UPPER(title) AS title_caps,
    CHAR_LENGTH(title) AS title_length
FROM books
WHERE released_year > 2000;

-- Poor formatting
select concat(author_fname,' ',author_lname) as full_name,upper(title) as title_caps,char_length(title) as title_length from books where released_year>2000;
```

---

## 7. Exercises and Solutions {#exercises}

### Exercise 1: Basic Operations
**Task**: Reverse and uppercase the sentence "Why does my cat look at me with such hatred?"

**Solution**:
```sql
SELECT UPPER(REVERSE("Why does my cat look at me with such hatred?"));
-- Result: ?DERTAH HCUS HTIW EM TA KOOL TAC YM SEOD YHW
```

### Exercise 2: Understanding Nested Functions
**Task**: Predict the output of this query:
```sql
SELECT REPLACE(CONCAT('I', ' ', 'like', ' ', 'cats'), ' ', '-');
```

**Solution Process**:
1. `CONCAT('I', ' ', 'like', ' ', 'cats')` → "I like cats"
2. `REPLACE("I like cats", ' ', '-')` → "I-like-cats"

### Exercise 3: Replace Spaces with Arrows
**Task**: Replace all spaces in book titles with "->"

**Solution**:
```sql
SELECT REPLACE(title, ' ', '->') AS title FROM books;
```

### Exercise 4: Forward and Backward Names
**Task**: Show author last names forward and backward

**Solution**:
```sql
SELECT 
    author_lname AS forwards,
    REVERSE(author_lname) AS backwards 
FROM books;
```

### Exercise 5: Full Names in Caps
**Task**: Display full author names in uppercase

**Solution**:
```sql
SELECT 
    UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM books;
```

### Exercise 6: Book Blurbs
**Task**: Create sentences like "The Namesake was released in 2003"

**Solution**:
```sql
SELECT 
    CONCAT(title, ' was released in ', released_year) AS blurb 
FROM books;
```

### Exercise 7: Character Counts
**Task**: Show book titles and their character counts

**Solution**:
```sql
SELECT 
    title,
    CHAR_LENGTH(title) AS 'character count'
FROM books;
```

### Exercise 8: Complex Multi-Column Output
**Task**: Create three columns:
- short_title: First 10 characters + "..."
- author: "LastName,FirstName" format  
- quantity: "X in stock" format

**Solution**:
```sql
SELECT 
    CONCAT(SUBSTRING(title, 1, 10), '...') AS short_title,
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM books;
```

---

## Key Takeaways

### Essential Points to Remember:

1. **Non-Destructive Nature**: String functions display modified results without changing original data
2. **Function Nesting**: Inner functions execute first, results pass to outer functions
3. **Case Sensitivity**: Many functions respect character casing
4. **Consistent Syntax**: All functions use parentheses and comma-separated arguments
5. **Aliasing**: Use `AS` to create readable column names for function results

### Common Patterns:
- Use `CONCAT` for combining known strings
- Use `CONCAT_WS` when you need consistent separators
- Use `SUBSTRING` for extracting specific portions
- Use `REPLACE` for text substitution
- Combine functions for complex string manipulation

### Best Practices:
- Format complex queries for readability
- Use meaningful aliases for calculated columns
- Test functions with simple examples before applying to complex data
- Consider performance implications for large datasets
- Document complex nested functions with comments

This comprehensive guide covers all the essential MySQL string functions with practical examples and exercises to reinforce learning.
