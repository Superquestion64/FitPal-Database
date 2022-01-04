-- Charles Vega and Melissa Jesmin's Fit Pal Database
-- Last Modified December 5, 2021
-- The following code is used to demonstarate Fit Pal's Database

-- Below we create 8 tables, vendor, consumers, goal_defines, goals, routine_defines, routines, fit_defines, fit_levels

CREATE TABLE vendor ( 
vendor varchar(7), 
vphone varchar(12), 
vaddr varchar(256), 
vemail varchar(64), 
PRIMARY KEY (vendor)
);

CREATE TABLE consumers ( 
cid int, 
cfirst varchar(32), 
clast varchar(32),
cemail varchar(64), 
cheight int, 
cweight double, 
cage int, 
PRIMARY KEY (cid)
);

CREATE TABLE goal_defines ( 
gid int, 
goal varchar(24),
PRIMARY KEY (gid)
);

CREATE TABLE goals (
cid int, 
gid int, 
PRIMARY KEY (cid),
FOREIGN KEY (cid) REFERENCES consumers (cid),
FOREIGN KEY (gid) REFERENCES goal_defines (gid)
);

CREATE TABLE routine_defines ( 
rid int, 
routine varchar(24),
PRIMARY KEY (rid)
);

CREATE TABLE routines (
cid int, 
rid int, 
PRIMARY KEY (cid), 
FOREIGN KEY (cid) REFERENCES consumers (cid),
FOREIGN KEY (rid) REFERENCES routine_defines (rid)
);

CREATE TABLE fit_defines ( 
fid int, 
flevel varchar(24),
PRIMARY KEY (fid)
);

CREATE TABLE fit_levels (
cid int, 
fid int,
PRIMARY KEY (cid), 
FOREIGN KEY (cid) REFERENCES consumers (cid),
FOREIGN KEY (fid) REFERENCES fit_defines (fid)
);

-- Load data into the tables:

load data local infile
'Table_Data/Vendor-Data.csv'
into table vendor
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Consumer-Data.csv'
into table consumers
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Goal-Defines.csv'
into table goal_defines
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Goal-Data.csv'
into table goals
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Routine-Defines.csv'
into table routine_defines
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Routine-Data.csv'
into table routines
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Fit-Defines.csv'
into table fit_defines
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

load data local infile
'Table_Data/Fit-Data.csv'
into table fit_levels
fields terminated by ','
optionally enclosed by '"'
ignore 1 lines;

-- Check your tables:

SELECT * FROM vendor;
SELECT * FROM consumers;
SELECT * FROM goal_defines;
SELECT * FROM goals;
SELECT * FROM routine_defines;
SELECT * FROM routines;
SELECT * FROM fit_defines;
SELECT * FROM fit_levels;

-- Combine their names and routine ID

SELECT consumers.cid, consumers.cfirst, consumers.clast, routines.rid 
FROM consumers
LEFT JOIN routines
ON routines.cid = consumers.cid;

-- Combine people with their routines

SELECT consumers.cid, consumers.cfirst, consumers.clast, routines.rid, routine_defines.routine 
FROM consumers
LEFT JOIN routines
ON routines.cid = consumers.cid
LEFT JOIN routine_defines
ON routine_defines.rid = routines.rid;

-- Find people with a specific routine

SELECT consumers.cid, consumers.cfirst, consumers.clast, routines.rid, routine_defines.routine
FROM consumers
INNER JOIN routines
ON routines.cid = consumers.cid AND routines.rid = 1
LEFT JOIN routine_defines
ON routine_defines.rid = routines.rid;

SELECT consumers.cid, consumers.cfirst, consumers.clast, routines.rid, routine_defines.routine 
FROM consumers
INNER JOIN routines
ON routines.cid = consumers.cid AND routines.rid = 3
LEFT JOIN routine_defines
ON routine_defines.rid = routines.rid;

-- Find people with a specific goal

SELECT consumers.cid, consumers.cfirst, consumers.clast, goals.gid, goal_defines.goal
FROM consumers
INNER JOIN goals
ON goals.cid = consumers.cid AND goals.gid = 2
LEFT JOIN goal_defines
ON goal_defines.gid = goals.gid;

SELECT consumers.cid, consumers.cfirst, consumers.clast, goals.gid, goal_defines.goal
FROM consumers
INNER JOIN goals
ON goals.cid = consumers.cid AND goals.gid = 1
LEFT JOIN goal_defines
ON goal_defines.gid = goals.gid;

-- Find people over or below 30 years old

SELECT consumers.cid, consumers.cfirst, consumers.clast, consumers.cage
FROM consumers
WHERE consumers.cage > 30;

SELECT consumers.cid, consumers.cfirst, consumers.clast, consumers.cage
FROM consumers
WHERE consumers.cage < 30;

-- Find people who are over, under, or within the standard BMI

SELECT cid, cfirst, clast, (cweight/cheight/cheight)*10000 as BMI
FROM consumers;

SELECT cid, cfirst, clast, (cweight/cheight/cheight)*10000 as BMI
FROM consumers
WHERE (cweight/cheight/cheight)*10000 > 25;

SELECT cid, cfirst, clast, (cweight/cheight/cheight)*10000 as BMI
FROM consumers
WHERE (cweight/cheight/cheight)*10000 < 18.5;

SELECT cid, cfirst, clast, (cweight/cheight/cheight)*10000 as BMI
FROM consumers
WHERE (cweight/cheight/cheight)*10000 > 18.5 AND (cweight/cheight/cheight)*10000 < 25;