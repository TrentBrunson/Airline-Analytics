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










