-- DML : Data Manuipulation Language => SELECT, INSERT, DELETE, UPDATE
-- DDL : Data Definition Language => CREATE DROP ALTER
/*
	Application => Zone de Texte pour entrer une recherche
	Zone de texte => Bike

	=> SELECT * FROM Production.products WHERE productname LIKE '%Bike%'
	
	Zone de texte => Bike'; DROP DATABASE TSQL; --
	=> SELECT * FROM Production.products WHERE productname LIKE '%Bike'; DROP DATABASE TSQL; --%'
*/

/*
	BIT Entier codé sur 1 bits 0 => 0 1 => 2
	Entier codé sur 2 bits 01 => 00 01 10 11 => 4
	Entier codé sur 3 bits 011 => 000 001 010 011 + 100 101 110 111 => 8
	Entier codé sur 4 bits 011 => 000 001 010 011 100 101 110 111 => 16
	TINYINT Entier codé sur 8 bits 01010101 => 2 puissance 8 => 256
	INT Entier code sur 32 bits => 2 ^32 => 4294967296 => -2,147,483,648 to 2,147,483,647
	BIGINT Entier code sur 64 bits => 18 446744073 709551616 => -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
	UNIQUEIDENTIFIER => 128 bits => 340 000000000 000000000 000000000 000000000

	8 bits => 0-255   1,76,45,35,87 => 200 enregistrements
	Avec GUID
	- Supprime le produit 2fd2cb01-494b-4edd-94ba-38435d0ef8e7 => mail + copier coller
	- DELETE FROM Production.products WHERE productid=2fd2cb01-494b-4edd-94ba-36435d0ef8e7

	- https://macompagnie.com/bulletin-salaire/2fd2cb01-494b-4edd-94ba-36435d0ef8e7
	- https://macompagnie.com/bulletin-salaire/2fd2cb01-494b-4edd-94ba-36435d0ef8e8

	AVEC Entiers
	- Supprime le produit 1567 => par telephone
	- DELETE FROM Production.products WHERE productid=1676

	- https://macompagnie.com/bulletin-salaire/1234
	- https://macompagnie.com/bulletin-salaire/1235
*/

USE TSQL
GO


DROP TABLE Prospection.Contacts
DROP SCHEMA Prospection


USE TSQL
GO

CREATE SCHEMA Prospection
GO -- Executer les insctructions au dessus avant de passer à la suivante


CREATE TABLE Prospection.Contacts(
	 --  La BDD génère les identifiant
	 -- En mode déconnecté on ne peut pas connaitre l'id d'un nouveau enregistrement 
	 -- avant de l'insérer
	 -- PK_Contact INT PRIMARY KEY IDENTITY(3,2) -- Numerotation auto 3,5,7,9...

	PK_Contact UNIQUEIDENTIFIER DEFAULT newid(), -- GUID newid() => identifiant au hasard => 1/340 000000000 000000000 000000000 000000000
	Nom NVARCHAR(50),
	Prenom NVARCHAR(50),
	Credit DECIMAL(18,2) DEFAULT 100
)
GO
-- La BDD garantit que le credit ne peut pas dépasser 200
ALTER TABLE Prospection.contacts ADD CONSTRAINT Max_Credit CHECK( Credit<2000)
GO
-- INsertion
INSERT INTO  Prospection.Contacts(nom,prenom) 
VALUES('A','B')

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'F'+Nom, 'G'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'R'+Nom, 'U'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'Z'+Nom, 'H'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'E'+Nom, 'L'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'M'+Nom, 'I'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'Y'+Nom, 'O'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'D'+Nom, 'S'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'A'+Nom, 'X'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'K'+Nom, 'J'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'Q'+Nom, 'N'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'G'+Nom, 'V'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'B'+Nom, 'C'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'T'+Nom, 'F'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'W'+Nom, 'R'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'Q'+Nom, 'O'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'S'+Nom, 'Q'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'F'+Nom, 'A'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'L'+Nom, 'T'+prenom FROM Prospection.Contacts

INSERT INTO  Prospection.Contacts(nom,prenom) 
SELECT 'T'+Nom, 'B'+prenom FROM Prospection.Contacts

SELECT Count(*) FROM Prospection.Contacts