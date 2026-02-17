# Quiz: The WHERE Clause

## Section 1: Equality Operators and Primary Keys

**1. What does PostgreSQL use to combine index scan and table access operations?**

A) Index Scan
B) Index Unique Scan
C) Index Range Scan
D) Table Access by Rowid

**2. In a multi-column index, how is sorting determined?**

A) Only by the first column
B) By each column according to its position in the index definition
C) By the last column only
D) Randomly

**3. If an index is created on (subsidiary_id, employee_id), which query will NOT use the index effectively?**

A) WHERE subsidiary_id = 20 AND employee_id = 100
B) WHERE employee_id = 100
C) WHERE subsidiary_id = 20
D) WHERE subsidiary_id = 20 AND employee_id > 50

**4. When is a FULL TABLE SCAN more efficient than an index scan?**

A) Always
B) When retrieving a small number of rows
C) When retrieving a large part of the table
D) Never

## Section 2: Functions and Expressions

**5. What happens when you use UPPER(last_name) in a WHERE clause but have an index on last_name?**

A) The index is used efficiently
B) The index is not used
C) The query automatically converts to use the index
D) An error occurs

**6. What type of function can be indexed in PostgreSQL?**

A) Any function
B) Deterministic functions marked as STABLE
C) Only deterministic functions marked as IMMUTABLE
D) No user-defined functions can be indexed

## Section 3: Parameterized Queries

**7. What are two good reasons to use bind parameters?**

A) Security and performance
B) Readability and portability
C) Compatibility and simplicity
D) Speed and memory efficiency

**8. Why might bind parameters prevent optimal index usage?**

A) The optimizer cannot see the actual values
B) Bind parameters are slower than literal values
C) The database ignores bind parameters entirely
D) They cause syntax errors

**9. What is the main drawback of using bind parameters for table or column names?**

A) They are slower
B) They cannot change the structure of an SQL statement
C) They cause memory leaks
D) They are not supported

## Section 4: Searching for Ranges

**10. What is the golden rule of indexing?**

A) Always index all columns
B) Keep the scanned index range as small as possible
C) Use single-column indexes only
D) Avoid range scans

**11. In a multi-column index, which type of condition should come first?**

A) Range conditions
B) Equality conditions
C) It doesn't matter
D) Functions

**12. For LIKE expressions, which part can be used as an access predicate?**

A) Everything after the first wildcard
B) The part before the first wildcard
C) The entire LIKE expression
D) None of it

## Section 5: Index Merge

**13. What is generally better: one index per column or a single multi-column index?**

A) One index per column
B) A single multi-column index
C) They are equivalent
D) Depends on the database

**14. What is the greatest weakness of bitmap indexes?**

A) Slow reads
B) Poor insert, update, and delete scalability
C) Large storage requirements
D) Cannot handle multiple columns

## Section 6: Partial Indexes

**15. What is a partial index?**

An index that includes only rows satisfying a WHERE clause

**16. What are the benefits of partial indexes? (Select all that apply)**

A) Reduced disk space
B) Faster writes
C) Fewer rows indexed
D) Better query performance on specific subsets

## Section 7: Obfuscated Conditions

**17. Which of the following prevents index usage? (Select all that apply)**

A) Using TO_CHAR(date_column, 'YYYY-MM-DD') = '2020-01-01'
B) Comparing a numeric string column to a number
C) Using UPPER(column) in WHERE without a function-based index
D) Using column = 'value'

**18. What is the "smart logic" anti-pattern?**

A) Using dynamic SQL for complex queries
B) Using OR conditions with bind variables that become ineffective
C) Creating too many indexes
D) Using function-based indexes

**19. What is the recommended solution for dynamic WHERE clauses?**

A) Use static SQL with OR conditions
B) Use dynamic SQL with bind parameters
C) Create multiple indexes
D) Use full table scans

**20. Why should you avoid mathematical operations on columns in WHERE clauses?**

A) They cause syntax errors
B) They prevent index usage because the column is transformed
C) They are slower than direct comparisons
D) They are not supported by PostgreSQL

---

# Answer Key

1. **A** - Index Scan
2. **B** - By each column according to its position in the index definition
3. **B** - WHERE employee_id = 100 (uses second column without first)
4. **C** - When retrieving a large part of the table
5. **B** - The index is not used
6. **C** - Only deterministic functions marked as IMMUTABLE
7. **A** - Security and performance
8. **A** - The optimizer cannot see the actual values
9. **B** - They cannot change the structure of an SQL statement
10. **B** - Keep the scanned index range as small as possible
11. **B** - Equality conditions
12. **B** - The part before the first wildcard
13. **B** - A single multi-column index
14. **B** - Poor insert, update, and delete scalability
15. An index that includes only rows satisfying a WHERE clause
16. **A, C, D** - Reduced disk space, fewer rows indexed, better query performance on specific subsets
17. **A, B, C** - TO_CHAR, numeric comparison, UPPER without function-based index
18. **B** - Using OR conditions with bind variables that become ineffective
19. **B** - Use dynamic SQL with bind parameters
20. **B** - They prevent index usage because the column is transformed
