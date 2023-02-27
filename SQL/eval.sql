

/*************************************** EVAL SQL *************************************/

1-
-- SELECT CompanyName, ContactName, ContactTitle, Phone FROM customers
-- WHERE Country = 'France';

2-
-- SELECT ProductName, UnitPrice FROM suppliers

-- NATURAL JOIN products
-- NATURAL JOIN order_details 
-- NATURAL JOIN orders

-- WHERE CompanyName = 'Exotic Liquids';

3-
-- SELECT CompanyName, count(ProductID) FROM suppliers

-- NATURAL JOIN products 
-- WHERE Country = 'France'

-- GROUP BY CompanyName
-- ORDER BY count(ProductID) DESC;
4-
-- SELECT CompanyName, COUNT(CustomerID) FROM orders
-- NATURAL JOIN customers  
-- WHERE Country = 'France'
-- GROUP BY CompanyName
-- HAVING COUNT(CustomerID) >10;
5-
-- SELECT ShipName AS 'Client', SUM(UnitPrice*Quantity) AS 'CA', ShipCountry AS 'Pays' FROM order_details
-- NATURAL JOIN orders  
-- GROUP BY ShipName
-- HAVING SUM(UnitPrice*Quantity) >30000
-- ORDER BY CA DESC;
6-
-- SELECT customers.Country FROM customers 
-- NATURAL JOIN orders
-- NATURAL JOIN order_details
-- WHERE order_details.ProductID IN (
-- 	SELECT products.ProductID FROM products 
-- 	NATURAL JOIN suppliers 
-- 	WHERE suppliers.CompanyName = 'Exotic Liquids')

-- GROUP BY customers.Country;
7-
-- SELECT SUM(UnitPrice*Quantity) AS 'Montant ventes 97'
-- FROM order_details
-- NATURAL JOIN orders

-- WHERE YEAR(orders.OrderDate) = 1997

-- ORDER BY 'Montant ventes 97';
8-
-- SELECT MONTH(orders.OrderDate) AS 'Mois 97', SUM(UnitPrice*Quantity) AS 'Montant ventes 97'
-- FROM order_details
-- NATURAL JOIN orders

-- WHERE YEAR(orders.OrderDate) = 1997

-- GROUP BY MONTH(orders.OrderDate)

-- ORDER BY 'Mois 97';
9-
-- SELECT max(orders.OrderDate) AS 'Date de dernière commande'
-- FROM order_details
-- NATURAL JOIN orders

-- WHERE ShipName = 'Du monde entier';
10-
-- SELECT ROUND (AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Délai moyen de livraison en jours' 
-- FROM orders;