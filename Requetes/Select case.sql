/*
	Liste des produits 
	Nom produit
	Prix
	Prix + marge de 10%
	En stock

*/



-- 1) La source => Quelle(s) table(s) sont impliquées
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Regarder les données pour se faire une idéee
SELECT TOP 5 *
FROM Production.Products

SELECT TOP 5	productname AS 'Nom produit',
				unitprice AS Prix,
				unitprice * 1.1 AS 'Prix + marge de 10%',
				CASE WHEN discontinued=1 THEN 'Epuisé'
					WHEN discontinued=2 THEN 'Spécial'
					ELSE 'Disponible' END AS 'En Stock'
FROM Production.Products

-- Ajouter une colonne 'Ordre de prix'
-- prix entre 0 et 100 => Pas cher
-- >100 et <=200 => Moyen
-- > 200 => Cher

SELECT TOP 50	productname AS 'Nom produit',
				unitprice AS Prix,
				unitprice * 1.1 AS 'Prix + marge de 10%',
				CASE WHEN unitprice <= 100 THEN 'Pas cher'
					WHEN unitprice <=200 THEN 'Moyen'
					ELSE 'Cher' END AS [Ordre de prix],
				CASE WHEN discontinued=1 THEN 'Epuisé'
					WHEN discontinued=2 THEN 'Spécial'
					ELSE 'Disponible' END AS 'En Stock'
FROM Production.Products


