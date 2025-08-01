SELECT TOP 10 * FROM Prospection.contacts

-- 5D78BEB4-1D33-419E-87E8-6502DCC3CAF6	EFA	LGB	100.00

SELECT * FROM Prospection.contacts WHERE prenom='LGB'

SELECT * FROM Prospection.contacts WHERE PK_Contact='5D78BEB4-1D33-419E-87E8-6502DCC3CAF6'

CREATE INDEX IX_Prenom ON Prospection.contacts(prenom)
DROP INDEX IX_Prenom ON Prospection.contacts

-- SELECT qui recherche un nom en particulier 
-- Avec une selectivité grande => Besoin d'index
SELECT * FROM Prospection.contacts WHERE nom='EFA'
CREATE NONCLUSTERED INDEX IX_Nom ON Prospection.contacts(nom)

-- Index inutile pour cette recherche 
-- Pas assez selectif => 100% => 99.998 % enregistrement sont ok
SELECT * FROM Prospection.contacts WHERE nom<>'EFA'

--Index en cluster ?
SELECT TOP 100 * FROM Prospection.contacts
-- Par défaut les enregistrements sont stockés en fonction de leur order d'insertion

SELECT * FROM Prospection.contacts ORDER BY Nom,prenom

-- Index cluster => 1 par table => détermine l'ordre dans lequel sont stockés les enregistrement
CREATE CLUSTERED INDEX CL_NomPrenom ON Prospection.contacts(Nom,prenom)


-- Table  Sales.Orders => Quel index en cluster ?
-- SELECT * FROM Sales.Orders WHERE orderdate='2006-07-15'
-- L'Index en cluster sur la date est parfait 

-- SELECT * FROM Sales.Orders WHERE custid=23
-- L'Index en cluster sur la custid

-- Sur la table orderdetails quel index en cluster ?
SELECT * FROM Sales.OrderDetails WHERE productid=12



/* Statistiques 
80 M de francais
SELECT * FROM PopulationFrancaise WHERE AGE>60 AND RevenuMensuel > 30 000
1) Age puis revenu +> 80M => age > 60 => 20M => 500 000 Personnes 
2) Revenu puis age => 80M => revenu => 2M => Age => 500 000 Personnes 
Création index crée aussi des statistiques
*/

/*
	1) Index Cluster => 1 seul par table => Order de stockage
		Optimiser les Order BY
		Optimiser les recherches sur les données du cluster
		SELECT * FROM orders WHERE orderdate='2006-10-06' => Index cluster orderdate
	2) Index non cluster => Permet de trouver des enregsitrements individuel
		SELECT * FROM contacts WHERE Prenom='Donasen'
		Index sur prenom => Si le prenom est assez selectif
		Optimise les recherches => statistiques 
	3) Statistics => WHERE age>60 AND salaireM>30000
		Par quel critere commencer
		CREATE STATISTICS statsAge ON Population (age)
		CREATE STATISTICS statsSalairM ON Population (salaireM)

*/

-- Seek car index couvrant
SELECT Prenom FROM Prospection.contacts
WHERE Prenom  like 'A%'


-- scan car index non couvrant
SELECT Prenom,credit FROM Prospection.contacts
WHERE Prenom  like 'A%' -- Peu selectif => 1/20 => 10000 enregistrements

 -- Avec credit stocvke dans l'index
DROP INDEX IX_Prenom ON Prospection.contacts
CREATE INDEX IX_Prenom ON 
-- Liste des colonnes dans le where
Prospection.contacts(prenom) 
-- Liste des colonnes en plus dans le select
INCLUDE(credit)

-- seek car index  couvrant
SELECT Prenom,credit FROM Prospection.contacts
WHERE Prenom  like 'A%' -- Peu selectif => 1/20 => 10000 enregistrements


/* Strategie Ecriture de requetes
	Ecrire la même selection sous différentes formes de requète
	- Jointures
	- Sous requete
	Regarder le plan d'exécution
	=> Eliminer les scan => Créer des index pour avoir si possible du seek
	=> Comprarer les requetes avec le subtree cost

*/