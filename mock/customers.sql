-- @param customer_id the ID of the customer
-- @type customer_id integer
-- @default customer_id null

-- @return mocked customer details.

SELECT * FROM (
    VALUES
        (1, 'Alice Johnson', 'alice@example.com'),
        (2, 'Bob Smith', 'bob@example.com'),
        (3, 'Charlie Rose', 'charlie@example.com')
) AS Customers (CustomerID, Name, Email)
WHERE :customer_id IS NULL OR CustomerID = :customer_id;
