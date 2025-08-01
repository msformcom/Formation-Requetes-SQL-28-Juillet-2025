CREATE VIEW CaParAnneeMois AS
-- Common Table Expressions
-- Jointure entre Orders et OrderDetails
WITH Ventes AS (
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


SELECT * FROM CaParAnneeMois