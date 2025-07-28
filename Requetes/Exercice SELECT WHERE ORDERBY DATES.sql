-- Liste des Orders
-- Date de la commande, pays
-- date envoi
-- id du client

-- Ordre : Pays croissant, date de commande récentes en premier
-- juste les jours de semaine
-- entre le 10 juin 2006 et le 25 septembre 2006
-- ayant mlis moins de 2 jours pour etre livrées

SET DATEFORMAT YMD
-- Date de première commande
DECLARE @DateDebut DATE ='2006-06-10'
-- Date dernière commande (incluse)
DECLARE @DateFin DATE = '2006-09-26'
-- Délai de livraison accpeté
DECLARE @DelaiLivraisonHeures INT =48

SELECT FORMAT([orderdate],'dd/MM/yyyy') AS Date_Commande,
		[shipcountry] AS Pays_Livraison,
		[shippeddate] AS Date_Envoi,
		[custid] AS Id_Client
FROM [Sales].[Orders]
WHERE DATEPART(weekday, orderdate) BETWEEN 2 AND 6 AND Orderdate >= @DateDebut AND orderdate < DATEADD(day, 1, @DateFin)
AND DATEDIFF(hour,orderdate,shippeddate) <=@DelaiLivraisonHeures
ORDER BY Pays_Livraison, Date_Commande DESC


SELECT MONTH('10/11/12') --> 10 format américain
SELECT YEAR('10/11/12')

-- Pour éviter la dépendance aux options du serveur => Specifier l'interpretation donneées aux dates
SET DATEFORMAT MDY
SELECT DATEPART(month,'2025-11-10')

SELECT DATEPART(hour,'2005-10-10')


SELECT DATEDIFF(day,'2025-07-28 12:00:00','2025-07-31 13:00:01')









