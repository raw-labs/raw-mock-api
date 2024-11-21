-- @param customer_id the ID of the customer
-- @type customer_id integer
-- @default customer_id null

-- @return mocked customer orders.

SELECT Orders.OrderID, Products.ProductName, Orders.Quantity, Products.Price
FROM (
    VALUES
        (101, 1, 1, 2),  -- OrderID, CustomerID, ProductID, Quantity
        (102, 2, 2, 1),
        (103, 3, 1, 1),
        (104, 1, 3, 5)
) AS Orders (OrderID, CustomerID, ProductID, Quantity)
INNER JOIN (
    VALUES
        (1, 'Laptop', 1200.00),
        (2, 'Smartphone', 800.00),
        (3, 'Tablet', 400.00)
) AS Products (ProductID, ProductName, Price)
    ON Orders.ProductID = Products.ProductID
WHERE (:customer_id IS NULL OR Orders.CustomerID = :customer_id);
