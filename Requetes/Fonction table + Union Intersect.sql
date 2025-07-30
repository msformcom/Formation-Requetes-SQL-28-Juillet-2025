SELECT * FROM dbo.CaParAnneeMois

SELECT n FROM [dbo].[Nums] WHERE n BETWEEN 1 AND 12



CREATE SCHEMA Helpers
GO 


CREATE OR ALTER FUNCTION Helpers.Range(
	@Debut INT,
	@Fin INT
) RETURNS TABLE AS RETURN 
SELECT n FROM [dbo].[Nums] WHERE n BETWEEN 1 AND 12

SELECT * FROM Helpers.Range(1,12)

-- Créer une fonction qui donne les 10 produits les moins vendus (quantite) sur une annee donnée
SELECT * FROM Sales.ProduitsLesMoinsVendus(2007)

SELECT * FROM Sales.Orders
ORDER BY orderid
OFFSET 0 ROWS -- Décalage de la sélection, on ne prend pas les premieres lignes
FETCH NEXT 10 ROWS ONLY; -- Limite la selection aux 10 lignes suivantes

CREATE OR ALTER FUNCTION Sales.ProduitsLesMoinsVendus
( 
 @Annee INT
 ) RETURNS TABLE AS RETURN
WITH 
Lignes AS (SELECT 
					OD.productid,
					Qty AS Qty
					FROM Sales.OrderDetails OD 
					INNER JOIN Sales.Orders O ON OD.orderid=O.orderid
					WHERE DATEPART(year,orderdate)=@Annee),
LignesGroupees AS (
SELECT productid, 
		SUM(qty) AS qty FROM Lignes
GROUP BY productid)
SELECT P.productid,
		productname,
		ISNULL(qty,0) AS Qty
FROM LignesGroupees LG RIGHT JOIN Production.Products P ON LG.productid=P.productid
ORDER BY qty ASC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY


SELECT COALESCE(MV2006.productid, MV2007.productid) AS productid,
		COALESCE( MV2006.productname,  MV2007.productname) AS productname,
	MV2006.qty AS QTY2006 , MV2007.qty AS QTY2007
 FROM Sales.ProduitsLesMoinsVendus(2006) MV2006 
				FULL JOIN  Sales.ProduitsLesMoinsVendus(2007) MV2007
				ON MV2006.productid = MV2007.productid

SELECT productid, productname FROM  Sales.ProduitsLesMoinsVendus(2006) 
EXCEPT -- UNION,  UNION ALL, INTERSECT
SELECT productid, productname FROM  Sales.ProduitsLesMoinsVendus(2007) 

