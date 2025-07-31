
-- Transaction 
-- Ensemble d'op�rations qui respectent un certain nombre de contraintes
-- A = Atomicit� => Tout ou rien
-- C = Coh�rence => Les donn�es doivent �tre coh�rente apr�s une transaction
-- I = Isolation => Les donn�es ne sont pas manipul�es par plusieurs utilisateurs simultan�ment
-- D = Durabilit� => Une fois la transaction valid�e, les donn�es sont durablement conserv�es


-- Utilisateur 1

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
/*
	CHAOS => Aucun verrou n'est pos�, aucun verrou n'est respect� => BDD mono utilisateur
	READ UNCOMMITTED => verrous pos�s sur les donn�es modifi�es  => Pas respect�s en lecture
	READ COMMITTED => verrous pos�s sur les donn�es modifi�es  => Respect�s en lecture
	REPEATABLE READ => verrous pos�s sur les donn�es lues ou modifi�es  => verrous respectes
	SERIALIZABLE => errous pos�s sur les donn�es lues ou modifi�es mais aussi les donn�es non lues

	Plus on monte le niveau isolation => plus de verrous => plus de blocage => moins de conflits
	Plus on descend le niveau osolation => moins de verrous => moins de blocage => plus de conflit

	1) Trop de verrous => certaines requ�tes vont etre retard�es ou emp�ch�es
	2) Pas assez de verrous => une fois tous les 6 mois ou 6 jours, une op�ration se fait mal 

*/
SELECT * FROM Production.Products

UPDATE Production.Products SET unitprice=unitprice * 1.1
-- Attention ! ne pas oublier la condition
WHERE productid=4




-- Utilisateur 2



-- Augmenter de 10% le prix du produit 4
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRAN

SELECT * FROM Production.products
WHERE unitprice>10
-- En mode serializable => Impossible de supprimer / inserer un enregistrement avec un unitprice de 8

UPDATE Production.Products SET unitprice=unitprice * 1.1
-- Attention ! ne pas oublier la condition
WHERE productid=4

COMMIT ROLLBACK

-- Transaction 
-- Ensemble d'op�rations qui respectent un certain nombre de contraintes
-- A = Atomicit� => Tout ou rien
-- C = Coh�rence => Les donn�es doivent �tre coh�rente apr�s une transaction
-- I = Isolation
-- D