-- Liste des Orders
-- Date de la commande, pays
-- date envoi
-- id du client

-- Ordre : Pays croissant, date de commande récentes en premier
-- juste les jours de semaine
-- entre le 10 juin 2006 et le 25 septembre 2006

SET DATEFORMAT DMY

SELECT MONTH('10/11/12') --> 10 format américain
SELECT YEAR('10/11/12')

SELECT DATEPART(quarter,'10/11/12')

