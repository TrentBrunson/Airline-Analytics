-- Common table expressions
WITH freshmen AS (
SELECT a.student_id,
        a.student_name,
        b.hours_completed
    FROM students a
INNER JOIN credit_hours b
    ON a.student_id = b.student_id
    WHERE b.hours_completed < 30);








































