/****** Script for SelectTopNRows command from SSMS  ******/

WITH Annees AS (SELECT  n as annee FROM dbo.nums WHERE n BETWEEN 2006 AND 2008),
Mois AS (SELECT  n AS Mois FROM dbo.nums WHERE n BETWEEN 1 AND 12),
AnneesMois AS (SELECT * FROM Annees,Mois)
SELECT AM.annee,
		AM.mois,
		ISNULL(CAAM.caMensuel,0) FROM AnneesMois AS AM
	LEFT JOIN CaParAnneeMois CAAM ON AM.annee=CAAM.annee AND AM.Mois=CAAM.mois
	ORDER BY AM.annee,AM.mois
