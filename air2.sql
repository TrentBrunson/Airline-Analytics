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
-- ***********
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
-- ****************

-- calculate avg flt delay twixt DEN & SFO
SELECT dest,
        AVG(dep_delay_new)
    FROM performance
    WHERE mkt_carrier = 'UA'
        AND origin = 'DEN'
        AND dest IN ('SFO', 'ORD')
        AND dep_delay_new > 0 
    GROUP BY dest;

-- Common table expressions
-- convert **************** to CTE
WITH delays AS (
    SELECT origin,
            dest,
            AVG(dep_delay_new) as avg_dep_delay
        FROM performance
        WHERE mkt_carrier = 'UA'
            AND dep_delay_new > 0
            GROUP BY origin, dest)
-- find results where dep delay exceeded industry average for that city
SELECT a.fl_date,
        a.mkt_carrier,
        a.mkt_carrier_fl_num,
        a.origin,
        a.dest,
        a.dep_delay_new
    FROM performance a
INNER JOIN delays b
    ON a.origin = b.origin
        AND a.dest = b.dest
    WHERE a.fl_date = '20'UA'18-01-02'
        AND a.mkt_carrier = 
        AND a.dep_delay_new > b.avg_dep_delay;

-- how many UA flights on Jan 2d?
SELECT COUNT(*)
    FROM performance
    WHERE mkt_carrier = 'UA'
        AND fl_date = '2018-01-02';

-- Window f(x)

SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new
    FROM performance 
    WHERE fl_date = '2018-01-02'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI'

-- Window f(x)
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI'

-- ROW_NUMBER()
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new,
		ROW_NUMBER () OVER (ORDER BY CAST(mkt_carrier_fl_num AS INT)) AS rn
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI'

-- focus on arrival delays with RANK()
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new,
		RANK () OVER (ORDER BY arr_delay_new) AS delay_rank
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI';

-- focus on arrival delays RANK()
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new,
		RANK () OVER (ORDER BY arr_delay_new DESC) AS delay_rank
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI';

-- DENSE_RANK () - don't skip integers
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new,
		DENSE_RANK () OVER (ORDER BY arr_delay_new DESC) AS delay_rank
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI';
		
-- DENSE_RANK () & group by arrival airport
SELECT mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        dest,
        arr_delay_new,
		DENSE_RANK () OVER (PARTITION BY dest ORDER BY arr_delay_new DESC) AS delay_rank
    FROM performance 
    WHERE fl_date = '2018-01-16'
        AND mkt_carrier = 'AA'
        AND origin = 'MCI';

-- look for detroit departure delays
SELECT fl_date,
        SUM(dep_delay_new) AS dep_delay
    FROM performance
    WHERE origin = 'DTW'
    GROUP BY fl_date;

-- convert above query to CTE
WITH daily_delays AS (
    SELECT fl_date,
        SUM(dep_delay_new) AS dep_delay
    FROM performance
    WHERE origin = 'DTW'
    GROUP BY fl_date)

-- compare day to previous day (1 day prior)
    -- keep data order by ordering by flt_date
 SELECT fl_date,
        dep_delay,
        LAG(dep_delay,1) OVER (ORDER BY fl_date) AS prior_day_delay
    FROM daily_delays;

-- calculate delay differences between two days
WITH daily_delays AS (
    SELECT fl_date,
        SUM(dep_delay_new) AS dep_delay
    FROM performance
    WHERE origin = 'DTW'
    GROUP BY fl_date)

-- compare day to previous day (1 day prior)
    -- keep data order by ordering by flt_date
 SELECT fl_date,
        dep_delay,
        LAG(dep_delay,1) OVER (ORDER BY fl_date) AS prior_day_delay,
    
        -- calculate delay differences between two days, today and 1 day prior
        dep_delay - LAG(dep_delay,1) OVER (ORDER BY fl_date) AS change
    FROM daily_delays;


-- ***********************************
-- See all flights in and our of Wichita - ICT
SELECT fl_date,
        mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        origin_city_name,
        dest,
        dest_city_name,
        dep_delay_new,
        arr_delay_new
    FROM performance
    WHERE dest = 'ICT';

-- join above query to carrier code ref table
SELECT p.fl_date,
        p.mkt_carrier,
        c.carrier_desc,
        p.mkt_carrier_fl_num,
        p.origin,
        p.origin_city_name,
        p.dest,
        p.dest_city_name,
        p.dep_delay_new,
        p.arr_delay_new
    FROM performance p
JOIN codes_carrier c
    ON p.mkt_carrier = c.carrier_code
    WHERE p.dest = 'ICT';

-- avg delay for arrivals into ICT
SELECT AVG(arr_delay_new) AS avg_arr_delay
FROM performance
WHERE dest = 'ICT';

-- avg delay for arrivals into ICT
    -- exclude on arrivals to see only lates
SELECT AVG(arr_delay_new) AS avg_arr_delay
FROM performance
WHERE dest = 'ICT'
    AND arr_delay_new <> 0;

-- avg delay for arrivals into ICT by airline
    -- exclude on arrivals to see only lates
SELECT p.mkt_carrier,
        c.carrier_desc,
        AVG(arr_delay_new) AS avg_arr_delay
