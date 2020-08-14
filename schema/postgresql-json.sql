CREATE TABLE IF NOT EXISTS tester (
    pk BIGINT primary key,
    f1 BIGINT,
    f2 JSONB,
    f3 BIGINT,
    f4 JSONB,
    f5 BIGINT,
    f6 JSONB,
    f7 BIGINT,
    f8 JSONB,
    f9 BIGINT,
    f10 JSONB,
    f11 BIGINT,
    f12 JSONB,
    f13 BIGINT,
    f14 JSONB,
    f15 BIGINT,
    f16 JSONB,
    f17 BIGINT,
    f18 JSONB,
    f19 BIGINT
);

COPY tester FROM '/data.csv' DELIMITER ',' CSV;

SELECT *, pg_size_pretty(total_bytes) AS total
    , pg_size_pretty(index_bytes) AS index
    , pg_size_pretty(toast_bytes) AS toast
    , pg_size_pretty(table_bytes) AS table
  FROM (
  SELECT *, total_bytes-index_bytes-coalesce(toast_bytes,0) AS table_bytes FROM (
      SELECT c.oid,nspname AS table_schema, relname AS table_name
              , c.reltuples AS row_estimate
              , pg_total_relation_size(c.oid) AS total_bytes
              , pg_indexes_size(c.oid) AS index_bytes
              , pg_total_relation_size(reltoastrelid) AS toast_bytes
          FROM pg_class c
          LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
          WHERE relkind = 'r' AND relname = 'tester'
  ) a
) a;
