# RAW Mock API Template

## Introduction

This repository provides a **Mock API Template** using the RAW platform. It demonstrates how to create API endpoints that return hardcoded (mock) data using SQL queries. This template is ideal for testing, prototyping, or educational purposes where actual database connections are not required.

### How It Works

The RAW platform allows you to create APIs by writing SQL queries. In this template, we use the `VALUES` clause in SQL to create inline tables with hardcoded data. The endpoints accept query parameters, which are injected into the SQL queries using the `:<variable_name>` notation, as per the RAW platform's convention.

### Features

- **Mock Data Generation**: Provides hardcoded data without the need for a database.
- **Query Parameters**: Supports query parameters to filter and retrieve specific data.
- **Quick Setup**: Easy to deploy and test endpoints without complex configurations.
- **Template Structure**: Offers a foundation to build and customize your own APIs.

## Getting Started

1. **Deploy the API:**
   - Visit the [Mock API Starter](https://www.raw-labs.com/templates/mock-api-starter) page.
   - Click the **"Get Started"** button to deploy the template.
   - If you don’t have a RAW account, you’ll be prompted to create one for free. Deployment and account setup are seamless—just one click away!

2. **Explore the API:**
   - Access your API immediately inside the RAW application.
   - View endpoint details and invoke them directly to see how they function.

3. **Customize as Needed:**
   - Modify the API to suit your requirements.
   - Once you’re satisfied, re-publish the changes to make your new API available instantly.

## Overview

The template focuses on a simple sales system with the following domain entities:

- **Customer**: Individuals who purchase products.
- **Product**: Items available for sale.
- **Order**: Records of products purchased by customers.

The entity relationships are the following:

- **Customer to Order**: One-to-many relationship (a customer can have multiple orders).
- **Order to Product**: Many-to-one relationship (each order is associated with a product).

**Note**: Since the data is mocked using hardcoded values, the relationships are simulated within the SQL queries.

## Endpoints

### GET `/mock/customers`

- **Description**: Returns customer information based on the provided `customer_id`. If no ID is provided, returns information for all customers.
- **Query Parameters**:
  - `customer_id` (integer, optional): The ID of the customer.
- Source code at [/mock/customers.sql](/mock/customers.sql) and endpoint definition at [/mock/customers.yml](/mock/customers.yml).

### GET `/mock/customers/orders`

- **Description**: Returns mocked customer orders for a given `customer_id`, including order ID, product name, quantity, and price.
- **Query Parameters**:
  - `customer_id` (integer, optional): The ID of the customer.
- Source code at [/mock/customers.sql](/mock/customers/orders.sql) and endpoint definition at [/mock/customers.yml](/mock/customers/orders.yml).

### GET `/mock/products/sales`

- **Description**: Returns sales information for products. If a `product_id` is provided, returns sales for that specific product.
- **Query Parameters**:
  - `product_id` (integer, optional): The ID of the product.
- Source code at [/mock/products/sales.sql](/mock/products/sales.sql) and endpoint definition at [/mock/products/sales.yml](/mock/products/sales.yml).

## Short Intro to RAW APIs

In RAW, APIs consist of two parts: a YAML file for endpoint configuration and a SQL file for the query logic. The YAML file path defines the API’s endpoint. For example, /inventory/stock.yaml corresponds to the API path /inventory/stock.

SQL queries can include dynamic parameters using the `:<variable_name>` syntax. For instance:
```sql
WHERE CustomerID = :customer_id
```
Here, `:customer_id` becomes a query parameter, accessible via the API as `?customer_id=<value>`.

To document parameters, enforce types or default values, add metadata at the top of the SQL file as in:
```sql
-- @param customer_id the ID of the customer  
-- @type customer_id integer  
-- @default customer_id null
```

## Next Steps

Visit the [Mock API Starter](https://www.raw-labs.com/templates/mock-api-starter) page, deploy this template and get started using RAW.

When you create your RAW account, you will be able to view and run these endpoints in the RAW catalog, as well as quickly modify these endpoints or create new ones in the RAW workspace, in our easy-to-use web IDE.

## License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for details.

## Contact

- **Website**: [www.raw-labs.com](https://www.raw-labs.com)
- **Twitter**: [@raw_labs](https://twitter.com/raw_labs)
- **Contact Support**: Email us at [support@raw-labs.com](mailto:support@raw-labs.com) for assistance
- **Community Forum**: Join the discussion on our [Community Forum](https://www.raw-labs.com/community)

For more information, visit our [documentation](https://docs.raw-labs.com).
