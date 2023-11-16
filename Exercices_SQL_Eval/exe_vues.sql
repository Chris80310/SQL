/**************** SQL / LES VUES ***************/

-- Une vue est une représentation logique d'une requête utilisateur réalisée sur une ou plusieurs tables. 
-- C'est une table virtuelle basée sur les données des tables de la base. 
-- Elle se comporte ensuite comme si elle était une table du moins pour ce qui est de son interrogation.

-- L'intérêt d'une vue est qu'elle permet à l'utilisateur de stocker des requêtes plus ou moins complexe et de l'utiliser comme s'il s'agissait d'une table.
-- Egalement, il est possible d'attribuer à une vue (de la même manière qu'à une table d'ailleurs)
-- des droits en lecture /écriture, etc... C'est une manière simple de cacher certaines colonnes à un ou à plusieurs utilisateurs.

/**** Utilisation d'une vue *****/

-- Une vue s'utilise de la même façon qu'une table :

SELECT * FROM nom_de_la_vue


/******* Exercices sur hotel : *******/


-- 1/ Afficher la liste des hôtels avec leur station

CREATE VIEW hot_sta_view
AS
SELECT hot_nom, sta_nom
FROM hotel 
JOIN station ON sta_id = hotel.hot_sta_id;

-- 2/ Afficher la liste des chambres et leur hôtel

CREATE VIEW cha_hot_view
as SELECT hot_nom, cha_numero
FROM hotel 
JOIN chambre on chambre.cha_hot_id = hotel.hot_id;


-- 3/ Afficher la liste des réservations avec le nom des clients

CREATE VIEW res_cli_view
AS SELECT CONCAT(cli_prenom, cli_nom) AS client, res_id
FROM reservation
JOIN client ON client.cli_id = res_id;


-- 4/ Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station

CREATE VIEW sta_hot_chanum_view
AS SELECT sta_nom, hot_nom, cha_numero
FROM hotel 
JOIN chambre ON cha_id = hotel.hot_id
JOIN station ON sta_id = hotel.hot_sta_id;


-- 5/ Afficher les réservations avec le nom du client et le nom de l’hôtel

CREATE VIEW res_cli_hot_view
AS SELECT res_id, concat(cli_prenom, cli_nom) AS client, hot_nom
FROM client 
JOIN hotel ON cli_id = hotel.hot_id
JOIN reservation ON hot_id = hotel.hot_id;


/****************** SQL / LES VUES / PAPYRUS : *********************/


-- Papyrus ex 1 :

CREATE VIEW v_GlobalCde AS 
SELECT codart, qteliv AS QteTot, sum(priuni*qteliv) AS PrixTot
FROM ligcom
WHERE qteliv > 0
GROUP BY codart;


-- Papyrus ex 2 :

CREATE VIEW v_Ventesl100 AS 
SELECT * FROM vente WHERE codart = 'I100';


-- Papyrus ex 3 :

CREATE VIEW v_Ventesl100Grobrigan AS 
SELECT * FROM vente WHERE codart = 'I100'
AND numfou = 120;



