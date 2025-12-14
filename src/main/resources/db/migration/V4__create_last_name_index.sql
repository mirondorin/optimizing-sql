CREATE INDEX IF NOT EXISTS emp_name ON merged_employees (last_name);
CREATE INDEX IF NOT EXISTS emp_up_name ON merged_employees (UPPER(last_name))