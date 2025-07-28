-- commandes non livrées

-- GETDATE => Heure actuelle => non deterministes
SELECT RAND()

SELECT orderid AS ID_Commande,
	 	DATEDIFF(hour,orderdate, ISNULL(shippeddate,GETDATE())) AS Temps_Livraison,

	-- Pas bon car colonne transformée en chaine de car => problème avec les additons
	CASE WHEN shippeddate IS NULL THEN 'Livraison en cours'
	ELSE CONVERT(NVARCHAR,DATEDIFF(hour,orderdate, shippeddate)) END AS Temps_Livraison
FROM [Sales].[Orders]

--WHERE shippeddate IS NULL
ORDER BY shippeddate 

SELECT ISNULL(3, 2) -- => 3  plutot SQL Server
SELECT ISNULL(null, 2) -- => 2
SELECT COALESCE(2,3,5,9)
SELECT COALESCE(null,null,5,9)





SELECT '168'