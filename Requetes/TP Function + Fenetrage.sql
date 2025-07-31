-- Creationd e la fonctioo
CREATE OR ALTER FUNCTION Sales.CAByEmploye(
	@CategoryId INT
) RETURNS TABLE 
AS RETURN
WITH SelectionLignes AS (
	SELECT  
			SO.empid AS empid,
			(SOD.qty * SOD.unitprice) AS Montant,
			DATEPART(YEAR,SO.orderdate) AS Annee 
	FROM  [Sales].[Orders] SO 
	INNER JOIN [Sales].[OrderDetails] SOD
		ON SOD.orderid = SO.orderid
	INNER JOIN [Production].[Products] PP
		ON PP.productid = SOD.productid
	WHERE PP.categoryid = @Categoryid
)
--SELECT * FROM SelectionLignes
, Regroupement AS (
	SELECT Empid,
			Annee, 
			SUM(Montant) AS CA FROM SelectionLignes
	GROUP BY Empid,Annee
)
--SELECT * FROM Regroupement
, AvecInfosEmployes AS (
	SELECT
		HRE.firstname AS Prenom,
		HRE.lastname AS Nom, 
		R.* 
	FROM Regroupement R
	INNER JOIN HR.Employees HRE ON R.empid = HRE.empid
)
SELECT * FROM AvecInfosEmployes
		
SELECT * FROM Sales.CAByEmploye(5)

-- Autre façon d'obtenir les résultats mais en utilisant une sous requete
DECLARE @categoryid INT =5
SELECT	Annees.annee, 
		Annees.complete, 
		HRE.empid, 
		firstname,
		lastname
		,
		-- Calcul du CA généré par l'employe pour l'annéé poru la catégorie
		ISNULL((SELECT SUM(qty*SOD.unitprice)
			FROM Sales.Orders SO 
			INNER JOIN Sales.OrderDetails SOD ON SOD.orderid=SO.orderid
			INNER JOIN Production.Products PP ON PP.productid=SOD.productid
			WHERE YEAR(SO.orderdate)=Annees.annee AND categoryid=@categoryid AND empid=HRE.empid),0) AS CA
FROM HR.Employees AS HRE, (VALUES(2006,0),(2007,1),(2008,0)) Annees(Annee,complete)
ORDER BY Annee,empid

-- Calculer le CA pour un employe 1 pour l'annee 2006 pour la categorie 3
SELECT SUM(qty*SOD.unitprice)
FROM Sales.Orders SO 
INNER JOIN Sales.OrderDetails SOD ON SOD.orderid=SO.orderid
INNER JOIN Production.Products PP ON PP.productid=SOD.productid
WHERE YEAR(SO.orderdate)=2006 AND categoryid=3 AND empid=1


SELECT * FROM Sales.CAByEmploye(5)
		
		
		