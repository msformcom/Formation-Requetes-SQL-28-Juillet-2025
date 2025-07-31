-- Fonctions de fenètrage
SELECT * ,
	--ROW_NUMBER() OVER(ORDER BY productid) AS RowNumberProductId,
	--ROW_NUMBER() OVER(ORDER BY unitprice) AS RowNumberPrix,
	RANK() OVER(ORDER BY unitprice) AS RankPrix,
	--DENSE_RANK() OVER(ORDER BY unitprice) AS DenseRankPrix,
	RANK() OVER(PARTITION BY categoryid ORDER BY unitprice ) AS RankPrixParCategory,
	-- COUNT(*) OVER (PARTITION BY Categoryid) AS NombreParCategory,
	-- MIN(unitprice) OVER (PARTITION BY Categoryid) AS MinPrixParCategory,
	AVG(unitprice) OVER (PARTITION BY Categoryid) AS MoyennePrixParCategory
	-- MAX(unitprice) OVER (PARTITION BY Categoryid) AS MaxPrixParCategory,
	-- NTILE(5) OVER(PARTITION BY categoryid ORDER BY unitprice ) AS NTILE5PrixParCategory,
	-- LEAD(unitprice,1) OVER(PARTITION BY categoryid ORDER BY unitprice ) LeadUnitPriceParCategory ,
	-- LAG(unitprice,1) OVER(PARTITION BY categoryid ORDER BY unitprice ) LagUnitPriceParCategory 
FROM production.products
ORDER BY categoryid, unitprice

SELECT * ,
	CAMensuel / SUM(CAMensuel) OVER (Partition BY Annee) AS PercentCASurAN,
	CAMensuel - LAG(CAMensuel) OVER (ORDER BY Annee,Mois) AS DiffMoisPrecedent,
	SUM(CAMensuel) OVER (PARTITION BY Annee ORDER BY mois)  AS CumulCAPArAnnee,
	SUM(CAMensuel) OVER ( ORDER BY Annee, mois) AS CumulCA ,
	CAMensuel -AVG(CAMensuel) OVER (ORDER BY annee,mois ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING) AS MoyenneGlissanteSUR3Avnat3Apres
FROM [dbo].[CaParAnneeMois]
ORDER BY Annee,Mois