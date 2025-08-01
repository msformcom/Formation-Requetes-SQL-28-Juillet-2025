SELECT TOP 20 * FROM Prospection.contacts

-- Enlever 1 euros � tous les contacts dont le nom commence par A
-- et ajouter la somme enlev�e au contact 0F1725A3-87DE-44A8-BAD1-4179ED8101F6

SELECT * FROM Prospection.contacts
WHERE nom LIKE 'B%'

-- Creation de procedure stock�e => ensemble d'instruction avec un nom et des param
CREATE OR ALTER PROCEDURE DeplacementCredit (
@Lettre CHAR(1), -- Premiere lettre du nom des contacts
@montant DECIMAL(18,2), -- Montant � enlever
@pk_contact UNIQUEIDENTIFIER  -- Personne � cr�diter
) AS 
BEGIN
	-- Validatiopn de la valeur du montant
	IF @montant<0
	BEGIN
		;THROW 50002, 'Le montant doit �tre positif',1

	END
			BEGIN TRAN

			BEGIN TRY
				DECLARE @updates TABLE(
				AncienCredit DECIMAL(18,2),
				NouveauCredit DECIMAL(18,2))

				-- J'enleve 1 euros � certaines personnes
				UPDATE Prospection.contacts SET Credit=credit-@montant
				OUTPUT Deleted.Credit, inserted.credit
				INTO @updates
				WHERE nom LIKE @lettre +'%'

				DECLARE @diff DECIMAL(18,2)=(SELECT SUM(Nouveaucredit-anciencredit) FROM @updates)

				-- UPDATE Empeche si credit > 2000 � cause de la contranite
				UPDATE Prospection.contacts SET Credit=Credit - @diff
				WHERE PK_Contact=@pk_contact
				--Le code s'ex�cute ici seulement si pas d'erreur
				PRINT 'Op�ration commit�e'
				COMMIT
				SELECT * FROM Prospection.contacts
				WHERE nom LIKE @lettre +'%'
			END TRY
			BEGIN CATCH
				-- Annulation
				ROLLBACK
				;THROW 50001, 'Op�ration annul��',1
			END CATCH
END



EXEC DeplacementCredit 'B',-1,'0F1725A3-87DE-44A8-BAD1-4179ED8101F6'

EXEC DeplacementCredit 'B',1,'0F1725A3-87DE-44A8-BAD1-4179ED8101F6'

EXEC DeplacementCredit 'B',0.01,'0F1725A3-87DE-44A8-BAD1-4179ED8101F6'

ROLLBACK