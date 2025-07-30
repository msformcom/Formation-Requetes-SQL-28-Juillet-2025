-- liste des ventes du produit No 4
-- datevente, productid, qty, unitprice, 

SELECT O.orderdate AS Date_Vente,
		 OD.productid AS IdProduit,
		 OD.qty AS Quantite,
		 OD.unitprice AS PrixUnitaire
FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[OrderDetails] AS OD
ON OD.orderid = O.orderid
WHERE OD.productid=4

SELECT DATEPART(year,Date_Vente)AS Annee,
		DATEPART(month,Date_Vente)AS Mois,
		SUM(Quantite * PrixUnitaire) AS CA
FROM 
				(SELECT O.orderdate AS Date_Vente,
						 OD.productid AS IdProduit,
						 OD.qty AS Quantite,
						 OD.unitprice AS PrixUnitaire
				FROM [Sales].[Orders] AS O
				INNER JOIN [Sales].[OrderDetails] AS OD
				ON OD.orderid = O.orderid) AS Ventes
GROUP BY	DATEPART(year,Date_Vente),
			DATEPART(month,Date_Vente)
ORDER BY DATEPART(year,Date_Vente), DATEPART(month,Date_Vente)

-- A partir de la s�lection ci-dessus => CA des ventes par mois de 2006 a 2008
-- | Annee | Mois | CA

-- Common Table Expressions
-- Jointure entre Orders et OrderDetails
;WITH Ventes AS (
	-- Cette requ�te sera disponible dans la suite sous le nom ventes
	SELECT O.orderdate AS Date_Vente,
						 OD.productid AS IdProduit,
						 OD.qty AS Quantite,
						 OD.unitprice AS PrixUnitaire
				FROM [Sales].[Orders] AS O
				INNER JOIN [Sales].[OrderDetails] AS OD
				ON OD.orderid = O.orderid
), 
-- Calcul du mois et de l'ann�e et du montant pour un produit � partir de la date de vente
VentesMesnuelles AS (
SELECT DATEPART(year,Date_Vente)AS Annee,
		DATEPART(month,Date_Vente)AS Mois,
		Quantite * PrixUnitaire AS CA 
		FROM Ventes)
-- Regroupement et somme par ann�e et mois
SELECT Annee AS Annee,
		Mois AS Mois, 
		SUM(CA) AS CAMensuel
		 FROM VentesMesnuelles
GROUP BY Annee,Mois
ORDER BY Annee,Mois




