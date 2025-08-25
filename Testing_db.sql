-- SQL Query for Question 1: List all suppliers in the UK.
-- This query selects all columns (*) from the dbo.SUPPLIER table
-- and filters the results to include only those suppliers where the 'Country' is 'UK'.
-- Note: 'Id' is the primary key and 'CompanyName' is the supplier name.

SELECT
    *
FROM
    dbo.Supplier
WHERE
    Country = 'UK';


-- SQL Query for Question 2: Concatenate customer first and last names.
-- This query selects the FirstName, LastName, and City from the dbo.Customer table.
-- It also creates a new column called 'Full_Name' by concatenating FirstName,
-- a space, a comma, and LastName using the CONCAT function.

SELECT
    FirstName,
    LastName,
    City,
    CONCAT(FirstName, ' ,', LastName) AS Full_Name -- Concatenates first name, space, and last name
FROM
    dbo.CUSTOMER;


-- SQL Query for Question 3: List all customers in Sweden (Updated based on ERD)
-- This query selects all columns (*) from the dbo.Customer table
-- and filters the results to include only those customers where the 'Country' is 'Sweden'.

SELECT
    *
FROM
    dbo.Customer
WHERE
    Country = 'Sweden';



-- SQL Query for Question 4: List all suppliers in alphabetical order.
-- This query selects all columns (*) from the dbo.Supplier table.
-- It then sorts the results in ascending alphabetical order based on the 'CompanyName' column.

SELECT
    *
FROM
    dbo.SUPPLIER
ORDER BY
    CompanyName ASC; -- Sorts by CompanyName (supplier name)



-- SQL Query for Question 5: List all suppliers with their products.
-- This query joins the dbo.Supplier table with the dbo.Product table
-- on their common column, 'SupplierId' (from Product) and 'Id' (from Supplier).
-- It then selects the CompanyName (supplier name) and ProductName.

SELECT
    s.CompanyName, -- Use CompanyName as per ERD
    p.ProductName
FROM
    dbo.Supplier AS s -- Alias dbo.SUPPLIER as 's'
INNER JOIN
    dbo.Product AS p ON s.Id = p.SupplierId; -- Join SUPPLIER.Id with PRODUCT.SupplierId



-- SQL Query for Question 6: List all orders with customer information.
-- This query joins the dbo.Order table with the dbo.Customer table
-- on their common column, 'CustomerId' (from Order) and 'Id' (from Customer).
-- It selects the Order.Id, OrderDate, and relevant customer details.

SELECT
    o.Id AS OrderId, -- Use Id from ORDER table
    o.OrderDate,
    c.FirstName,
    c.LastName,
    c.City,
    c.Country
FROM
	[Testing].[dbo].[Order] As o -- Alias dbo.Order as 'o'
INNER JOIN
    dbo.Customer AS c ON o.CustomerId = c.Id; -- Join ORDER.CustomerId with CUSTOMER.Id



-- SQL Query for Question 7: List all orders with product name, quantity, and price, sorted by order number.
-- This query joins dbo.Order, dbo.Orderltem, and dbo.Product.
-- It uses Orderltem.UnitPrice for calculations, as per the ERD.
-- Results are sorted by Order.Id.

SELECT
    o.Id AS OrderId, -- Use Id from ORDER table
    o.OrderDate,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice, -- Use UnitPrice from ORDERITEM table as per ERD
    (oi.Quantity * oi.UnitPrice) AS LineTotal -- Calculate total for each item using ORDERITEM.UnitPrice
FROM
    [Testing].[dbo].[Order] As o
INNER JOIN
    dbo.OrderItem AS oi ON o.Id = oi.OrderId -- Join ORDER.Id with ORDERITEM.OrderId
INNER JOIN
    dbo.Product AS p ON oi.ProductId = p.Id -- Join ORDERITEM.ProductId with PRODUCT.Id
ORDER BY
    o.Id ASC;




-- SQL Query for Question 8: List product availability using a CASE statement.
-- This query selects ProductName and uses a CASE statement based on the 'IsDiscontinued' column.
-- If 'IsDiscontinued' is 1 (or TRUE), the product is 'Not Available'. Otherwise, it's 'Available'.

SELECT
    ProductName,
    IsDiscontinued, -- Including IsDiscontinued to show the value being checked
    CASE
        WHEN IsDiscontinued = 1 THEN 'Not Available' -- Assuming 1 means discontinued
        ELSE 'Available'
    END AS ProductAvailability
FROM
    dbo.Product;





