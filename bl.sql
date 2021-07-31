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

