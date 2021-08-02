select 2+2;

SELECT first_name, last_name
    FROM person;

SELECT first_name
    FROM students;

SELECT DISTINCT first_name
    FROM students;

SELECT first_name, last_name
    FROM person
    WHERE first_name = 'Shelby';

SELECT city,
        state,
        population
    FROM city_population
    WHERE city = 'Louisville';

SELECT city,
        state,
        population
    FROM city_population
    WHERE city = 'Louisville'
     AND state = 'KY';

SELECT first_name, last_name
    FROM person
    WHERE first_name = 'Shelby';

SELECT first_name, last_name
    FROM person
    WHERE first_name LIKE 'Shelby';

SELECT first_name,
        age
    FROM person
    WHERE age >= 19
        AND age <=35;

SELECT first_name,
        age
    FROM person
    WHERE age BETWEEN 19 and 35;

SELECT first_name,
        age
    FROM person
    WHERE first_name = 'Jimmy'
    OR first_name = 'Brenna'
    OR first_name = 'Elmo'; 

SELECT first_name,
        age
    FROM person
    WHERE first_name IN 
        ('Jimmy, Brenna, Elmo');

-- AND has higher order of precedence
SELECT first_name,
        last_name,
        hometown
    FROM person
    WHERE first_name = “Shelby”
    OR first_name = “Tom”
    AND hometown = “Boston”;

SELECT first_name,
        last_name,
        hometown
    FROM person
    WHERE (first_name = “Shelby”
    OR first_name = “Tom”)
    AND hometown = “Boston”;

SELECT customers.*,
        orders.*
    FROM customers
    JOIN orders
        ON customers.customer_id = orders.customer_id;
    
SELECT customers.first_name,
        customers.last_name,
        orders.order_date,
        orders.order_amount
    FROM customers
    INNER JOIN orders
    ON customers.customer_id = orders.customer_id;

SELECT customers.first_name,
        customers.last_name,
        orders.order_date,
        orders.order_amount
    FROM customers,
        orders
    WHERE customers.customer_id = orders.customer_id
    WHERE customers.last_name = ‘Dodd’;

SELECT c.first_name,
        c.last_name,
        o.order_date,
        o.order_amount
    FROM customers AS c
    INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
    WHERE c.last_name = ‘Dodd’;

SELECT c.first_name,
        c.last_name,
        o.order_date,
        o.order_amount
    FROM customers c
    LEFT OUTER JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT c.first_name,
        c.last_name,
        o.order_date,
        o.order_amount
    FROM customers c
    RIGHT OUTER JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT c.first_name,
        c.last_name,
        o.order_date,
        o.order_amount
    FROM customers c
    RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT c.first_name,
        c.last_name,
        o.order_date,
        o.order_amount
    FROM customers c
    FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT name,
        state
    FROM residency
    ORDER BY name;

SELECT name,
        state
    FROM residency
    ORDER BY state, name;

SELECT name,
        state
    FROM residency
    ORDER BY state DESC, name ASC;

SELECT name,
        state
    FROM residency
    ORDER BY 2 DESC, 1 ASC;

SELECT AVG(age)
    FROM person;

SELECT grade_lvl,
        AVG(age) AS avg_age
    FROM person
    GROUP BY grade_lvl;

-- All non-aggregate fields in the SELECT clause must be 
-- represented in the GROUP BY clause
SELECT grade_lvl,
        MIN(age) AS minimum_age
    FROM person
    GROUP BY grade_lvl;

-- HAVING clause specifies filtering aggregate values from AVG
SELECT grade_lvl,
        AVG(age) AS avg_age
    FROM person
    GROUP BY grade_lvl
    HAVING AVG(age) < 19;

