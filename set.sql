-- SET THEORY: UNION (no dupes)/UNION ALL (includes dupes), INTERSECT, EXCEPT
-- UNIONS
SELECT ‘Active’ AS status, curr.*
    FROM customers_current curr
UNION
SELECT ‘Inactive’ AS status, old.*
    FROM customers_archive old
    ORDER BY last_name;

SELECT curr.*
    FROM customers_current curr
UNION
SELECT old.*
    FROM customers_archive old
    ORDER BY 1;

SELECT curr.*
    FROM customers_current curr
UNION ALL
SELECT old.*
    FROM customers_archive old
    ORDER BY 1;

-- INTERSECTIONS; INTERSECT returns distinct rows; INTERSET ALL returns all rows
SELECT curr.*
    FROM customers_current curr
INTERSECT
SELECT old.*
    FROM customers_archive old
    ORDER BY last_name;

-- EXECPTIONS; returns results in top (left) result set
    SELECT curr.*
        FROM customers_current curr
EXCEPT
    SELECT old.*
        FROM customers_archive old
ORDER BY last_name; -- applies to combined result set
































