-- Common table expressions
WITH freshmen AS (
SELECT a.student_id,
        a.student_name,
        b.hours_completed
    FROM students a
INNER JOIN credit_hours b
    ON a.student_id = b.student_id
    WHERE b.hours_completed < 30);

-- define CTE before query statement
-- get students w/ <30 credit hours & call them freshmen
WITH freshmen AS (
SELECT a.student_id,
        a.student_name,
        b.hours_completed
    FROM students a
INNER JOIN credit_hours b
    ON a.student_id = b.student_id
    WHERE b.hours_completed < 30)
-- Use CTE
SELECT student_id,
        student_name
FROM freshmen;

-- CTE to find transactions avg transaction amount grouped by customer
WITH AvgAmount AS (
    SELECT cust_id,
            AVG(amount) AS avg_amount
        FROM transactions
        GROUP BY cust_id)
    SELECT a.trans_id,
            b.first_name, 
            b.last_name,
            a.amount
        FROM transactions a
    INNER JOIN customers b
        ON a.cust_id = b.cust_id
    INNER JOIN AvgAmount c
        ON a.cust_id = c.cust_id
        WHERE a.amount > c.avg_amount;

-- recursive CTE
WITH RECURSIVE series (list_num) AS (
    SELECT 5
    UNION ALL
    -- recrusive clause
    SELECT list_num + 5 FROM series
    WHERE list_num + 5 <= 50)
SELECT list_num FROM series;

WITH RECURSIVE series (list_num) AS (
    SELECT 5
    UNION ALL
    SELECT list_num + 5
    FROM series
    WHERE list_num + 5 <= 50)
SELECT list_num FROM series;






