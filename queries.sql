-- Create services table
CREATE TABLE var_serv(
	cust INT NOT NULL,
	cycle VARCHAR NOT NULL,
	qty INT NOT NULL,
	size INT NOT NULL,
	weekly_yards INT NOT NULL,
	commodity VARCHAR NOT NULL,
	pickups INT NOT NULL,
	bin_amount INT NOT NULL,
	tax_body VARCHAR NOT NULL,
	biz_type VARCHAR NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM var_serv;

DROP TABLE var_serv;


-- Create customer table
CREATE TABLE var_cust(
	cust INT NOT NULL,
	tax_body VARCHAR NOT NULL,
	monthly_bill INT NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM var_cust;

DROP TABLE var_cust;

-- Create table for the pivot I made in Pandas
CREATE TABLE commodity_table(
	cust INT NOT NULL,
	biz_type VARCHAR NOT NULL,
	compost INT NOT NULL,
	garbage INT NOT NULL,
	recycle INT NOT NULL,
	do_they_recycle VARCHAR NOT NULL,
	do_they_compost VARCHAR NOT NULL,
	needed_recycle INT NOT NULL,
	needed_compost INT NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM commodity_table;

DROP TABLE commodity_table;


-- Create table for training data
CREATE TABLE train_data(
	cust INT NOT NULL,
	biz_type VARCHAR NOT NULL,
	compost INT NOT NULL,
	garbage INT NOT NULL,
	recycle INT NOT NULL,
	do_they_recycle VARCHAR NOT NULL,
	do_they_compost VARCHAR NOT NULL,
	needed_recycle INT NOT NULL,
	needed_compost INT NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM train_data;

DROP TABLE train_data;

-- Create table for the testing data
CREATE TABLE test_data(
	cust INT NOT NULL,
	biz_type VARCHAR NOT NULL,
	compost INT NOT NULL,
	garbage INT NOT NULL,
	recycle INT NOT NULL,
	do_they_recycle VARCHAR NOT NULL,
	do_they_compost VARCHAR NOT NULL,
	needed_recycle INT NOT NULL,
	needed_compost INT NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM test_data;

DROP TABLE test_data;

-- Joining the two tables var tables (just in case I need it later)
SELECT vc.cust,
	vc.monthly_bill,
	vs.cycle,
	vs.qty,
	vs.size,
	vs.weekly_yards,
	vs.commodity,
	vs.pickups,
	vs.bin_amount,
	vs.tax_body,
	vs.biz_type
INTO cust_serv
FROM var_cust as vc
INNER JOIN var_serv as vs
ON (vc.cust = vs.cust);

SELECT * FROM cust_serv;

Drop TABLE cust_serv;


--Join Var Cust, Var Serv, and commodity tables (will have to remove duplicate rows in pandas)
SELECT vc.cust,
	vc.monthly_bill,
	vs.tax_body,
	ct.biz_type,
	ct.compost,
	ct.garbage,
	ct.recycle,
	ct.do_they_recycle,
	ct.do_they_compost,
	ct.needed_recycle,
	ct.needed_compost
INTO ml_table
FROM var_cust as vc
RIGHT JOIN var_serv as vs
ON (vc.cust=vs.cust)
INNER JOIN commodity_table as ct
ON (vc.cust = ct.cust);

SELECT * FROM ml_table;

Drop TABLE ml_table;


--Join Var Cust, Var Serv, and train data (will have to remove duplicate rows in pandas)
SELECT vc.cust,
	vc.monthly_bill,
	vs.tax_body,
	tr.biz_type,
	tr.compost,
	tr.garbage,
	tr.recycle,
	tr.do_they_recycle,
	tr.do_they_compost,
	tr.needed_recycle,
	tr.needed_compost
INTO tr_table
FROM var_cust as vc
RIGHT JOIN var_serv as vs
ON (vc.cust=vs.cust)
INNER JOIN train_data as tr
ON (vc.cust = tr.cust);

SELECT * FROM tr_table;

Drop TABLE tr_table;

--Join Var Cust, Var Serv, and test data (will have to remove duplicate rows in pandas)
SELECT vc.cust,
	vc.monthly_bill,
	vs.tax_body,
	te.biz_type,
	te.compost,
	te.garbage,
	te.recycle,
	te.do_they_recycle,
	te.do_they_compost,
	te.needed_recycle,
	te.needed_compost
INTO te_table
FROM var_cust as vc
RIGHT JOIN var_serv as vs
ON (vc.cust=vs.cust)
INNER JOIN test_data as te
ON (vc.cust = te.cust);

SELECT * FROM te_table;

Drop TABLE te_table;