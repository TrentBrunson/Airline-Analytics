SELECT 2+2;
SELECT 12/2;
SELECT 13/2;
SELECT 13/2 :: FLOAT;

SELECT 15 % 2; -- MODULO

SELECT 12 ^ 2;
SELECT POWER (12,2);

SELECT |/ 36; --SQRT
SELECT SQRT(36);

SELECT @(36 - 40); -- ABS VALUE
SELECT ABS(36-40);

-- Average
SELECT AVG(age) AS avg_age
    FROM person;

SELECT COUNT(grade_lvl)
    FROM person;

SELECT COUNT(DISTINCT grade_lvl)
    FROM person;

SELECT grade_lvl,
		AVG(age) AS avg_age
	FROM person
	GROUP BY grade_lvl;

-- put aggregate f(x) in SELECT clause; non-aggregate go in GROUP BY clause
SELECT grade_lvl,
        MIN(age) AS minimum_age
    FROM person
    GROUP BY grade_lvl;

SELECT grade_lvl,
		AVG(age) AS avg_age
	FROM person
	GROUP BY grade_lvl;








