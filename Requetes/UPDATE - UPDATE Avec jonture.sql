-- Augmenter de 10% les prix du produit 4
UPDATE Production.Products SET unitprice=unitprice * 1.1
WHERE productid=4


-- Augmenter de 10% les produits vendus en plus de 100 exemplaires en 2008

SELECT * FROM Production.Products PP
WHERE PP.productid IN (
SELECT SOD.productid
		--SUM(qty) AS NbVentes,
		--(SELECT TOP 1 Discount FROM [AdventureWorks].dbo.Augmentations
		--	WHERE MinVente < SUM(qty)
		--	ORDER BY MinVente DESC) AS Augmentation
FROM Sales.Orders SO
	INNER JOIN Sales.OrderDetails SOD ON SOD.orderid=SO.orderid
WHERE DATEPART(year,SO.orderdate)=2008 
GROUP BY SOD.productid
HAVING SUM(qty)>100
)

SELECT 
		SOD.productid,
		SUM(qty) AS NbVentes,
		(SELECT TOP 1 Discount FROM [AdventureWorks].dbo.Augmentations
			WHERE MinVente < SUM(qty)
			ORDER BY MinVente DESC) AS Augmentation
		INTO MajProductsAFaire
FROM Sales.Orders SO
	INNER JOIN Sales.OrderDetails SOD ON SOD.orderid=SO.orderid
WHERE DATEPART(year,SO.orderdate)=2008 
GROUP BY SOD.productid


SELECT * FROM MajProductsAFaire





;WITH CalulAugmentation AS (
SELECT 
		SOD.productid,
		SUM(qty) AS NbVentes,
		(SELECT TOP 1 Discount FROM [AdventureWorks].dbo.Augmentations
			WHERE MinVente < SUM(qty)
			ORDER BY MinVente DESC) AS Augmentation
		
FROM Sales.Orders SO
	INNER JOIN Sales.OrderDetails SOD ON SOD.orderid=SO.orderid
WHERE DATEPART(year,SO.orderdate)=2008 
GROUP BY SOD.productid),
RequeteUpdate AS (
SELECT PP.* ,
		Augmentation
 FROM Production.Products PP
INNER JOIN CalulAugmentation CA
ON CA.productid = PP.productid)
--SELECT * FROM RequeteUpdate
UPDATE RequeteUpdate SET unitprice=unitprice * (1+ Augmentation)









-- 550 ventes
SELECT * FROM [AdventureWorks].dbo.Augmentations
WHERE MinVente < 550
ORDER BY MinVente DESC