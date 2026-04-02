The join operation transforms data from a normalized model into a denormalized form that suits a specific processing 
purpose. Joining is particularly sensitive to disk seek latencies because it combines scattered data fragments. 
Proper indexing is again the best solution to reduce response times. The correct index however depends on which of 
the three common join algorithms is used for the query.

Even though the join order has no impact on the final result, it still affects performance. The optimizer will 
therefore evaluate all possible join order permutations and select the best one. That means that just optimizing a 
complex statement might become a performance problem. The more tables to join, the more execution plan variants to 
evaluate—mathematically speaking: n! (factorial growth), though this is not a problem when using bind parameters.
The more complex the statement the more important using bind parameters becomes. Not using bind parameters is like 
recompiling a program every time.

# Nested Loops

The nested loops join is the most fundamental join algorithm. The outer query fetches results from one table, 
and a second query for each row from the outer query to fetch the corresponding data from the other table. This 
approach is an antipattern known as the “N+1 problem”, because it executes N+1 selects in total if 
the driving query returns N rows.

An SQL join is more efficient than the nested selects approach—even though it performs the same index 
lookups—because it avoids a lot of network communication.

Most ORM tools offer some way to create SQL joins. Eager fetching mode is probably the most important 
one. It is typically configured at the property level in the entity mappings. Configuring eager fetching in the 
entity mappings only makes sense if you always need the employee details along with the sales data.

The nested loops join delivers good performance if the driving query returns a small result set. Otherwise, the 
optimizer might choose an entirely different join algorithm—like the hash join, but this is only possible if the 
application uses a join to tell the database what data it actually needs.