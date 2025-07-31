-- Vue => Requète à laquelle on donne un nom
CREATE OR ALTER VIEW production.View_Products
AS
SELECT P.productid AS productid,
		P.productname AS productname,
		C.categoryname AS categoryname
FROM Production.Products P 
INNER JOIN Production.Categories C ON P.categoryid=C.categoryid

SELECT * FROM production.View_Products

-- Fonctions de type table => Requete paramétrée
CREATE OR ALTER FUNCTION Sales.OrdersByYear (
@year INT
) RETURNS TABLE
AS RETURN
SELECT * FROM sales.orders 
WHERE DATEPART(year,orderdate)=@year

SELECT * FROM Sales.OrdersByYear(2006)

-- Fonctions de type table en ligne => On remplit une table avec des données
CREATE OR ALTER FUNCTION Helpers.RangeInt(
@FirstInt INT,
@LastInt INT)
RETURNS @resultat TABLE(
n INT
) AS 
BEGIN
	WHILE @firstInt <= @LastInt
	BEGIN
		INSERT INTO @resultat(n) VALUES(@FirstInt)
		SET @FirstInt=@FirstInt+1
	END
	RETURN 
END

SELECT * FROM Helpers.RangeInt(2006,2008)

-- Fonction scalaire => Renvoit une valeur
CREATE OR ALTER FUNCTION HR.PrimeAnnuelle(
@CaGenere DECIMAL(18,2)
) RETURNS DECIMAL(18,2)
AS BEGIN
 RETURN  100 + @CaGenere * 0.01
 END

 SELECT HR.PrimeAnnuelle(10000000)