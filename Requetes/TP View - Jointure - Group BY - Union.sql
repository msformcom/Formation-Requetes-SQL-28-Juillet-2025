-- | Min | Max exclu									| Qty  | CA
-- | 0   | 10											| 5    | 1000
-- | 10  | 20			I.Min<= unitprice AND			| 6    | 5000
-- | 20  | 50			I.Max> unitprice     			| 7886 |1987987198719
-- | 50  | 10000										| 17   | 10000
-- Générée avec des UNION								| OrderDetains unitprice, qty
--Intervales I													| unitprice 25, qty 12
CREATE VIEW VentesParIntervale AS
WITH Intervales AS (
SELECT	0 AS Min, 10 AS MAx
UNION SELECT 10,20
UNION SELECT 20,50
UNION SELECT 50, 922337203685477.5807), 
Jointure AS (
SELECT * FROM Intervales I LEFT JOIN Sales.OrderDetails OD
ON OD.unitprice >= I.Min AND OD.unitprice < I.Max)
SELECT Min, 
		MAx, 
		SUM(qty) AS Qty,
		SUM(qty*unitprice) AS CA

  FROM Jointure
GROUP BY Min,Max

SELECT * FROM VentesParIntervale




