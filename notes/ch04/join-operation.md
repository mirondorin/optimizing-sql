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