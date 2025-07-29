-- par pays, region et ville => le nombre de ventes 
-- et le nombre de clients ayant consommé
-- avec cube ou rollup

SELECT [shipcountry],ISNULL([shipregion],'---'),[shipcity],  --5
	COUNT(orderid) AS NB_Commandes,
	COUNT(DISTINCT custid) AS NB_Clients

FROM [Sales].[Orders]   -- 1)
WHERE YEAR(orderdate)=2007 -- 2)
GROUP BY [shipcountry],[shipregion],[shipcity] --3
HAVING  COUNT(orderid)>10 -- 4
ORDER BY [shipcountry],[shipregion],[shipcity] --6