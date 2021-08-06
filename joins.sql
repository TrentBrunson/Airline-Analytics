-- see everthing if a customer has placed an order
SELECT customers.*, orders.*
    FROM customers
INNER JOIN orders
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
    FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
    WHERE customers.last_name = ‘Dodd’;

-- postgres assumes INNER JOIN
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;

FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id;

FROM customers,
        orders
WHERE customers.customer_id = orders.customer_id

SELECT c.first_name,
    c.last_name,
    o.order_date,
    o.order_amount
    FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
    -- alternatively USING (customer_id) if both fields share identical name
    WHERE c.last_name = ‘Dodd’;

SELECT c.first_name,
    c.last_name,
    o.order_date,
    o.order_amount
    FROM customers c
LEFT OUTER JOIN orders o
    USING (customer_id);

SELECT c.first_name,
    c.last_name,
    o.order_date,
    o.order_amount
    FROM customers c
RIGHT OUTER JOIN orders o
    USING (customer_id);

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
















