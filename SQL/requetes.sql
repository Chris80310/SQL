

/**************************************** HOTEL ********************************/


1-
-- SELECT hot_nom,hot_ville FROM hotel
2-
-- SELECT cli_nom,cli_prenom,cli_ville FROM client WHERE cli_id=4
3-
-- SELECT sta_nom,sta_altitude FROM station WHERE sta_altitude<1000
4-
-- SELECT cha_id FROM chambre WHERE cha_capacite >1
5-
-- SELECT cli_nom,cli_ville FROM client WHERE cli_ville <> "Londres"
6-
-- SELECT hot_nom, hot_categorie, hot_ville FROM hotel WHERE hot_ville = 'Bretou' AND hot_categorie >3
7-
-- SELECT hot_nom,hot_categorie,hot_ville,sta_nom FROM hotel JOIN station ON hot_id = sta_id
8-
-- SELECT hot_nom, hot_categorie, hot_ville,cha_numero FROM hotel JOIN chambre ON hot_id = cha_id
9-
-- SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite 
-- FROM hotel 
-- JOIN chambre ON hot_id = cha_hot_id WHERE hot_ville = 'Bretou' and cha_capacite > 1
10-
-- SELECT cli_nom, hot_nom, res_date FROM reservation
-- join client ON cli_id = res_cli_id
-- join chambre on cha_id = res_cha_id
-- join hotel on hot_id = cha_hot_id
11-
-- SELECT sta_nom, hot_nom, cha_numero, cha_capacite FROM chambre
-- JOIN hotel ON hot_id = cha_hot_id
-- JOIN station ON sta_id = hot_sta_id
12-
-- SELECT cli_nom, hot_nom, res_date_debut, DATEDIFF (res_date_fin, res_date_debut)
-- FROM reservation
-- join client ON cli_id = res_cli_id
-- join chambre on cha_id = res_cha_id
-- join hotel on hot_id = cha_hot_id
13-
-- SELECT sta_nom, COUNT(hot_sta_id) FROM station
-- JOIN hotel ON sta_id = hot_sta_id
-- GROUP BY sta_nom;
 14-
-- SELECT sta_nom, COUNT(cha_id) FROM station
-- JOIN hotel ON sta_id = hot_sta_id
-- JOIN chambre ON cha_hot_id = hot_id
-- GROUP BY sta_nom;
15-
-- SELECT sta_nom, COUNT(cha_id) FROM station
-- JOIN hotel ON sta_id = hot_sta_id
-- JOIN chambre ON cha_hot_id = hot_id
-- WHERE cha_capacite >1
-- GROUP BY sta_nom;
16-
-- SELECT hot_nom, cli_nom FROM reservation
-- JOIN client ON res_cli_id = cli_id
-- JOIN chambre ON res_cha_id = cha_id
-- JOIN hotel on cha_hot_id = hot_id
-- WHERE cli_nom = 'Squire'
17-
-- SELECT sta_nom, AVG (datediff (res_date_debut, res_date_fin))
-- FROM reservation
-- JOIN chambre on res_cha_id = cha_id
-- JOIN hotel ON hot_id = cha_hot_id
-- JOIN station ON sta_id = hot_sta_id


/**************************************************** PAPYRUS **************************************************/


1-
-- SELECT nomfou, produit.codart, libart, priuni, qteliv FROM ligcom
-- JOIN produit ON produit.codart = ligcom.codart
-- JOIN vente ON vente.codart = produit.codart
-- JOIN fournis ON fournis.numfou = vente.numfou
-- WHERE fournis.numfou=9120;
2-
-- SELECT fournis.numfou, nomfou, produit.codart, libart, priuni, qteliv FROM ligcom
-- JOIN produit ON produit.codart = ligcom.codart
-- JOIN vente ON vente.codart = produit.codart
-- JOIN fournis ON fournis.numfou = vente.numfou
-- GROUP BY numfou;
3-
-- SELECT COUNT(numcom),COUNT(DISTINCT numfou) FROM entcom;
4-
-- SELECT codart, libart, stkphy, stkale, qteann FROM produit 
-- WHERE stkphy <= stkale AND qteann < 1000;
5-
-- SELECT posfou, nomfou FROM fournis
-- WHERE LEFT (posfou, 2) IN (75,78,92,77)
-- ORDER BY posfou DESC 

-- ORDER BY nomfou ASC
6-
-- SELECT numcom, codart FROM ligcom 
-- WHERE SUBSTR(derliv,6) IN (03,04);
7-
-- SELECT numcom, datcom FROM entcom 
-- WHERE obscom <> '';
8-
-- SELECT numcom, priuni * qteliv AS total FROM ligcom
-- GROUP BY total
-- ORDER BY total DESC
9-
-- SELECT numcom, priuni * qteliv AS total FROM ligcom
-- WHERE priuni * qteliv > 10000 AND qteliv >= 1000;
10-
-- SELECT nomfou, numcom, derliv FROM ligcom
-- NATURAL JOIN produit 
-- NATURAL JOIN vente 
-- NATURAL JOIN fournis 
11-
-- SELECT ligcom.numcom, nomfou, libart, priuni * qteliv FROM entcom
-- NATURAL JOIN produit
-- NATURAL JOIN vente
-- NATURAL JOIN fournis 
-- NATURAL JOIN ligcom
-- WHERE obscom = 'Commande urgente';
12-

A-
-- SELECT nomfou FROM fournis
-- NATURAL JOIN entcom
-- WHERE entcom.obscom = 'Commande cadencée'

B-
-- SELECT nomfou FROM fournis
-- NATURAL JOIN entcom
-- NATURAL JOIN ligcom
-- WHERE ligcom.qteliv >= 10000;

13-

A-
-- SELECT entcom.numcom, datcom FROM ligcom
-- JOIN entcom ON entcom.numcom = ligcom.numcom
-- JOIN fournis ON fournis.numfou = entcom.numfou
B-


14-
-- SELECT libart, prix1 FROM vente
-- Natural JOIN produit 
-- WHERE prix1 < (
-- 	SELECT MIN(prix1)
-- 	 FROM produit
-- 	 natural JOIN vente 
-- WHERE LEFT(libart,1) IN ('R'));

15-


