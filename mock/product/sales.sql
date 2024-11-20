-- @param product_id the ID of the product
-- @type product_id integer
-- @default product_id null

-- @return mocked product sales information.

SELECT Products.ProductName, SUM(Orders.Quantity * Products.Price) AS TotalSales
FROM (
    VALUES
        (1, 'Laptop', 1200.00),
        (2, 'Smartphone', 800.00),
        (3, 'Tablet', 400.00)
) AS Products (ProductID, ProductName, Price)
INNER JOIN (
    VALUES
        (1, 1, 2),  -- CustomerID, ProductID, Quantity
        (2, 2, 1),
        (3, 1, 1),
        (1, 3, 5)
) AS Orders (CustomerID, ProductID, Quantity)
    ON Products.ProductID = Orders.ProductID
WHERE (:product_id IS NULL OR Products.ProductID = :product_id)
GROUP BY Products.ProductName;
