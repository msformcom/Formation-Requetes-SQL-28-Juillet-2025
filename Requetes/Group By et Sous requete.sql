-- Nombre de commandes, nombre de clients différents pour chaque annee, trimestre et mois
-- | Annee | Trimestre | Mois | NbCommande | NbClient
SELECT * FROM 
						(SELECT DATEPART(year,orderdate) AS Annee,
						DATEPART(quarter,orderdate) AS Trimestre,
						DATEPART(month,orderdate) AS Mois,
						COUNT(orderid) AS NB_Commandes,
						COUNT(DISTINCT custid) AS NB_Clients
						 FROM Sales.orders
						GROUP BY DATEPART(year,orderdate),
						DATEPART(quarter,orderdate),
						DATEPART(month,orderdate)
						WITH CUBE) AS Stats
WHERE Annee=2006 AND Mois is null

SELECT  Annee,Trimestre, Mois,
COUNT(orderid) AS NB_Commandes,
COUNT(DISTINCT custid) AS NB_Clients
FROM 
					-- Je commence par calculer les données des regroupements
					(SELECT DATEPART(year,orderdate) AS Annee,
					DATEPART(quarter,orderdate) AS Trimestre,
					DATEPART(month,orderdate) AS Mois,
					orderid,
					custid
					FROM  Sales.orders) AS Preselection
GROUP BY Annee,Trimestre, Mois