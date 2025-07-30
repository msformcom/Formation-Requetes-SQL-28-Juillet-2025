


-- Fonction scalaire => Renvoit une valeur unique, utile dans les requètes
CREATE OR ALTER FUNCTION Production.OrdreDePrix(
	@prix DECIMAL(18,2) -- Nombre avec 18 chiffres significatifs et 2 après la virgule
) RETURNS NVARCHAR(50) AS
BEGIN
	RETURN CASE WHEN @prix<100 THEN N'Pas cher'
			WHEN @prix<150 THEN N'Moyen'
			ELSE N'Cher' END
END 

SELECT productname,
		production.OrdreDePrix(unitprice),
		unitprice,
		production.CalculMarge(unitprice) -- => unitprice <7 => 1 sinon 1.5%
FROM Production.products