-- SQL Query for Question 9: List suppliers and their language based on country using CASE.
-- This query selects CompanyName (supplier name) and Country, then uses a CASE statement
-- to assign a language based on the supplier's country.

SELECT
    CompanyName, -- Use CompanyName as per ERD
    Country,
    CASE
        WHEN Country = 'UK' THEN 'English'
        WHEN Country = 'USA' THEN 'English'
        WHEN Country = 'Sweden' THEN 'Swedish'
        WHEN Country = 'Germany' THEN 'German'
        WHEN Country = 'France' THEN 'French'
        WHEN Country = 'Spain' THEN 'Spanish'
		WHEN Country = 'Japan' THEN 'Japanese'
		WHEN Country = 'Australia' THEN 'English'
        ELSE 'Other Language'
    END AS SpokenLanguage
FROM
    dbo.Supplier;




-- SQL Query for Question 10: List all products that are packaged in Jars.
-- This query selects all columns (*) from the dbo.Product table
-- and filters the results to include only those products where the 'Package' is 'Jars'.

Select * FROM dbo.Product
Where Package LIKE '%jars'; -- %jars means "any characters before the word 'jars'".





-- Question 11
--List products name, unitprice and packages for products that starts with Ca

select
	ProductName,
	UnitPrice,
	Package

FROM dbo.Product

Where ProductName LIKE 'Ca%';




-- SQL Query for Question 12: List the number of products for each supplier, sorted high to low.
-- This query joins the dbo.Supplier table with the dbo.Product table
-- on their common column, 'SupplierId' (from Product) and 'Id' (from Supplier).
-- It then groups the results by Supplier's Id and CompanyName, and counts the number of products
-- associated with each supplier using COUNT(p.Id).
-- Finally, it sorts the results in descending order based on the product count.

SELECT
    s.CompanyName,                            -- Select the supplier's company name
    COUNT(p.Id) AS NumberOfProducts           -- Count the number of products for each supplier
FROM
    dbo.Supplier AS s                         -- Alias dbo.SUPPLIER as 's'
INNER JOIN
    dbo.Product AS p ON s.Id = p.SupplierId   -- Join SUPPLIER.Id with PRODUCT.SupplierId
GROUP BY
    s.Id, s.CompanyName                       -- Group by supplier ID and name to aggregate products per supplier
ORDER BY
    NumberOfProducts DESC;                    -- Sort from the highest number of products to the lowest






-- SQL Query for Question 13: List the number of customers in each country
-- This query groups the dbo.Customer table by the 'Country' column
-- and counts the total number of customers in each distinct country using COUNT(Id).

SELECT
    Country,
    COUNT(Id) AS Number_Of_Customers  -- Count the number of customers in each country
FROM
    dbo.Customer
GROUP BY
    Country;                          -- Group the results by country





-- SQL Query for Question 14: List the number of customers in each country, sorted high to low
-- This query first groups the dbo.CUSTOMER table by 'Country' and counts the customers.
-- Then, it sorts the results in descending order based on the 'NumberOfCustomers' count,
-- showing countries with more customers first.

SELECT
    Country,
    COUNT(Id) AS Number_Of_Customers                    -- Count the number of customers in each country
FROM
    dbo.Customer
GROUP BY
    Country
ORDER BY
    Number_Of_Customers DESC;                           -- Sort from the highest number of customers to the lowest





-- SQL Query for Question 15: List the total order amount for each customer, sorted high to low
-- This query calculates the total sales amount for each customer by joining
-- CUSTOMER, ORDER, and ORDERITEM tables.
-- It sums the (Quantity * UnitPrice) from the ORDERITEM table for each customer.
-- The results are grouped by customer details and sorted by the total amount in descending order.

SELECT
    c.Id AS CustomerId,                                         -- Select customer ID
    c.FirstName,                                                -- Select customer first name
    c.LastName,                                                 -- Select customer last name
    SUM(oi.Quantity * oi.UnitPrice) AS Total_Order_Amount       -- Calculate the sum of (quantity * unit price) for each order item
FROM
    dbo.Customer AS c                                           -- Alias dbo.CUSTOMER as 'c'
INNER JOIN
	[Testing].[dbo].[Order] As o ON c.Id = o.CustomerId         -- Join CUSTOMER.Id with ORDER.CustomerId
                        
INNER JOIN
    dbo.OrderItem AS oi ON o.Id = oi.OrderId                    -- Join ORDER.Id with ORDERITEM.OrderId
