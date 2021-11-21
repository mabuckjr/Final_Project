-- Create services table
CREATE TABLE var_serv(
	cust INT NOT NULL,
	cycle VARCHAR NOT NULL,
	qty INT NOT NULL,
	size CHAR NOT NULL,
	pickups INT NOT NULL,
	commodity VARCHAR NOT NULL,
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
	cycle VARCHAR NOT NULL,
	monthly_bill INT NOT NULL,
	PRIMARY KEY (cust)
);

SELECT * FROM var_cust;

DROP TABLE var_cust;

-- Joining the two tables
SELECT vc.cust,
	vc.monthly_bill,
	vs.cycle,
	vs.qty,
	vs.size,
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