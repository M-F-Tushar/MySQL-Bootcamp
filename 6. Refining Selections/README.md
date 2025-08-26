# MySQL Refining Selections - Complete Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Setup - Adding New Books](#setup)
3. [DISTINCT - Eliminating Duplicates](#distinct)
4. [ORDER BY - Sorting Results](#order-by)
5. [LIMIT - Controlling Result Count](#limit)
6. [LIKE - Pattern Matching](#like)
7. [Escaping Wildcards](#escaping-wildcards)
8. [Comprehensive Exercises](#exercises)
9. [Exercise Solutions](#solutions)

---

## Introduction

This section focuses on advanced MySQL features for refining and manipulating query results. We'll learn how to:
- Remove duplicate results
- Sort data in various ways
- Limit the number of results returned
- Perform pattern-based searching
- Combine multiple techniques for powerful queries

**Key Concepts Covered:**
- `DISTINCT` - Get unique results only
- `ORDER BY` - Sort results ascending/descending
- `LIMIT` - Control number of results returned
- `LIKE` - Search with wildcards and patterns
- Combining multiple clauses for complex queries

---

## Setup - Adding New Books {#setup}

Before exploring advanced features, let's add some test data to our books table:

```sql
INSERT INTO books
(title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
       ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
       ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
```

**Important Notes:**
- Notice the `%` symbol in "10% Happier" - we'll use this for wildcard examples
- We have two authors with the same last name (Dan Harris vs Freida Harris)
- These additions give us better data for demonstrating various techniques

---

## DISTINCT - Eliminating Duplicates {#distinct}

### Basic Concept
`DISTINCT` eliminates duplicate rows from query results, showing only unique values.

**Syntax:** `SELECT DISTINCT column_name FROM table_name;`

### Example 1: Distinct Last Names

```sql
-- Without DISTINCT (shows duplicates)
SELECT author_lname FROM books;
```
**Result:** Shows 19 rows with duplicates like multiple "Gaiman", "Eggers", etc.

```sql
-- With DISTINCT (eliminates duplicates)
SELECT DISTINCT author_lname FROM books;
```
**Result:** Shows only 11 unique last names - one instance of each.

### Example 2: Distinct Release Years

```sql
-- All release years (with duplicates)
SELECT released_year FROM books;
-- Result: 19 rows with repeated years like 2001, 2003

-- Unique release years only
SELECT DISTINCT released_year FROM books;
-- Result: 16 rows - only unique years
```

### Working with Multiple Columns

#### Method 1: Using CONCAT
```sql
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) 
FROM books;
```
**Result:** 12 distinct full names (Dan Harris and Freida Harris are both included)

#### Method 2: Multiple Columns (Recommended)
```sql
SELECT DISTINCT author_fname, author_lname FROM books;
```
**Result:** Same as above but cleaner syntax - finds distinct combinations of first AND last name.

### Important Notes About DISTINCT with Multiple Columns

```sql
-- This finds distinct combinations of ALL THREE columns
SELECT DISTINCT author_fname, author_lname, released_year FROM books;
```
**Result:** Nearly all rows returned because most combinations are unique.

**Key Rule:** DISTINCT applies to the entire row combination, not individual columns.

---

## ORDER BY - Sorting Results {#order-by}

### Basic Syntax and Default Behavior

```sql
SELECT book_id, title, author_lname FROM books;
```
**Default Order:** Results appear in insertion order (order they were added to database).

```sql
SELECT book_id, title, author_lname FROM books
ORDER BY author_lname;
```
**Result:** Sorted alphabetically by last name (A to Z by default).

### Ascending vs Descending

```sql
-- Ascending (default) - A to Z
SELECT author_fname, author_lname FROM books
ORDER BY author_fname;

-- Descending - Z to A  
SELECT author_fname, author_lname FROM books
ORDER BY author_fname DESC;
```

### Sorting by Numbers

```sql
-- Sort by pages (ascending: smallest to largest)
SELECT title, pages FROM books
ORDER BY pages;

-- Sort by pages (descending: largest to smallest)
SELECT title, pages FROM books
ORDER BY pages DESC;
```

### Using Column Numbers (Shorthand)

```sql
SELECT title, author_fname, author_lname, pages FROM books
ORDER BY 2;  -- Orders by 2nd column (author_fname)
```

**Columns are numbered:** title=1, author_fname=2, author_lname=3, pages=4

**Note:** While this works, it's less readable than using actual column names.

### Sorting by Multiple Columns

```sql
SELECT author_lname, author_fname, title FROM books
ORDER BY author_lname, author_fname;
```

**How it works:**
1. First, sort all rows by `author_lname` (primary sort)
2. Within each group of same last names, sort by `author_fname` (secondary sort)

**Example Result:**
- All "Carver" books grouped together, then sorted by first name within that group
- All "Eggers" books grouped together, then sorted by first name within that group

### Mixed Sorting Directions

```sql
SELECT author_lname, released_year, title FROM books
ORDER BY author_lname ASC, released_year DESC;
```
**Result:** Last names A-Z, but within each author's books, newest years first.

### Sorting by Calculated Columns

```sql
SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books
ORDER BY author;
```
**Result:** Can sort by aliased columns or calculated values.

---

## LIMIT - Controlling Result Count {#limit}

### Basic Usage

```sql
-- Get first 5 results
SELECT title, released_year FROM books
LIMIT 5;
```
**Result:** First 5 books in whatever order they exist in the table.

### Combining LIMIT with ORDER BY

```sql
-- Get 5 oldest books
SELECT title, released_year FROM books
ORDER BY released_year
LIMIT 5;

-- Get 5 newest books  
SELECT title, released_year FROM books
ORDER BY released_year DESC
LIMIT 5;
```

### Advanced LIMIT Syntax - Offset

```sql
-- Basic: LIMIT count
SELECT title FROM books LIMIT 5;

-- Advanced: LIMIT offset, count
SELECT title FROM books LIMIT 0,5;  -- Same as above
```

**Syntax:** `LIMIT offset, count`
- `offset`: Which row to start from (0-based)
- `count`: How many rows to return

### Practical Offset Examples

```sql
-- Skip first 5, get next 3
SELECT title, released_year FROM books
ORDER BY released_year DESC 
LIMIT 5,3;
```

**Breakdown:**
- Start at position 5 (6th row, since 0-based)
- Return 3 rows
- Useful for pagination in web applications

### Edge Cases

```sql
-- Request more rows than exist
SELECT title FROM books LIMIT 100;
-- Result: Returns all available rows, no error

-- Start beyond available rows
SELECT title FROM books LIMIT 25,5;
-- Result: Returns empty set, no error
```

---

## LIKE - Pattern Matching {#like}

### Why Use LIKE?
Exact matching with `=` is limiting:

```sql
-- This only finds exact matches
SELECT * FROM books WHERE author_fname = 'David';
```

What if you want to find names containing "Da" or starting with "Dav"?

### Wildcard Characters

#### Percent Sign (%) - Zero or More Characters

```sql
-- Find first names containing 'da' anywhere
SELECT title, author_fname, author_lname FROM books
WHERE author_fname LIKE '%da%';
```
**Matches:** David, Dan, Dave (the 'da' can be at start, middle, or end)

```sql
-- Find names starting with 'da'
SELECT title, author_fname FROM books
WHERE author_fname LIKE 'da%';
```
**Matches:** Dan, Dave, David (must start with 'da')

```sql
-- Find names ending with 'n'
SELECT title, author_fname FROM books  
WHERE author_fname LIKE '%n';
```
**Matches:** Dan, John (must end with 'n')

#### Underscore (_) - Exactly One Character

```sql
-- Find 4-character first names
SELECT * FROM books
WHERE author_fname LIKE '____';  -- 4 underscores
```
**Matches:** Neil, Dave, John (exactly 4 characters)

```sql
-- Find 5-character first names
SELECT * FROM books
WHERE author_fname LIKE '_____';  -- 5 underscores
```
**Matches:** Patti, David (exactly 5 characters)

### Practical LIKE Examples

#### Finding Books with Colons in Title
```sql
SELECT * FROM books
WHERE title LIKE '%:%';
```
**Matches:** Any title containing a colon anywhere

#### Pattern Matching with Underscores
```sql
-- Find names where 2nd character is 'a'
SELECT * FROM books
WHERE author_fname LIKE '_a%';
```
**Matches:** Dan (D-a-n), etc.

### Key Differences: % vs _

```sql
-- % matches ANY number of characters (0, 1, 100, etc.)
WHERE author_fname LIKE '%a%'    -- Matches: Dan, Dave, Michael, Jhumpa

-- _ matches EXACTLY one character  
WHERE author_fname LIKE '_a_'    -- Matches: Dan (exactly 3 chars with 'a' in middle)
```

---

## Escaping Wildcards {#escaping-wildcards}

### The Problem
What if you need to search for literal `%` or `_` characters?

```sql
-- This WON'T work - % is treated as wildcard
SELECT * FROM books
WHERE title LIKE '%';  -- Matches ALL titles
```

### The Solution: Backslash Escape

#### Searching for Literal Percent Sign
```sql
-- Find books with % in the title
SELECT * FROM books
WHERE title LIKE '%\%%';
```
**Breakdown:**
- First `%`: wildcard (any characters before)
- `\%`: literal percent sign
- Last `%`: wildcard (any characters after)

**Result:** Finds "10% Happier"

#### Searching for Literal Underscore
```sql
-- Find books with _ in the title
SELECT * FROM books  
WHERE title LIKE '%\_%';
```
**Result:** Finds "fake_book"

### Escape Syntax Rules
- `\%` = literal percent sign
- `\_ `= literal underscore  
- `%` = wildcard (zero or more characters)
- `_` = wildcard (exactly one character)

---

## Comprehensive Exercises {#exercises}

### Exercise 1: Story Collections
**Task:** Find all books with "stories" in the title.

**Expected Output:**
```
+-----------------------------------------------------+
| title                                               |
+-----------------------------------------------------+
| What We Talk About When We Talk About Love: Stories |
| Where I'm Calling From: Selected Stories            |
| Oblivion: Stories                                   |
+-----------------------------------------------------+
```

### Exercise 2: Longest Book
**Task:** Find the book with the most pages. Show title and page count.

**Expected Output:**
```
+-------------------------------------------+-------+
| title                                     | pages |
+-------------------------------------------+-------+
| The Amazing Adventures of Kavalier & Clay |   634 |
+-------------------------------------------+-------+
```

### Exercise 3: Recent Books Summary
**Task:** Create a summary for the 3 most recent books. Format: "Title - Year"

**Expected Output:**
```
+-----------------------------+
| summary                     |
+-----------------------------+
| Lincoln In The Bardo - 2017 |
| Norse Mythology - 2016      |
| 10% Happier - 2014          |
+-----------------------------+
```

### Exercise 4: Authors with Spaces in Last Name
**Task:** Find books where author's last name contains a space. Don't hardcode "Foster Wallace"!

**Expected Output:**
```
+----------------------+----------------+
| title                | author_lname   |
+----------------------+----------------+
| Oblivion: Stories    | Foster Wallace |
| Consider the Lobster | Foster Wallace |
+----------------------+----------------+
```

### Exercise 5: Lowest Stock Books
**Task:** Find 3 books with lowest stock quantities.

**Expected Output:**
```
+-----------------------------------------------------+---------------+----------------+
| title                                               | released_year | stock_quantity |
+-----------------------------------------------------+---------------+----------------+
| American Gods                                       |          2001 |             12 |
| Where I'm Calling From: Selected Stories            |          1989 |             12 |
| What We Talk About When We Talk About Love: Stories |          1981 |             23 |
+-----------------------------------------------------+---------------+----------------+
```

### Exercise 6: Sorted by Author and Title
**Task:** Show title and author_lname, sorted first by last name, then by title.

**Expected Output:**
```
+-----------------------------------------------------+----------------+
| title                                               | author_lname   |
+-----------------------------------------------------+----------------+
| What We Talk About When We Talk About Love: Stories | Carver         |
| Where I'm Calling From: Selected Stories            | Carver         |
| The Amazing Adventures of Kavalier & Clay           | Chabon         |
| White Noise                                         | DeLillo        |
| A Heartbreaking Work of Staggering Genius          | Eggers         |
| A Hologram for the King: A Novel                   | Eggers         |
| The Circle                                          | Eggers         |
| Consider the Lobster                                | Foster Wallace |
| Oblivion: Stories                                   | Foster Wallace |
| American Gods                                       | Gaiman         |
| Coraline                                           | Gaiman         |
| Norse Mythology                                     | Gaiman         |
| 10% Happier                                        | Harris         |
| fake_book                                          | Harris         |
| Interpreter of Maladies                            | Lahiri         |
| The Namesake                                       | Lahiri         |
| Lincoln In The Bardo                               | Saunders       |
| Just Kids                                          | Smith          |
| Cannery Row                                        | Steinbeck      |
+-----------------------------------------------------+----------------+
```

### Exercise 7: Enthusiastic Author List
**Task:** Create "yell" column saying "MY FAVORITE AUTHOR IS [FULL NAME]!" for each book, sorted by last name.

**Expected Output:**
```
+---------------------------------------------+
| yell                                        |
+---------------------------------------------+
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS MICHAEL CHABON!       |
| MY FAVORITE AUTHOR IS DON DELILLO!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS FREIDA HARRIS!        |
| MY FAVORITE AUTHOR IS DAN HARRIS!           |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS GEORGE SAUNDERS!      |
| MY FAVORITE AUTHOR IS PATTI SMITH!          |
| MY FAVORITE AUTHOR IS JOHN STEINBECK!       |
+---------------------------------------------+
```

---

## Exercise Solutions {#solutions}

### Solution 1: Story Collections
```sql
SELECT title FROM books 
WHERE title LIKE '%stories%';
```

**Explanation:**
- Uses `%stories%` to find "stories" anywhere in the title
- Case-sensitive matching finds "Stories" in the titles

### Solution 2: Longest Book
```sql
SELECT title, pages FROM books 
ORDER BY pages DESC 
LIMIT 1;
```

**Explanation:**
1. `ORDER BY pages DESC` sorts by pages, largest first
2. `LIMIT 1` takes only the first (largest) result

### Solution 3: Recent Books Summary
```sql
SELECT CONCAT(title, ' - ', released_year) AS summary 
FROM books 
ORDER BY released_year DESC 
LIMIT 3;
```

**Explanation:**
1. `CONCAT()` combines title, " - ", and year
2. `AS summary` creates the required column name
3. `ORDER BY released_year DESC` gets newest first
4. `LIMIT 3` takes top 3 results

### Solution 4: Authors with Spaces
```sql
SELECT title, author_lname FROM books 
WHERE author_lname LIKE '% %';
```

**Explanation:**
- `'% %'` finds any last name containing a space anywhere
- The pattern allows characters before and after the space

### Solution 5: Lowest Stock Books
```sql
SELECT title, released_year, stock_quantity 
FROM books 
ORDER BY stock_quantity 
LIMIT 3;
```

**Explanation:**
1. `ORDER BY stock_quantity` sorts ascending (lowest first)
2. `LIMIT 3` gets the 3 lowest values

### Solution 6: Sorted by Author and Title
```sql
SELECT title, author_lname 
FROM books 
ORDER BY author_lname, title;
```

**Explanation:**
1. `ORDER BY author_lname` primary sort by last name
2. `, title` secondary sort by title within each author group
3. Both default to ascending (A-Z)

### Solution 7: Enthusiastic Author List

**Method 1: Uppercase individual parts**
```sql
SELECT 
    CONCAT(
        'MY FAVORITE AUTHOR IS ',
        UPPER(author_fname),
        ' ',
        UPPER(author_lname),
        '!'
    ) AS yell
FROM books 
ORDER BY author_lname;
```

**Method 2: Uppercase the whole thing (recommended)**
```sql
SELECT 
    UPPER(
        CONCAT(
            'my favorite author is ',
            author_fname,
            ' ',
            author_lname,
            '!'
        )
    ) AS yell
FROM books 
ORDER BY author_lname;
```

**Explanation:**
- Method 2 is cleaner - concatenate everything, then uppercase the result
- `UPPER()` converts entire string to uppercase
- `ORDER BY author_lname` sorts alphabetically by last name

---

## Key Takeaways

### Clause Order Matters
```sql
SELECT column_name
FROM table_name  
WHERE condition
ORDER BY column_name
LIMIT number;
```

### Combining Multiple Techniques
```sql
-- Complex query using multiple clauses
SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) AS full_name
FROM books
WHERE author_lname LIKE '%a%'
ORDER BY author_lname DESC
LIMIT 5;
```

### Best Practices
1. **Use meaningful column names** over numbers in ORDER BY
2. **Combine ORDER BY with LIMIT** for "top N" queries  
3. **Use DISTINCT carefully** - understand it applies to entire row combinations
4. **Escape wildcards** when searching for literal % or _ characters
5. **Test queries incrementally** - build complex queries step by step

This completes the comprehensive guide to refining MySQL selections!
