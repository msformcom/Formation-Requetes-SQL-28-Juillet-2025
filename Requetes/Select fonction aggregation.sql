-- Moyenne des prix des produits

SELECT AVG(unitprice) AS Moyenne_Prix,
		COUNT(*) AS NombreProduits
 FROM [Production].[Products]

 -- Nombre de commandes
 --Moyenne (h) du temps de livraison
 -- Somme des frais de livraison

 -- Nombre de commandes non livrées


 SELECT COUNT(*) AS NB_Commandes, -- Nombre d'enregistrements
		AVG(DATEDIFF(hour,[orderdate],[shippeddate])) AS Temps_Envoi,
		SUM([freight]) AS Somme_Livraison,
		COUNT(*)-COUNT(shippeddate) AS NbCommandesLivrees,
		SUM(CASE WHEN shippeddate IS NULL THEN 1 ELSE 0 END) AS NbCommandesLivrees
 FROM [Sales].[Orders]
