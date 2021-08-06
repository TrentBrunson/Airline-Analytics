-- window functions
    -- OVER(), PARTITION BY, ORDER BY
        -- ROW_NUMBER(), RANK(), DENSE_RANK(), 
        -- FIRST_VALUE(), LAST_VALUE(), LAG(), LEAD()

-- ROW_NUMBER() - assign row # to each row; () = entire set
SELECT
    name,
    course,
    ROW_NUMBER() OVER () AS rn
    FROM enrollees;

SELECT
    name,
    course,
    ROW_NUMBER() OVER(
        PARTITION BY name --partition ea name
        ORDER BY course) AS rn --order data by course name
    FROM enrollees;

-- RANK like ROW_NUMBER() matching rows are ranked the same
SELECT name,
        RANK() OVER (
        ORDER BY name) AS rank
    FROM enrollees;

-- DENSE_RANK() skips gaps in ranking
SELECT name,
        RANK() OVER (
        ORDER BY name) AS rank,
        DENSE_RANK() OVER (
        ORDER BY name) AS d_rank,
        ROW_NUMBER() OVER (
        ORDER BY name) AS rn
    FROM enrollees;

-- FIRST_VALUE () - return highest paid employee in each dept
SELECT dept,
    FIRST_VALUE(name) OVER (
        PARTITION BY dept
        ORDER BY salary DESC) AS high_pay
    FROM salaries;

-- return lowest paid employee in ea dept
SELECT dept,
    LAST_VALUE(name) OVER (
        PARTITION BY dept ORDER BY salary DESC
    )
        AS low_pay,
    LAST_VALUE(salary) OVER (
        PARTITION BY dept ORDER BY salary DESC
    )
        AS low_amt
    FROM salaries;
-- simplify window defintion above
SELECT dept,
        LAST_VALUE(name) OVER w AS low_pay,
        LAST_VALUE(salary) OVER w AS low_amt
    FROM salaries
    WINDOW w AS (
            PARTITION BY dept
            ORDER BY salary DESC);
 
--  LAG ()
SELECT month,
        sales AS curr_month,
        -- '1' return value from 1 row prior to current row
        LAG(monthly_sales,1) OVER (ORDER BY month) AS prev_month
    FROM sales_record
    ORDER BY month;

-- aggregate f(x) as window f(x)
SELECT grade_lvl, 
        AVG(age) AS avg_age
    FROM students
    GROUP BY grade_lvl;

-- calculate avg per group but individual rows
    -- treat aggregate f(x) as windo f(x)
SELECT grade_lvl,
        AVG(age) OVER (PARTITION BY grade_lvl) AS avg_age
    FROM students;

-- window f(x) to filter results - order of precedence is after joins/groups/having
    -- Window f(x) not in WHERE or HAVING clauses
        -- f(x) is evaluated after these clauses 
    -- Place f(x) in subquery or CTE and use as limiting criteria in outer query

-- return only rows that have row number of 1 (rn =1)
    -- put window f(x) in subquery
SELECT a.first_name,
        a.last_name
    FROM (SELECT first_name,
                    last_name,
                    ROW_NUMBER() OVER (
                        PARTITION BY dept
                        ORDER BY last_name) AS rn
            FROM students) a
    WHERE rn = 1






















