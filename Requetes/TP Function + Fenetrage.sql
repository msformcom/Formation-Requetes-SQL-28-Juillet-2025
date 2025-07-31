-- Classer les employes en fonction des ventes qu'ils gèrent
-- Créer une fonction qui s'utilise comme ca :
-- SELECT * FROM CAByEmploye(5)  !=> 5 = categoryid

-- resultat pour la categorie produit
-- | empid | Nom | Prenom | Annee | CA  |

-- Données d'efficacite de mes employes 

-- pour chaque employe 
-- Rank par CA
-- Pourcentage du CA par rapport au CA Annuel
-- Difference avec l'employe au rang en dessous pour l'annee
-- Difference avec lemploye le meilleur pour l'annee
-- Difference pour un employe de CA par rapport à l'année precedente



-- Creationd e la fonction Attention aux trous sur les années
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

-- Autre façon d'obtenir les résultats mais en utilisant une sous requete et une jointure avec 
-- produit Annees et des employés
CREATE OR ALTER FUNCTION Sales.CAByEmploye(
	@CategoryId INT
) RETURNS TABLE 
AS RETURN
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


SELECT 
	T.*,
	RANK() OVER(Partition BY annee ORDER BY CA DESC) AS ClassementSurAnnee,
	CA/ SUM(CA) OVER (Partition BY annee) AS PercentCASurAnnee,
	CA - LAG(CA) OVER (Partition BY annee ORDER BY CA DESC) AS DifferenceAvecEmployePrecedent,
	CA - MAX(CA) OVER (Partition BY annee) AS differenceAvecEmployeMeilleur,
	CA - LAG(CA) OVER (partition BY empid ORDER BY Annee) AS DifferenceAvecAnneePrecedente
FROM Sales.CAByEmploye(5) T
ORDER BY Annee,CA DESC
		
		
		