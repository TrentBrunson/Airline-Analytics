SELECT * FROM codes_carrier;

SELECT carrier_code || ': ' || carrier_desc FROM codes_carrier;

SELECT CONCAT(carrier_code, ': ', carrier_desc) AS display_carrier
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		SUBSTRING(carrier_desc, 1, 8) AS carrier_display
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		REPLACE(SUBSTRING(carrier_desc, 1, 8), ' ', '') AS carrier_display
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		UPPER(REPLACE(SUBSTRING(carrier_desc, 1, 8), ' ', '')) AS carrier_display
	FROM codes_carrier;

-- airline analytics
SELECT AVG(dep_delay_new)
	FROM performance;

SELECT mkt_carrier,
		AVG(dep_delay_new)
	FROM performance
	GROUP BY mkt_carrier;

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc;

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc;

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG (p.dep_delay_new);

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new)
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG (p.dep_delay_new) DESC;
	
SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new) AS depart_delay,
		AVG(p.arr_delay_new) AS arr_delay
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY AVG (p.dep_delay_new);	

SELECT p.mkt_carrier,
		c.carrier_desc,
		AVG(p.dep_delay_new) AS depart_delay,
		AVG(p.arr_delay_new) AS arr_delay
	FROM performance p
INNER JOIN codes_carrier c
	ON p.mkt_carrier = c.carrier_code
	GROUP BY p.mkt_carrier,
			c.carrier_desc
	ORDER BY 2;	

SELECT grade_lvl,
		AVG(age) AS avg_age
	FROM person
	GROUP BY grade_lvl;

-- see delays >15 mins
SELECT p.mkt_carrier,
        c.carrier_desc,
        AVG(p.dep_delay_new) AS dep_delay,
        AVG(p.arr_delay_new) AS arr_delay
    FROM performance p
INNER JOIN codes_carrier c
    ON p.mkt_carrier = c.carrier_code
    GROUP BY p.mkt_carrier,
            c.carrier_desc
    HAVING AVG (p.dep_delay_new) > 15
        AND AVG (p.arr_delay_new) > 15;

-- 
SELECT * FROM performance;

SELECT * FROM codes_cancellation;

SELECT * FROM codes_carrier;

SELECT p.fl_date,
        p.mkt_carrier,
        p.mkt_carrier_fl_num AS flight,
        p.origin_city_name,
        p.dest_city_name
    FROM performance p;

SELECT p.fl_date,
        p.mkt_carrier,
        cc.carrier_desc as airline,
        p.mkt_carrier_fl_num AS flight,
        p.origin_city_name,
        p.dest_city_name
    FROM performance p
INNER JOIN codes_carrier cc
    ON p.mkt_carrier = cc.carrier_code;

SELECT p.fl_date,
        p.mkt_carrier,
        cc.carrier_desc as airline,
        p.mkt_carrier_fl_num AS flight,
        p.origin_city_name,
        p.dest_city_name,
        p.cancellation_code
    FROM performance p
INNER JOIN codes_carrier cc
    ON p.mkt_carrier = cc.carrier_code;

-- add codes cancellation table to understand codes

SELECT p.fl_date,
        p.mkt_carrier,
        cc.carrier_desc as airline,
        p.mkt_carrier_fl_num AS flight,
        p.origin_city_name,
        p.dest_city_name,
        p.cancellation_code,
        ca.cancel_desc
    FROM performance p
INNER JOIN codes_carrier cc
    ON p.mkt_carrier = cc.carrier_code
LEFT JOIN codes_cancellation ca
    ON p.cancellation_code = ca.cancellation_code;

-- SET THEORY: UNION INTERSECT EXCEPT
SELECT *
    FROM performance p 
    WHERE origin = 'BIL'
        AND dest = 'SEA'
        AND fl_date = '2018-01-01';

SELECT *
    FROM performance
    WHERE origin = 'BZN'
        AND dest = 'SEA'
        AND fl_date = '2018-01-01';

SELECT *
    FROM performance p 
    WHERE origin = 'BIL'
        AND dest = 'SEA'
        AND fl_date = '2018-01-01'
UNION
SELECT *
    FROM performance
    WHERE origin = 'BZN'
        AND dest = 'SEA'
        AND fl_date = '2018-01-01';

-- sub-queries
SELECT fl_date,
        mkt_carrier || ' ' || mkt_carrier_fl_num AS flight,
        origin,
        dest
    FROM performance
    WHERE cancelled = 1
        AND cancellation_code IN    
            (SELECT cancellation_code
                FROM codes_cancellation
                WHERE cancel_desc = 'Weather');

SELECT *
    FROM codes_cancellation;

-- correlated subquery
SELECT a.fl_date,
        a.mkt_carrier,
        a.mkt_carrier_fl_num,
        a.origin,
        a.dest,
        a.dep_delay_new
    FROM performance a
    WHERE a.fl_date = '2018-01-02'
        AND a.mkt_carrier = 'UA'
        AND a.origin = 'DEN'
        AND a.dest IN ('ORD', 'SFO');

-- return flights that only exceed average departure delay for a departure city
SELECT a.fl_date,
        a.mkt_carrier,
        a.mkt_carrier_fl_num,
        a.origin,
        a.dest,
        a.dep_delay_new
    FROM performance a
    WHERE a.fl_date = '2018-01-02'
        AND a.mkt_carrier = 'UA'
        AND a.origin = 'DEN'
        AND a.dest IN ('ORD', 'SFO')
        AND a.dep_delay_new > (SELECT AVG (dep_delay_new)
                                    FROM performance
                                    WHERE dep_delay_new > 0
                                    AND a.origin = origin
                                    AND a.dest = dest
                                    AND a.mkt_carrier = mkt_carrier);












