-- sub-queries
SELECT a.store_name,
        a.store_location
    FROM stores a
    WHERE a.store_name IN
        (SELECT store_name
            FROM orders
            WHERE order_value > 500);

-- next 2 same results; performance differences
SELECT a.store_name,
        a.store_location
    FROM stores a
    WHERE a.store_name IN
        (SELECT store_name
            FROM orders
            WHERE order_value > 500);

SELECT a.store_name,
        a.store_location
    FROM stores a
INNER JOIN orders b
    ON a.store_name = b.store_name
    WHERE b.order_value > 500;

-- calc avg value for orders in order table
-- non-correlated subquery
SELECT a.store_name,
        a.order_id
    FROM orders a
    WHERE a.order_value >
        (SELECT AVG(order_value)
            FROM orders);

-- Correlated subquery; take from outer query
    -- subquery evaluated for each row processed by the outer query

SELECT a.trans_id,
        b.first_name,
        b.last_name,
        a.amount
    FROM transactions a
INNER JOIN customers b
    ON a.cust_id = b.cust_id
    WHERE a.amount >
        (SELECT AVG(amount)
            FROM transactions aa
            WHERE a.cust_id = aa.cust_id)
    ORDER BY a.trans_id;
        -- subquery finds avg
        -- outer query retrieves name & transactions
        -- WHERE clause limits results to > specified amount



























