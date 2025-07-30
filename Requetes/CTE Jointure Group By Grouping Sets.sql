-- par employe, pays, region => ca Généré pour les vente
-- CTE pour etapes successives
;WITH jointure AS (
	SELECT  E.empid AS Id_Employe,
			 E.firstname AS Nom_Employe,
			E.lastname AS PrenomEmploye,
			O.shipcountry AS Pays,
			ISNULL(O.shipregion,'---') AS Region,
			OD.qty*OD.unitprice AS Montant_Ligne_Commande
		 FROM [HR].[Employees] AS E
	INNER JOIN [Sales].[Orders] AS O ON O.empid=E.empid
	INNER JOIN [Sales].[OrderDetails] AS OD ON OD.orderid=O.orderid
)
SELECT Id_Employe, 
		Nom_Employe, 
		PrenomEmploye, 
		Pays, 
		Region, 
		SUM(Montant_Ligne_Commande) AS CA FROM jointure
GROUP BY GROUPING SETS(
	(Id_Employe,Nom_Employe, PrenomEmploye, Pays,Region),
	(Id_Employe,Nom_Employe, PrenomEmploye, Pays),
	(Id_Employe,Nom_Employe, PrenomEmploye),
	(Pays,Region),
	(Pays)
)

