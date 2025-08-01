-- Créer une procedure qui fait les choses suivante 
-- Utilisation EXEC OffrirCadeau 'Stylo Publicitaire'
-- 1) Créer la categorie 'cadeau' si elle n'existe pas deja 
-- 2) inserer un produit dans production.products :
-- category Cadeau, productname 'Stylo publicitaire', supplier 1,unitprice 0, 
-- discontinued 0
-- 3) Ajoute une ligne dans orderdetails avec le cadeau 1 sur toutes les commandes 
--      non expédiées
-- 4) Si la proc marche => discontinued dans le produit
-- Le faire sans proc avec des instructions
-- IF EXIST(SELECT....)
-- UPDATE    OUTPUT => deleted , inserted
-- INSERT    OUTPUT => inserted
-- DELETE    OUTPUT => deleted


CREATE OR ALTER PROCEDURE OffrirCadeau(
	@NomCadeau NVARCHAR(40),
	@NbDisponible INT
) AS 
BEGIN
	BEGIN TRAN
	BEGIN TRY 
		IF NOT EXISTS(SELECT * FROM Production.Categories WHERE categoryname='Cadeau')
		BEGIN
			INSERT INTO  Production.Categories(categoryname,description) 
			VALUES('Cadeau','Pour les cadeaux')
		END
		-- Ici, la catégorie cadeau existe
		DECLARE @catCadeau INT
		-- Recherche de la valeur de l'id de la catégorie Cadeau
		SET @catCadeau=(SELECT categoryid FROM Production.Categories 
							WHERE  categoryname='Cadeau')

		SELECT @catCadeau=categoryid FROM Production.Categories 
							WHERE  categoryname='Cadeau'

		
		INSERT INTO Production.Products(productname,supplierid,categoryid,unitprice,discontinued)
		-- OUTPUT Inserted.productid INTO ...
		VALUES(@NomCadeau,1,@catCadeau,0,0)



		DECLARE @CadeauId INT =@@Identity -- Contient l'id de la derniere instertion

		-- id des commandes non expediees
		INSERT INTO Sales.OrderDetails
		SELECT orderid,@CadeauId,0,1,0

		 FROM Sales.orders WHERE shippeddate IS NULL
		--@@rowcount = Nombre d'enregistrements modifiés par la dernière instruction
		IF @@rowcount > @NbDisponible
		BEGIN
			;THROW 50001,'Quantité insuffisante',1
		END
		 UPDATE Production.Products SET discontinued=1 
		 WHERE productid=@CadeauId
		
		COMMIT

	END TRY
	BEGIN CATCH
		DECLARE @message NVARCHAR(1000) = ERROR_MESSAGE()
		ROLLBACK
		;THROW 50001,@message,1
	END CATCH

END

/*
-- Active la possibilité de mettre des valeurs explicites dans l'ID
SET IDENTITY_INSERT Production.Categories ON
BEGIN TRAN
INSERT INTO  Production.Categories (categoryid,categoryname,description)
VALUES (0,'Cadeau','Pour le cadeaux')
-- Desactive la possibilité de mettre des valeurs explicites dans l'ID
SET IDENTITY_INSERT Production.Categories OFF
ROLLBACK
*/

BEGIN TRAN

EXEC OffrirCadeau 'Stylo bille',1

SELECT * FROM Production.categories
SELECT * FROM Production.products
SELECT orderid FROM Sales.Orders WHERE shippeddate IS NULL
EXCEPT
SELECT orderid FROM Sales.OrderDetails WHERE productid=78

ROLLBACK

SELECT @@TRANCOUNT