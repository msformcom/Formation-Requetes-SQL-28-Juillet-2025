
-- Transaction 
-- Ensemble d'opérations qui respectent un certain nombre de contraintes
-- A = Atomicité => Tout ou rien
-- C = Cohérence => Les données doivent être cohérente après une transaction
-- I = Isolation => Les données ne sont pas manipulées par plusieurs utilisateurs simultanément
-- D = Durabilité => Une fois la transaction validée, les données sont durablement conservées


-- Utilisateur 1

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
/*
	CHAOS => Aucun verrou n'est posé, aucun verrou n'est respecté => BDD mono utilisateur
	READ UNCOMMITTED => verrous posés sur les données modifiées  => Pas respectés en lecture
	READ COMMITTED => verrous posés sur les données modifiées  => Respectés en lecture
	REPEATABLE READ => verrous posés sur les données lues ou modifiées  => verrous respectes
	SERIALIZABLE => errous posés sur les données lues ou modifiées mais aussi les données non lues

	Plus on monte le niveau isolation => plus de verrous => plus de blocage => moins de conflits
	Plus on descend le niveau osolation => moins de verrous => moins de blocage => plus de conflit

	1) Trop de verrous => certaines requètes vont etre retardées ou empêchées
	2) Pas assez de verrous => une fois tous les 6 mois ou 6 jours, une opération se fait mal 

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
-- Ensemble d'opérations qui respectent un certain nombre de contraintes
-- A = Atomicité => Tout ou rien
-- C = Cohérence => Les données doivent être cohérente après une transaction
-- I = Isolation
-- D