FROM performance p
JOIN codes_carrier c
    ON p.mkt_carrier = c.carrier_code
    WHERE p.dest = 'ICT'
    AND arr_delay_new <> 0
    GROUP BY p.mkt_carrier,
            c.carrier_desc;

-- ***********************************************
-- Set theory
-- See all flights in and our of Wichita - ICT
SELECT fl_date,
        mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        origin_city_name,
        dest,
        dest_city_name,
        dep_delay_new,
        arr_delay_new
    FROM performance
    WHERE dest = 'ICT'

UNION

-- See all flights in and our of Wichita - ICT
SELECT fl_date,
        mkt_carrier,
        mkt_carrier_fl_num,
        origin,
        origin_city_name,
        dest,
        dest_city_name,
        dep_delay_new,
        arr_delay_new
    FROM perform_feb
    WHERE dest = 'ICT'
    ORDER BY 1;

-- subquery to calculate avg arr delay for the airport with the combined result set
SELECT AVG(p.arr_delay_new) AS avg_arr_delay
    FROM 
    (SELECT fl_date,
            mkt_carrier,
            mkt_carrier_fl_num,
            origin,
            origin_city_name,
            dest,
            dest_city_name,
            dep_delay_new,
            arr_delay_new
        FROM performance
        WHERE dest = 'ICT'

    UNION

    -- See all flights in and our of Wichita - ICT
    SELECT fl_date,
            mkt_carrier,
            mkt_carrier_fl_num,
            origin,
            origin_city_name,
            dest,
            dest_city_name,
            dep_delay_new,
            arr_delay_new
        FROM perform_feb
        WHERE dest = 'ICT') p
-- include rows only where a delay occurs
    WHERE p.arr_delay_new <> 0;

-- create CTE to reduce lines of query from UNION
WITH flightinfo AS (
    SELECT * FROM performance
        UNION
    SELECT * FROM perform_feb
-- keep filters & other limiting criteria like arpt code in main query
)

SELECT AVG(arr_delay_new) AS avg_arr_delay
    FROM flightinfo --point FROM clause to CTE above
    WHERE dest = 'ICT';

-- find flights that delays exceeding the avg arrival delay for the arpt in question
    -- rank DESC
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

    SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month); --correlate month of subquery to outer query

-- rank arrival delays from longest to shortest
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

    SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new,
            DENSE_RANK () OVER (
                            PARTITION BY fl_month 
                            ORDER BY arr_delay_new DESC) AS ranking
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month); --correlate month of subquery to outer query

-- View top 3 delays from each month
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

-- can't use window function in where clause...so make outer query into a subquery
SELECT pp.*
    FROM
    (SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new,
            DENSE_RANK () OVER (
                            PARTITION BY fl_month 
                            ORDER BY arr_delay_new DESC) AS ranking
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month)) pp --correlate month of subquery to outer query
WHERE pp.ranking < 4;

-- String functions
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

-- can't use window function in where clause...so make outer query into a subquery
SELECT pp.fl_month,
        pp.mkt_carrier,
        pp.mkt_carrier_fl_num,
        pp.arr_delay_new,
        pp.ranking
        (pp.origin_city_name || ' to ' || pp.dest_city_name) AS route
    FROM
    (SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new,
            DENSE_RANK () OVER (
                            PARTITION BY fl_month 
                            ORDER BY arr_delay_new DESC) AS ranking
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month)) pp --correlate month of subquery to outer query
WHERE pp.ranking < 4;

-- String functions
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

-- can't use window function in where clause...so make outer query into a subquery
SELECT pp.fl_month,
        pp.mkt_carrier,
        pp.mkt_carrier_fl_num,
        pp.arr_delay_new,
        pp.ranking,
--         concatenate origin & destination
		(pp.origin_city_name || ' to ' || pp.dest_city_name) AS route
    FROM
    (SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new,
            DENSE_RANK () OVER (
                            PARTITION BY fl_month 
                            ORDER BY arr_delay_new DESC) AS ranking
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month)) pp --correlate month of subquery to outer query
WHERE pp.ranking < 4;

-- String functions
WITH flightinfo AS (
    SELECT a.*, 'Jan' as fl_month FROM performance a WHERE a.dest = 'ICT'
        UNION
    SELECT b.*, 'Feb' AS fl_month FROM perform_feb b WHERE b.dest = 'ICT')

-- can't use window function in where clause...so make outer query into a subquery
SELECT pp.fl_month,
        pp.mkt_carrier,
        pp.mkt_carrier_fl_num,
        pp.arr_delay_new,
        pp.ranking,
--         concatenate origin & destination; remove ','
		REPLACE((pp.origin_city_name || ' to ' || pp.dest_city_name), ',', '') AS route
    FROM
    (SELECT p.fl_month,
            p.mkt_carrier,
            p.mkt_carrier_fl_num,
            p.origin,
            p.origin_city_name,
            p.dest,
            p.dest_city_name,
            p.dep_delay_new,
            p.arr_delay_new,
            DENSE_RANK () OVER (
                            PARTITION BY fl_month 
                            ORDER BY arr_delay_new DESC) AS ranking
    FROM flightinfo p
    WHERE p.arr_delay_new > (SELECT AVG(arr_delay_new)
                                FROM flightinfo
                            WHERE p.fl_month = fl_month)) pp --correlate month of subquery to outer query
WHERE pp.ranking < 4;





















