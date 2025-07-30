-- Fonction scalaire => Renvoit une valeur unique, utile dans les requètes
CREATE OR ALTER FUNCTION Production.OrdreDePrix(
	@prix DECIMAL(18,2) -- Nombre avec 18 chiffres significatifs et 2 après la virgule
) RETURNS NVARCHAR(50) AS
BEGIN
	RETURN CASE WHEN @prix<100 THEN N'Pas cher'
			WHEN @prix<150 THEN N'Moyen'
			ELSE N'Cher' END
END 

CREATE OR ALTER FUNCTION Production.CalculMarge(
	@prix DECIMAL(18,2) -- Nombre avec 18 chiffres significatifs et 2 après la virgule
) RETURNS DECIMAL(18,2) AS
BEGIN
	RETURN CASE WHEN @prix<=70 THEN 10
			
			ELSE @prix*0.015 END
END 

SELECT productname,
		production.OrdreDePrix(unitprice) AS IndicationPrix,
		unitprice AS PrixUnitaire,
		production.CalculMarge(unitprice) AS PrixMarge -- => unitprice <7 => 1 sinon 1.5%
FROM Production.products

