# RAW Mock Data API Template

## Table of Contents

1. [Introduction](#introduction)
   - [Description](#description)
   - [How It Works](#how-it-works)
   - [Features](#features)
2. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Setup Instructions](#setup-instructions)
3. [Domain Entities](#domain-entities)
   - [Entities Overview](#entities-overview)
   - [Entity Relationships](#entity-relationships)
4. [Endpoint Overview](#endpoint-overview)
   - [Available Endpoints](#available-endpoints)
   - [Endpoint Details](#endpoint-details)
5. [Query Structure](#query-structure)
   - [Basic Structure of SQL Files](#basic-structure-of-sql-files)
   - [Using Variables](#using-variables)
6. [Customization](#customization)
7. [Example SQL Queries](#example-sql-queries)
8. [Final Remarks](#final-remarks)
9. [Support and Troubleshooting](#support-and-troubleshooting)
10. [License](#license)
11. [Acknowledgements](#acknowledgements)
12. [Contact](#contact)
13. [Additional Resources](#additional-resources)

---

## Introduction

### Description

This repository provides a **Mock Data API Template** using the RAW platform. It demonstrates how to create API endpoints that return hardcoded (mock) data using SQL queries. This template is ideal for testing, prototyping, or educational purposes where actual database connections are not required.

### How It Works

The RAW platform allows you to create APIs by writing SQL queries. In this template, we use the `VALUES` clause in SQL to create inline tables with hardcoded data. The endpoints accept query parameters, which are injected into the SQL queries using the `:<variable_name>` notation, as per the RAW platform's convention.

### Features

- **Mock Data Generation**: Provides hardcoded data without the need for a database.
- **Dynamic Querying**: Supports query parameters to filter and retrieve specific data.
- **Quick Setup**: Easy to deploy and test endpoints without complex configurations.
- **Template Structure**: Offers a foundation to build and customize your own APIs.

## Getting Started

### Prerequisites

- **RAW Account**:
  - An active RAW account. [Sign up here](https://app.raw-labs.com/register) if you don't have one.
- **Permissions**:
  - **RAW**:
    - Admin role in your RAW account.
- **Dependencies**:
  - Web browser to access the RAW platform.
  - Internet connectivity.

### Setup Instructions

1. **Clone the Repository**:
   - Import this repository into your RAW workspace.

2. **Review OpenAPI Specification**:
   - Examine the provided OpenAPI specification to understand the available endpoints.

3. **Review SQL Files**:
   - Each endpoint corresponds to an SQL file containing the query logic.
   - The SQL files use the `:<variable_name>` notation for parameters.

4. **Deploy APIs in RAW**:
   - Use the RAW platform to publish the SQL queries as APIs.
   - Refer to the [Publishing APIs documentation](https://docs.raw-labs.com/docs/publishing-api/overview) for guidance.

5. **Test Your APIs**:
   - Use RAW's testing tools or tools like Postman to test your APIs.
   - Provide query parameters as needed to test different scenarios.

## Domain Entities

### Entities Overview

The template focuses on a simple sales system with the following entities:

- **Customer**: Individuals who purchase products.
- **Product**: Items available for sale.
- **Order**: Records of products purchased by customers.

### Entity Relationships

- **Customer to Order**: One-to-many relationship (a customer can have multiple orders).
- **Order to Product**: Many-to-one relationship (each order is associated with a product).

---

**Note**: Since the data is mocked using hardcoded values, the relationships are simulated within the SQL queries.

## Endpoint Overview

### Available Endpoints

1. **GET `/mock/customers`**: Retrieve customer details.
2. **GET `/mock/customers/orders`**: Retrieve orders for a customer.
3. **GET `/mock/products/sales`**: Retrieve sales information for products.

### Endpoint Details

#### 1. GET `/mock/customers`

- **Description**: Returns customer information based on the provided `customer_id`. If no ID is provided, returns information for all customers.
- **Query Parameters**:
  - `customer_id` (integer, optional): The ID of the customer.

#### 2. GET `/mock/customers/orders`

- **Description**: Returns mocked customer orders for a given `customer_id`, including order ID, product name, quantity, and price.
- **Query Parameters**:
  - `customer_id` (integer, optional): The ID of the customer.

#### 3. GET `/mock/products/sales`

- **Description**: Returns sales information for products. If a `product_id` is provided, returns sales for that specific product.
- **Query Parameters**:
  - `product_id` (integer, optional): The ID of the product.

## Query Structure

### Basic Structure of SQL Files

- **Parameters**: Defined at the top of each file using comments in the RAW format.
- **Mock Data**: Created using the `VALUES` clause to simulate tables.
- **Variable Injection**: Parameters are injected into the SQL queries using `:<variable_name>`.
- **Conditional Logic**: SQL `WHERE` clauses use parameters to filter data.

**Example Parameter Declaration**:

```sql
-- @param customer_id the ID of the customer
-- @type customer_id integer
-- @default customer_id null
```

### Using Variables

Variables are used within the SQL queries to filter data based on the provided parameters.

**Example Usage**:

```sql
WHERE :customer_id IS NULL OR CustomerID = :customer_id;
```

- If `:customer_id` is `NULL`, the condition is ignored, and all records are returned.
- If `:customer_id` has a value, the query filters records where `CustomerID` matches the provided ID.

## Customization

This mock data API template is designed to be easily customizable:

- **Modify SQL Queries**: Adjust the hardcoded data in the `VALUES` clause to fit your use case.
- **Add New Endpoints**: Create new SQL files and define corresponding endpoints in the OpenAPI specification.
- **Change Parameters**: Add or modify parameters to support additional filters or data retrieval options.
- **Integrate with Real Backend Systems**: Replace the mock data with queries against actual backend systems, if needed.

---

## Example SQL Queries

### 1. GET `/mock/customers`

```sql
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
```

### 2. GET `/mock/customers/orders`

```sql
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
WHERE :customer_id IS NULL OR Orders.CustomerID = :customer_id;
```

### 3. GET `/mock/products/sales`

```sql
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
WHERE :product_id IS NULL OR Products.ProductID = :product_id
GROUP BY Products.ProductName;
```

---

## Final Remarks

This template serves as a starting point for building mock APIs using the RAW platform. It's ideal for:

- **Testing**: Quickly test API integrations without needing a live database.
- **Prototyping**: Develop API structures and logic before connecting to actual data sources.
- **Education**: Learn how to construct APIs and SQL queries within the RAW platform.

Feel free to customize and expand upon this template to suit your specific needs.

---

## Support and Troubleshooting

- **Documentation**:
  - Refer to the [RAW Documentation](https://docs.raw-labs.com/docs/) for detailed guides.
    - [Using Data Sources](https://docs.raw-labs.com/docs/sql/data-sources/overview)
    - [Publishing APIs](https://docs.raw-labs.com/docs/publishing-api/overview)
  - **Note**: Since this template uses mock data, connections to external data sources are not required.

- **Community Forum**:
  - Join the discussion on our [Community Forum](https://www.raw-labs.com/community).

- **Contact Support**:
  - Email us at [support@raw-labs.com](mailto:support@raw-labs.com) for assistance.

## License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- **Contributors**: Thanks to all our contributors for their efforts.
- **RAW Platform**: This template demonstrates the capabilities of the RAW platform in creating mock APIs.

## Contact

- **Email**: [support@raw-labs.com](mailto:support@raw-labs.com)
- **Website**: [https://raw-labs.com](https://raw-labs.com)
- **Twitter**: [@RAWLabs](https://twitter.com/raw_labs)
- **Community Forum**: [Forum](https://www.raw-labs.com/community)

---

## Additional Resources

- **RAW Documentation**: Comprehensive guides and references are available at [docs.raw-labs.com](https://docs.raw-labs.com/).
- **Publishing APIs**: Learn how to publish your SQL queries as APIs [here](https://docs.raw-labs.com/docs/publishing-api/overview).
- **SQL Language**: Explore RAW's SQL language for data manipulation [here](https://docs.raw-labs.com/sql/overview).
- **SNAPI Language**: Explore RAW's custom language for data manipulation [here](https://docs.raw-labs.com/snapi/overview).

---

**Note**: I have corrected the README to remove references to Databricks, as this mock data API template does not utilize Databricks. The "Support and Troubleshooting," "Acknowledgements," and "Additional Resources" sections have been updated accordingly. Additionally, I've included the table of contents for easy navigation.

Please let me know if you need any further adjustments.
