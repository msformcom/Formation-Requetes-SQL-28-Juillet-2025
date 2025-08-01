-- CREER UNE SELECTION des produits avec la moyenne des discount

-- | productid | MoyenneDiscount |

-- discount 0.1 => unitprice *(1-discount/2) => unitprice * 0.95
BEGIN TRAN
-- Utiliser cette selection pour diminuer le prix du produit => 1/2 de la discount moyenne
;WITH Discounts AS (
SELECT productid AS ProductId,
		AVG(discount) AS AverageDiscount
FROM Sales.OrderDetails
GROUP BY productid),
SelectionAModifier AS (
SELECT PP.*,
		D.AverageDiscount,
		unitprice *(1-AverageDiscount/2) AS NewUnitPrice
FROM Production.Products PP -- Données des produits 
INNER JOIN Discounts D ON D.ProductId=pp.productid)
--SELECT * FROM SelectionAModifier
UPDATE  SelectionAModifier
SET unitprice=NewUnitPrice


SELECT * FROM Production.Products

ROLLBACK