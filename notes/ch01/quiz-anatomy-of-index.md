# Quiz: Anatomy of an Index

## Section 1: Index Basics

**1. What is the primary purpose of a database index?**

A) To provide backup of data
B) To provide an ordered representation of indexed data
C) To compress table data
D) To enforce primary key constraints

**2. What data structure connects index leaf nodes?**

A) Singly linked list
B) Doubly linked list
C) Array
D) Hash table

**3. What is the smallest storage unit in a database?**

A) Byte
B) Kilobyte
C) Block or page
D) Record

**4. In a B-tree index, where are the actual indexed values stored?**

A) Root node
B) Branch nodes
C) Leaf nodes
D) All nodes

## Section 2: B-Tree Structure

**5. What does "balanced" mean in a B-tree?**

A) All leaf nodes have the same number of entries
B) Tree depth is equal at every position
C) All branch nodes have the same number of children
D) Left and right subtrees have equal height

**6. How many steps are required for an index lookup?**

A) One
B) Two
C) Three
D) Four

**7. Which step in an index lookup has an upper bound for accessed blocks?**

A) Tree traversal
B) Following the leaf node chain
C) Fetching table data
D) All steps

## Section 3: Index Scan Types

**8. Which Oracle index scan operation performs only the tree traversal?**

A) INDEX RANGE SCAN
B) INDEX UNIQUE SCAN
C) TABLE ACCESS BY INDEX ROWID
D) FULL SCAN

**9. Which operation retrieves the actual row from the table?**

A) INDEX UNIQUE SCAN
B) INDEX RANGE SCAN
C) TABLE ACCESS BY INDEX ROWID
D) TREE TRAVERSAL

**10. What is the potential downside of an INDEX RANGE SCAN?**

A) It can only return one row
B) It can read a large part of an index
C) It cannot use tree traversal
D) It requires full table scan

**11. What is the typical tree depth for indexes with millions of records?**

A) One or two
B) Three
C) Four or five
D) Ten or more

---

# Answer Key

1. **B** - To provide an ordered representation of indexed data
2. **B** - Doubly linked list
3. **C** - Block or page
4. **C** - Leaf nodes
5. **B** - Tree depth is equal at every position
6. **C** - Three (tree traversal, leaf node chain, table fetch)
7. **A** - Tree traversal
8. **B** - INDEX UNIQUE SCAN
9. **C** - TABLE ACCESS BY INDEX ROWID
10. **B** - It can read a large part of an index
11. **C** - Four or five
