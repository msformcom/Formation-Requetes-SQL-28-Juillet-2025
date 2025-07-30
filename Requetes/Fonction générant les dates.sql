-- 01/06/2006 => 31/05/2007

CREATE FUNCTION Helpers.DateRange(
@Debut DATE, 
@Fin  DATE 
) RETURNS @Dates TABLE(
	Date DATE
) AS BEGIN

	DECLARE @DateCourante DATE =@Debut

	WHILE @DateCourante<=@Fin
	BEGIN
		INSERT INTO @Dates(Date) VALUES(@DateCourante)
		SET @DateCourante=DATEADD(day,1,@DateCourante)
	END
	RETURN 
END

SET DATEFORMAT DMY
SELECT D.Date, 
		Count(orderid) AS NbCommandes FROM Helpers.DateRange('01/05/2006','31/05/2007') D 
		LEFT JOIN Sales.orders O ON D.date=O.orderdate
GROUP BY D.Date