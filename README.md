All information/diagrams are taken from https://use-the-index-luke.com/
I restructure the information the way it makes sense to me and add my own experiments on top of it. 

Had to install gzip from https://github.com/ossc-db/pg_hint_plan
and run 
```
$ tar xzvf pg_hint_plan-1.x.x.tar.gz
$ cd pg_hint_plan-1.x.x
$ make
$ su
$ make install
```
This extension allows exclusion of using indices / forcing plan. For example:
```sql
/* The SeqScan comment will force usage of SeqScan.
   Important: make sure to use load 'pg_hint_plan' before running queries 
*/
explain
SELECT /*+ SeqScan(merged_employees) */
first_name, last_name, subsidiary_id, phone_number
FROM merged_employees
WHERE last_name  = 'WINAND'
AND subsidiary_id = 30
```