CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS tester (
    pk BIGINT primary key,
    f1 BIGINT,
    f2 JSON,
    f3 BIGINT,
    f4 JSON,
    f5 BIGINT,
    f6 JSON,
    f7 BIGINT,
    f8 JSON,
    f9 BIGINT,
    f10 JSON,
    f11 BIGINT,
    f12 JSON,
    f13 BIGINT,
    f14 JSON,
    f15 BIGINT,
    f16 JSON,
    f17 BIGINT,
    f18 JSON,
    f19 BIGINT
);

LOAD DATA INFILE '/data.csv' INTO TABLE tester FIELDS TERMINATED BY ','  ENCLOSED BY '"';

ANALYZE TABLE tester;

SELECT 
    table_name AS `Table`, 
    data_length as `Table bytes`,
    index_length as `Index bytes`,
    data_length + index_length as `Total bytes`,
    round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
WHERE table_schema = "testdb"
    AND table_name = "tester";