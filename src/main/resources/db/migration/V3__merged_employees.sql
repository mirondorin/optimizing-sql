CREATE TABLE merged_employees (
   employee_id   NUMERIC       NOT NULL,
   first_name    VARCHAR(1000) NOT NULL,
   last_name     VARCHAR(1000) NOT NULL,
   date_of_birth DATE                  ,
   phone_number  VARCHAR(1000) NOT NULL,
   junk          CHAR(1000)            ,
   CONSTRAINT merged_employees_pk PRIMARY KEY (employee_id)
);

INSERT INTO merged_employees (employee_id,  first_name,
                       last_name,    date_of_birth,
                       phone_number, junk)
SELECT GENERATE_SERIES
     , initcap(lower(random_string(2, 8)))
     , initcap(lower(random_string(2, 8)))
     , CURRENT_DATE - CAST(floor(random() * 365 * 10 + 40 * 365) AS NUMERIC) * INTERVAL '1 DAY'
     , CAST(floor(random() * 9000 + 1000) AS NUMERIC)
     , 'junk'
  FROM GENERATE_SERIES(1, 1000);


ALTER TABLE merged_employees ADD subsidiary_id NUMERIC;
UPDATE      merged_employees SET subsidiary_id = 30;
ALTER TABLE merged_employees ALTER COLUMN subsidiary_id SET NOT NULL;

ALTER TABLE merged_employees DROP CONSTRAINT merged_employees_pk;
ALTER TABLE merged_employees ADD CONSTRAINT merged_employees_pk
      PRIMARY KEY (employee_id, subsidiary_id);

INSERT INTO merged_employees (employee_id,  first_name,
                       last_name,    date_of_birth,
                       phone_number, subsidiary_id, junk)
SELECT GENERATE_SERIES
     , initcap(lower(random_string(2, 8)))
     , initcap(lower(random_string(2, 8)))
     , CURRENT_DATE - CAST(floor(random() * 365 * 10 + 40 * 365) AS NUMERIC) * INTERVAL '1 DAY'
     , CAST(floor(random() * 9000 + 1000) AS NUMERIC)
--     new records are randomly assigned to the subsidiaries 1 through 29.
     , CAST(floor(random() * (generate_series)/9000*29) AS NUMERIC)
     , 'junk'
  FROM GENERATE_SERIES(1, 9000);