-- Procedure stockée qui recoit 2 parametres et qui fait quelmque chose avec
CREATE PROCEDURE MaProc (
@prenom NVARCHAR(50),
@nom NVARCHAR(50))
AS 
BEGIN
	-- pourrait être des opérations complexes
	-- 3 insert, 2 update et 4 delete
	PRINT @prenom + ' '+@Nom
END


-- Créer un type de parametre => 
-- Ensemble d'enregistrement | Prenom | Nom |
CREATE TYPE NomPrenom AS TABLE(
		Prenom NVARCHAR(50),
		Nom NVARCHAR(50))

-- Créer une proc qui recoit une table de type nomprenom 
ALTER PROCEDURE MaProc2(
	 @table NomPrenom READONLY)
		AS 
		BEGIN
			DECLARE @prenom NVARCHAR(50)
			DECLARE @nom NVARCHAR(50)
			-- Définir les lignes sur lesquelles on veut boucler
			DECLARE vend_cursor CURSOR FOR SELECT * FROM @table
			OPEN vend_cursor
			-- Lecture du premiere enregistrement
			FETCH NEXT FROM vend_cursor INTO @prenom, @nom;
			WHILE @@FETCH_STATUS=0
			BEGIN 
				exec MaProc @prenom, @nom
				FETCH NEXT FROM vend_cursor INTO @prenom, @nom;
			END 
			CLOSE vend_cursor;
			DEALLOCATE vend_cursor;
		END

-- Utilisation de la procedure stockée
DECLARE @enregistrements NomPrenom
INSERT INTO @enregistrements
SELECT firstname, lastname FROM HR.Employees

EXEC Maproc2 @enregistrements