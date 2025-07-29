-- Nombre de clients par pays
SELECT  country, 
		companyname,
		COUNT(*) AS NB_Clients FROM [Sales].[Customers]
GROUP BY country


-- quantite de produit vendu 
-- CA généré
-- moyenne du prix de vente
-- par produit

SELECT	productid AS IdProduit,
		SUM(qty) AS QuantiteVendue,
		SUM(qty*unitprice) AS CAGenere,
		AVG(unitprice) AS PrixVenteClient,
		SUM(qty*unitprice)/SUM(qty) AS PrixVenteMoyen
FROM Sales.OrderDetails
GROUP BY productid