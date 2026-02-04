# Equality Operator

## Primary keys

The database automatically creates an index for the primary key.

![Where query using pk](image.png)

The PostgreSQL operation Index Scan combines the INDEX [UNIQUE/RANGE] SCAN and TABLE ACCES BY INDEX ROWID operations from the Oracle Database. It is not visible from the execution plan if the index access might potentially return more than one row. After accessing the index, the database must do one more step to fetch the queried data (FIRST_NAME, LAST_NAME) from the table storage: the TABLE ACCESS BY INDEX ROWID operation.

## Multi-column Indexes

A multi-column index is just a B-tree index like any other that keeps the indexed data in a sorted list. The database considers each column according to its position in the index definition to sort the index entries. The first column is the primary sort criterion and the second column determines the order only if two entries have the same value in the first column and so on.

![Multi-column index](image-1.png)

The index excerpt in Figure 2.1 shows that the entries for subsidiary 20 are not stored next to each other. It is also apparent that there are no entries with SUBSIDIARY_ID = 20 in the tree, although they exist in the leaf nodes. The tree is therefore useless for this query.

Example:  
CREATE UNIQUE INDEX employees_pk
    ON employees (employee_id, subsidiary_id)  
If we use only subsidiary_id in a where clause, index will not be used.

Full table scan can be the most efficient operation in some cases, in particular when retrieving a large part of the table. This is partly due to the overhead for the index lookup itself, which does not happen for a full table scan operation. This is mostly because an index lookup reads one block after the other as the database does not know which block to read next until the current block has been processed. A FULL TABLE SCAN must get the entire table anyway so that the database can read larger chunks at a time (multi block read). Although the database reads more data, it might need to execute fewer read operations.

![Analyze index differences](image-2.png)

The PostgreSQL db uses two operations when reversing index and using (subsidiary_id, employee_id): a Bitmap Index Scan followed by a Bitmap Heap Scan. They roughly correspond to Oracle’s INDEX RANGE SCAN and TABLE ACCESS BY INDEX ROWID with one important difference: it first fetches all results from the index (Bitmap Index Scan), then sorts the rows according to the physical storage location of the rows in the heap table and then fetches all rows from the table (Bitmap Heap Scan). This method reduces the number of random access IOs on the table.

## Slow indexes Pt II

The query optimizer, or query planner, is the database component that transforms an SQL statement into an execution plan. This process is also called compiling or parsing. There are two distinct optimizer types.

Cost-based optimizers (CBO) generate many execution plan variations and calculate a cost value for each plan. The cost calculation is based on the operations in use and the estimated row numbers. In the end the cost value serves as the benchmark for picking the “best” execution plan.

Rule-based optimizers (RBO) generate the execution plan using a hard-coded rule set. Rule based optimizers are less flexible and are seldom used today.

Creating an index can sometimes lead to slowing down other queries.
```sql
/* Using (subsidiary_id, employee_id) index for this query is slower
because the index lookup returns many ROWIDs */
SELECT first_name, last_name, subsidiary_id, phone_number
FROM merged_employees
WHERE last_name  = 'WINAND'
AND subsidiary_id = 30
```
![Index creation slowing other queries](image-3.png)

# Functions

## Case-Insensitive Search Using UPPER or LOWER

```sql
/* Despite having an index on last_name, it is not used because the search is on upper(last_name) */
SELECT first_name, last_name, phone_number
FROM employees
WHERE UPPER(last_name) = UPPER('winand')
```

Sometimes ORM tools use UPPER and LOWER without the developer’s knowledge. Hibernate, for example, 
injects an implicit LOWER for case-insensitive searches.

Sometimes we can get contradicting estimates (e.g. previous index scan returning only 40 rows, 
and current estimate fetching 100 rows). Contradicting estimates like this often indicate problems with the statistics.
(More about statistics here https://www.postgresql.org/docs/current/catalog-pg-statistic.html)

## User-Defined Functions

Only deterministic functions marked with immutable can be indexed.

# Parameterized Queries

Dynamic parameters or bind variables are an alternative way to pass data to the database. 
Instead of putting the values directly into the SQL statement, you just use a placeholder like ?, :name or @name and provide the actual values using a separate API call.

2 Good reasons to use bind parameters:
- Security (prevents SQL injection)
- Performance (execution plan cache)

```
Column histograms are most useful if the values are not uniformly distributed.

For columns with uniform distribution, it is often sufficient to divide the number of 
distinct values by the number of rows in the table. This method also works when using bind parameters.
```

If we compare the optimizer to a compiler, bind variables are like program variables, 
but if you write the values directly into the statement they are more like constants. 
The database can use the values from the SQL statement during optimization just like a compiler can 
evaluate constant expressions during compilation. Bind parameters are, put simply, not visible to the optimizer just 
as the runtime values of variables are not known to the compiler.

Generating and evaluating all execution plan variants is a huge effort that 
does not pay off if you get the same result in the end anyway. 
Not using bind parameters is like recompiling a program every time.

Bind parameters cannot change the structure of an SQL statement. That means you cannot use bind parameters for table or column names. 
The following bind parameters do not work:

```
String sql = prepare("SELECT * FROM ? WHERE ?");

sql.execute('employees', 'employee_id = 1');
```
If you need to change the structure of an SQL statement during runtime, use dynamic SQL.