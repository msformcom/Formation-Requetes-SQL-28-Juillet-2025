/*
	CHAR(10) => 'Dom' => 'Dom       '	encodage ASCII => années 70 => A => 1 octet
	VARCHAR(10) => 'Dom' => 'Dom'		encodage ASCII
	NVARCHAR(10) => 'Dom' => 'Dom'		encodage Unicode

	ASCII e=> 145 ô => 156 dans la table spéciale Danois
	'eô' => 145 156 sur un système danois
	145 156 => 'eé' sur un systeme francais
	'René' stocké en France => 'Renô' au DK

	Unicode => ㅓ => 45 76 189 76 => unicite d'encodage 
	BIT 0-1, 
	TINYINT  0-255
	SMALLINT -32768 + 32767 
	INT - 2 Milliards + 2 milliards
	BIGINT -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

	DECIMAL(18,2) => 16 chiffres avant la virgule et 2 chiffres apres PRECIS
	REAL FLOAT => IMPRECIS
*/


DECLARE @n REAL=0  -- Avec Float ou Real => Imprecision, DECIMAL Précision
DECLARE @p REAL=1.3
DECLARE @i INT =0;
WHILE @i<10000
BEGIN -- Ce lot d'instruction va s'écecuter 100 fois
	SET @n=@n+@p
	SET @i=@i+1
END
PRINT @n
-- Valeur de n devrait être 130000
IF @n=13000
BEGIN
	PRINT 'Ok'
END