GROUP BY
    c.Id, c.FirstName, c.LastName                               -- Group by customer ID, first name, and last name
ORDER BY
    Total_Order_Amount DESC;                                    -- Sort from the highest total order amount to the lowest





-- SQL Query for Question 16: List all countries with more than 2 suppliers
-- This query groups the dbo.Supplier table by 'Country' and counts the number of suppliers.
-- The HAVING clause then filters these groups, showing only countries
-- where the count of suppliers is greater than 2.

SELECT
    Country,
    COUNT(Id) AS Number_Of_Suppliers                           -- Count the number of suppliers in each country
FROM
    dbo.Supplier
GROUP BY
    Country
HAVING
    COUNT(Id) > 2;                                              -- Filter groups where the number of suppliers is greater than 2




-- SQL Query for Question 17: List the number of customers in each country, only include countries with more than 10 customers
-- This query groups the dbo.Customer table by 'Country' and counts the customers.
-- The HAVING clause then filters these groups, showing only countries
-- where the count of customers is greater than 10.

SELECT
    Country,
    COUNT(Id) AS Number_Of_Customers                              -- Count the number of customers in each country
FROM
    dbo.Customer
GROUP BY
    Country
HAVING
    COUNT(Id) > 10;                                               -- Filter groups where the number of customers is greater than 10




-- SQL Query for Question 18: List the number of customers in each country, except the USA,
-- sorted high to low. Only include countries with 9 or more customers.
-- This query first filters out customers from 'USA' using a WHERE clause.
-- Then, it groups the remaining customers by 'Country' and counts them.
-- The HAVING clause filters these groups to include only countries with 9 or more customers.
-- Finally, the results are sorted in descending order by the customer count.

SELECT
    Country,
    COUNT(Id) AS Number_Of_Customers                    -- Count the number of customers in each country
FROM
    dbo.Customer
WHERE
    Country <> 'USA'                                    -- Exclude customers from the USA (filters rows before grouping)
GROUP BY
    Country
HAVING
    COUNT(Id) >= 9                                      -- Only include countries with 9 or more customers (filters groups after grouping)
ORDER BY
    Number_Of_Customers DESC;                           -- Sort from the highest number of customers to the lowest





-- SQL Query for Question 19: List customers with average orders between $1000 and $1200
-- This query calculates the average order amount for each customer.
-- It joins CUSTOMER, ORDER, and ORDERITEM tables.
-- The average is calculated based on (Quantity * UnitPrice) from the Orderltem table.
-- Results are grouped by customer details, and the HAVING clause filters for customers
-- whose average order amount falls between $1000 and $1200 (inclusive).

SELECT
    c.Id AS CustomerId,                                   -- Select customer ID
    c.FirstName,                                          -- Select customer first name
    c.LastName,                                           -- Select customer last name
    AVG(oi.Quantity * oi.UnitPrice) AS Average_Order_Amount -- Calculate the average of (quantity * unit price) for each customer's orders
FROM
    dbo.Customer AS c
INNER JOIN
	[Testing].[dbo].[Order] As o ON c.Id = o.CustomerId -- Join CUSTOMER.Id with ORDER.CustomerId
INNER JOIN
    dbo.OrderItem AS oi ON o.Id = oi.OrderId -- Join ORDER.Id with ORDERITEM.OrderId
GROUP BY
    c.Id, c.FirstName, c.LastName -- Group by customer ID, first name, and last name
HAVING
    AVG(oi.Quantity * oi.UnitPrice) BETWEEN 1000 AND 1200; -- Filter groups where the average order amount is between $1000 and $1200





-- SQL Query for Question 20: Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013
-- This query first filters orders by the 'OrderDate' to include only January 2013.
-- It then calculates the total number of distinct orders (using ORDER.Id) and the total sales amount
-- for that period by joining dbo.Order and dbo.Orderltem.

SELECT
    COUNT(DISTINCT o.Id) AS Number_Of_Orders,                -- Count the number of unique orders within the date range
    SUM(oi.Quantity * oi.UnitPrice) AS Total_Amount_Sold     -- Calculate the total sales amount by summing (quantity * unit price) from order items
FROM
	[Testing].[dbo].[Order] As o 
    
INNER JOIN
    dbo.OrderItem AS oi ON o.Id = oi.OrderId                -- Join ORDER.Id with ORDERITEM.OrderId
WHERE
    o.OrderDate BETWEEN '2013-01-01' AND '2013-01-31';      -- Filter orders within the specified date range




-- THE END.

