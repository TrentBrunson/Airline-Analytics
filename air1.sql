-- GUI SCRIPT option from respective table
SELECT fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay
	FROM public.performance;

SELECT * FROM PERFORMANCE;

SELECT mkt_carrier, mkt_carrier_fl_num, origin
	FROM performance;
	
SELECT mkt_carrier AS airline, 
	mkt_carrier_fl_num flight, 
	origin depart_city
	FROM performance;

SELECT DISTINCT mkt_carrier 
	FROM performance;

SELECT mkt_carrier,
	origin depart_city
	FROM performance;

SELECT DISTINCT mkt_carrier,
	origin depart_city
	FROM performance;

SELECT fl_date,
	mkt_carrier airline,
	mkt_carrier_fl_num flight,
	origin,
	dest
	FROM performance
	WHERE origin = 'ORD';
	
SELECT fl_date,
	mkt_carrier airline,
	mkt_carrier_fl_num flight,
	origin,
	dest
	FROM performance
	WHERE dest = 'ORD';

SELECT fl_date,
	mkt_carrier airline,
	mkt_carrier_fl_num flight,
	origin,
	dest
	FROM performance
	WHERE dest = 'ORD'
		AND origin = 'BZN';

	mkt_carrier airline,
	mkt_carrier_fl_num flight,
	origin,
	dest
	FROM performance
	WHERE dest = 'ORD';

SELECT fl_date,
	mkt_carrier airline,
	mkt_carrier_fl_num flight,
	origin_city_name
	FROM performance
	WHERE origin_city_name LIKE 'Fort%';

SELECT DISTINCT origin_city_name
	FROM performance
	WHERE origin_city_name LIKE 'Fort%';

SELECT DISTINCT origin_city_name
	FROM performance
 WHERE origin_city_name LIKE '%FL';

SELECT DISTINCT origin_city_name
	FROM performance
 WHERE origin_city_name LIKE 'New%LA';

SELECT DISTINCT origin_city_name
	FROM performance
 WHERE origin_city_name LIKE '____, KS';

SELECT DISTINCT origin_city_name
	FROM performance
 WHERE origin_city_name LIKE '____, %';

SELECT DISTINCT origin_city_name
	FROM performance
 WHERE origin_city_name NOT LIKE '____, %';

SELECT fl_date,
	mkt_carrier AS airline,
	mkt_carrier_fl_num AS flight,
	cancellation_code
	FROM performance
	WHERE cancellation_code IS NOT NULL;

SELECT fl_date,
	mkt_carrier AS airline,
	mkt_carrier_fl_num AS flight,
	cancellation_code
	FROM performance
	WHERE cancellation_code IS NULL;

SELECT *
	FROM performance;

SELECT *
	FROM codes_cancellation;
	
SELECT *
	FROM codes_carrier;

SELECT p.fl_date,
		p.mkt_carrier,
		p.mkt_carrier_fl_num AS flight,
		p. origin_city_name,
		p. dest_city_name
	FROM performance p; 

SELECT p.fl_date,
		p.mkt_carrier,
-- 		add new column to select clause
		cc.carrier_desc as airline,
		p.mkt_carrier_fl_num AS flight,
		p. origin_city_name,
		p. dest_city_name
	FROM performance p
INNER JOIN codes_carrier cc
	ON p.mkt_carrier = cc.carrier_code; 

-- look at cancellations
SELECT p.fl_date,
		p.mkt_carrier,
		cc.carrier_desc as airline,
		p.mkt_carrier_fl_num AS flight,
		p. origin_city_name,
		p. dest_city_name,
		p.cancellation_code,
		ca.cancel_desc
	FROM performance p
INNER JOIN codes_carrier cc
	ON p.mkt_carrier = cc.carrier_code
LEFT JOIN codes_cancellation ca
	ON p.cancellation_code = ca.cancellation_code;

SELECT dep_delay_new FROM performance;
	
SELECT AVG(dep_delay_new) FROM performance;

SELECT mkt_carrier,
		AVG(dep_delay_new)
	FROM performance p
	GROUP BY mkt_carrier;

-- add inner join to make table easier to reference
SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc;

-- add order by to see airline with shortest dept delay
SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG(p.dep_delay_new);

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG(p.dep_delay_new) DESC;

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new) AS dept_delay,
		AVG(p.arr_delay_new) AS arrival_delay
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY 2; --order by 2nd column

-- see who had lowest avg of dept & arrival delays
SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new) AS dep_delay,
		AVG(p.arr_delay_new) AS arrival_delay
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
-- 			(p.dep_delay_new + p.arr_delay_new) as delay_total
	ORDER BY AVG(p.dep_delay_new);

-- -----------------------------------------------------
-- see who had lowest avg of dept & arrival delays
SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new) AS dep_delay,
		AVG(p.arr_delay_new) AS arrival_delay
-- 		, (p.dep_delay_new + p.arr_delay_new) as delay_avg

	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG(p.dep_delay_new);

SELECT dep_delay_new + arr_delay_new as delay_total FROM performance;

SELECT (dep_delay_new + arr_delay_new) AS total_delay
	FROM performance
	GROUP BY mkt_carrier;

-- -----------------------------------------------------

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	HAVING AVG(p.dep_delay_new)>15
	AND AVG(arr_delay_new)>15;






