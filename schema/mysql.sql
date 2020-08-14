CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS tester (
    pk BIGINT primary key,
    f1 BIGINT,
    f2 VARCHAR(255),
    f3 BIGINT,
    f4 VARCHAR(255),
    f5 BIGINT,
    f6 VARCHAR(255),
    f7 BIGINT,
    f8 VARCHAR(255),
    f9 BIGINT,
    f10 VARCHAR(255),
    f11 BIGINT,
    f12 VARCHAR(255),
    f13 BIGINT,
    f14 VARCHAR(255),
    f15 BIGINT,
    f16 VARCHAR(255),
    f17 BIGINT,
    f18 VARCHAR(255),
    f19 BIGINT
);

LOAD DATA INFILE '/data.csv' INTO TABLE tester FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

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