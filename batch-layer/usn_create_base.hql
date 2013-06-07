CREATE DATABASE IF NOT EXISTS usn;

USE usn;

DROP TABLE IF EXISTS usn_base;

CREATE TABLE usn_base (
 actiontime STRING,
 originator STRING,
 action STRING,
 network STRING,
 target STRING,
 context STRING
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|';

LOAD DATA LOCAL INPATH '../data/usn-base-data.csv' INTO TABLE usn_base;