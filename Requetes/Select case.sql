/*
	Liste des produits 
	Nom produit
	Prix
	Prix + marge de 10%
	En stock

*/



-- 1) La source => Quelle(s) table(s) sont impliqu�es
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Regarder les donn�es pour se faire une id�ee
SELECT TOP 5 *
FROM Production.Products

SELECT TOP 5	productname AS 'Nom produit',
				unitprice AS Prix,
				unitprice * 1.1 AS 'Prix + marge de 10%',
				CASE WHEN discontinued=1 THEN 'Epuis�'
					WHEN discontinued=2 THEN 'Sp�cial'
					ELSE 'Disponible' END AS 'En Stock'
FROM Production.Products

-- Ajouter une colonne 'Ordre de prix'
-- prix entre 0 et 100 => Pas cher
-- >100 et <=200 => Moyen
-- > 200 => Cher
-- Etape 3 : Mise en forme
SELECT TOP 50	productname AS 'Nom produit',
				unitprice AS Prix,
				unitprice as PrixEuros,
				unitprice * 1.1 AS 'Prix + marge de 10%',
				CASE WHEN unitprice <= 100 THEN 'Pas cher'
					WHEN unitprice <=200 THEN 'Moyen'
					ELSE 'Cher' END AS [Ordre de prix],
				CASE WHEN discontinued=1 THEN 'Epuis�'
					WHEN discontinued=2 THEN 'Sp�cial'
					ELSE 'Disponible' END AS 'En Stock'
-- Etape 1 de la s�lection : FROM
FROM Production.Products
-- Etape 2 : WHERE 
WHERE unitprice * 1.1  > 50 AND unitprice * 1.1  <=100
--WHERE unitprice*1.1 BETWEEN 50 AND 100 -- Inclus le 50 et le 100

-- Etape 4
ORDER BY 'Prix + marge de 10%' DESC, [nom produit]



