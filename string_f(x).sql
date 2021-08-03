-- String manipulation: Concatenation, trim, etc.
SELECT city || ‘, ‘ || state
    AS location,
    population
    FROM population
    WHERE city = ‘Louisville’;

SELECT CONCAT(city, ‘,’, state)
    AS location,
    population
    FROM population
    WHERE city = ‘Louisville’;

SELECT CONCAT_WS(‘,’, city, state)
    AS location,
    population
    FROM population
    WHERE city = ‘Louisville’;

SELECT TRIM(‘ radar ‘);
-- ‘radar’
SELECT TRIM(‘r’ FROM ‘radar’);
-- ‘ada’
SELECT TRIM(LEADING ‘r’ FROM ‘radar’);
-- ‘adar’
SELECT TRIM(TRAILING ‘a’ FROM ‘radar’);
-- ‘rada’

SELECT LEFT(‘Pluralsight’,6);
-- ‘Plural’
SELECT RIGHT(‘Pluralsight’, 5);
-- ‘sight’

SELECT SPLIT_PART(‘USA/DC/202‘,’/’,2);
-- ‘DC’
SELECT SUBSTRING(‘USA/DC/202’,5,2);
-- ‘DC’
SELECT SUBSTRING(‘USA/DC/202’ FROM 5 FOR 2);
-- ‘DC’
    -- "FROM starting position FOR length"
SELECT SUBSTRING(‘USA/DC/202’,5);
-- ‘DC/202
    -- assumes digit is starting position

-- Change case
SELECT LOWER(name)
SELECT UPPER(name)
SELECT INITCAP(name)

-- replace and reverse characters
SELECT REPLACE(street, ‘Ave.’, ‘Avenue’)
    AS street,
    city
    FROM address;

SELECT street,
    REVERSE(city) AS city
    FROM address; 




