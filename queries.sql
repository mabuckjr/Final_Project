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

-- Create table for the pivot I made in Pandas
CREATE TABLE commodity_table(
	cust INT NOT NULL,
	biz_type VARCHAR NOT NULL,
	compost INT NOT NULL,
	garbage INT NOT NULL,
	recycle INT NOT NULL,
	do_they_recycle VARCHAR NOT NULL,
	do_they_compost VARCHAR NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM commodity_table;

DROP TABLE commodity_table;

--Join Var Cust, Var Serv, and commodity tables (will have to remove duplicate rows in pandas)
SELECT vc.cust,
	vc.monthly_bill,
	vs.tax_body,
	ct.biz_type,
	ct.compost,
	ct.garbage,
	ct.recycle,
	ct.do_they_recycle,
	ct.do_they_compost
INTO ml_table
FROM var_cust as vc
RIGHT JOIN var_serv as vs
ON (vc.cust=vs.cust)
INNER JOIN commodity_table as ct
ON (vc.cust = ct.cust);

SELECT * FROM ml_table;

Drop TABLE ml_table;
