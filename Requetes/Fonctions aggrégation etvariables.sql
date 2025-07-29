-- Moyenne des prix produit
DECLARE @MoyennePrix MONEY = (SELECT AVG(unitprice)
FROM Production.Products)

SELECT * 
FROM Production.products 
WHERE unitprice >= @MoyennePrix

SELECT * 
FROM Production.products 
WHERE unitprice >= (SELECT AVG(unitprice) -- sous requete
FROM Production.Products)

-- nombre de clients qui ont commande quelque chose en 2006
SELECT COUNT( DISTINCT [custid])  FROM [Sales].[Orders]
WHERE Datepart(year,orderdate)=2006

-- quantité vendue
-- chiffre d'affaire généré
-- total en valeur de la réduction faite dans les ventes
-- total en % de la reduction
-- produit avec id =4 commandes au troisieme trimestre 2006
SELECT *,
	ReductionEnValeur/CAGenere AS ReductionPercent
FROM 
(SELECT 
	SUM(qty) AS QuantiteVendue,
	SUM(unitprice*qty) AS CAGenere,
	SUM(unitprice*qty*discount) AS ReductionEnValeur

FROM [Sales].[OrderDetails]
WHERE productid=4) AS PreCalcul

-- Tous les produits dans la categorie du produit id = 4

SELECT * FROM Production.Products
WHERE CategoryId=(SELECT categoryid FROM Production.Products WHERE productid=4)

DECLARE @CategoryId INT=(SELECT categoryid FROM Production.Products WHERE productid=4)

SELECT * FROM Production.Products
WHERE CategoryId=@CategoryId


