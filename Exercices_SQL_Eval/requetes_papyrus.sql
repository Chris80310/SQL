

-- 1/ Quelles sont les commandes du fournisseur 09120 ?

SELECT numcom AS NumeroCommande, 
	   nomfou AS Fournisseur

	FROM ligcom
NATURAL JOIN entcom, fournis

WHERE fournis.numfou = 9120 AND entcom.numfou = 9120;

-- 2/ Afficher le code des fournisseurs pour lesquels des commandes ont été
-- passées.

SELECT numfou AS IDFournisseur, 
       nomfou AS NomFournisseur 
	FROM fournis
NATURAL JOIN entcom
GROUP BY nomfou;

-- 3/ Afficher le nombre de commandes fournisseurs passées, et le nombre
-- de fournisseur concernés

SELECT nomfou AS 'Nom fournisseur',
		 COUNT(numcom) AS 'Commande passée'
	FROM entcom
NATURAL JOIN fournis
GROUP BY nomfou;

-- 4/ Editer les produits ayant un stock inférieur ou égal au stock d'alerte et
-- dont la quantité annuelle est inférieur est inférieure à 1000
-- (informations à fournir : n° produit, libellé produit, stock, stock actuel
-- d'alerte, quantité annuelle)

SELECT codart AS 'n° produit', 
	  	 libart AS 'libellé produit', 
		 stkphy AS 'stock actuel', 
		 stkale AS 'quantité alerte', 
		 qteann AS 'quantité annuelle'

	FROM produit
WHERE stkphy < stkale AND qteann < 1000;

-- 5/ Quels sont les fournisseurs situés dans les départements 75 78 92 77 ?
-- L’affichage (département, nom fournisseur) sera effectué par
-- département décroissant, puis par ordre alphabétique

SELECT posfou AS 'Département fournisseur',
		 nomfou AS 'Nom fournisseur'
	FROM fournis
ORDER BY posfou DESC, nomfou ASC;

-- 6/ Quelles sont les commandes passées au mois de mars et avril ?

SELECT numcom AS 'numéro de commande',
	   datcom AS 'date de commande'
		
	FROM entcom
WHERE MONTH (datcom) in (3,4);

-- 7/ Quelles sont les commandes du jour qui ont des observations
-- particulières ?
-- (Affichage numéro de commande, date de commande)

SELECT numcom AS 'Numéro de commande',
		datcom AS 'Date de commande',
		obscom AS 'Commentaire commande'
		FROM entcom
WHERE obscom != '';

-- 8/ Lister le total de chaque commande par total décroissant
-- (Affichage numéro de commande et total)

SELECT  numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
	
GROUP BY numcom;

-- Méthode 2 :

SELECT numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
	
ORDER BY numcom;

-- 9/ Lister les commandes dont le total est supérieur à 10 000€ ; on exclura
-- dans le calcul du total les articles commandés en quantité supérieure
-- ou égale à 1000. (Affichage numéro de commande et total)

SELECT numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
WHERE  (qtecde*priuni) >10000 AND qtecde <= 1000

ORDER BY numcom;

-- 10/ Lister les commandes par nom fournisseur
-- (Afficher le nom du fournisseur, le numéro de commande et la date)

SELECT  numfou AS 'Fournisseur',
		numcom AS 'Numéro de commande',
		datcom AS 'Date de commande'
	FROM entcom
ORDER BY numfou;

-- 11/ Sortir les produits des commandes ayant le mot "urgent' en
-- observation?

SELECT numcom AS 'Numéro de commande',
		numfou AS 'Fournisseur',
		codart AS 'Libellé produit',
		(qtecde*priuni) AS 'Total commande',
		obscom
	FROM ligcom
natural JOIN entcom

WHERE obscom LIKE '%urgente%'

-- 12/ Coder de 2 manières différentes la requête suivante :
-- Lister le nom des fournisseurs susceptibles de livrer au moins un article

SELECT nomfou AS 'Founisseur'
		
	FROM fournis
NATURAL JOIN entcom,vente,ligcom
WHERE qteliv != 0
GROUP BY nomfou;

-- Méthode 2 :

SELECT nomfou AS 'Fournisseur'

	FROM fournis
NATURAL JOIN entcom, ligcom, produit, vente
WHERE qte1 >= 1
GROUP BY nomfou;

-- 13/ Coder de 2 manières différentes la requête suivante
-- Lister les commandes (Numéro et date) dont le fournisseur est celui de
-- la commande 70210 :

SELECT  numcom AS 'Numéro de Commande',
		datcom AS 'Date de Commande'
	FROM ligcom
NATURAL JOIN entcom, fournis
WHERE nomfou = (
    SELECT nomfou
	 	FROM fournis
    NATURAL JOIN entcom
    WHERE numcom = 70210);

-- Méthode 2 :

SELECT  entcom.numcom AS 'Numéro de Commande',
		datcom AS 'Date de Commande'
	FROM ligcom
	
INNER JOIN entcom ON entcom.numcom = ligcom.numcom
INNER JOIN fournis ON entcom.numfou = fournis.numfou;

-- 14/ Dans les articles susceptibles d’être vendus, lister les articles moins
-- chers (basés sur Prix1) que le moins cher des rubans (article dont le
-- premier caractère commence par R). On affichera le libellé de l’article
-- et prix1

SELECT libart, prix1
	FROM produit
JOIN vente ON produit.codart = vente.codart

WHERE prix1 < (

    SELECT MIN(prix1)
    FROM produit
    JOIN vente ON produit.codart = vente.codart
    WHERE LEFT(libart, 1) IN ( 'R', 'r'));

-- 15/ Editer la liste des fournisseurs susceptibles de livrer les produits
-- dont le stock est inférieur ou égal à 150 % du stock d'alerte. La liste est
-- triée par produit puis fournisseur

SELECT  libart AS 'libellé article',
		nomfou AS 'fournisseur'
	FROM produit
JOIN vente ON produit.codart = vente.codart
JOIN fournis ON vente.numfou = fournis.numfou

WHERE stkphy <=(stkale*1.5)
ORDER BY  libart, numfou;

-- 16/ Éditer la liste des fournisseurs susceptibles de livrer les produit dont
-- le stock est inférieur ou égal à 150 % du stock d'alerte et un délai de
-- livraison d'au plus 30 jours. La liste est triée par fournisseur puis
-- produit

SELECT  nomfou AS 'fournisseur',
		libart AS 'libellé article',
		 delliv AS 'délai de livraison'
	FROM produit
JOIN vente ON produit.codart = vente.codart
JOIN fournis ON vente.numfou = fournis.numfou

WHERE stkphy <=(stkale*1.5) AND delliv <= 30
ORDER BY  nomfou, libart;

-- 17/ Avec le même type de sélection que ci-dessus, sortir un total des
-- stocks par fournisseur trié par total décroissant

SELECT nomfou,
		SUM(STKPHY) AS 'stock'
	FROM vente,produit,fournis

WHERE vente.codart = produit.codart
GROUP BY nomfou
ORDER BY stock DESC;

-- 18/ En fin d'année, sortir la liste des produits dont la quantité réellement
-- commandée dépasse 90% de la quantité annuelle prévue.

SELECT  libart,
		SUM(qtecde) AS 'Quantité' 
	FROM produit, ligcom
WHERE produit.codart = ligcom.codart
GROUP BY libart, qteann
HAVING (qteann * 0.90) < SUM(qtecde);

-- 19/ Calculer le chiffre d'affaire par fournisseur pour l'année 93 sachant
-- que les prix indiqués sont hors taxes et que le taux de TVA est 20%.

SELECT numfou, 
		SUM(qtecde * priuni *1.20) AS 'prix ttc'
FROM ligcom, entcom
WHERE entcom.numcom = ligcom.numcom
GROUP BY numfou;

-- 20/ Existe-t-il des lignes de commande non cohérentes avec les produits
-- vendus par les fournisseurs ?


/***** Exercices update : *****/


-- 1/ Application d'une augmentation de tarif de 4% pour le prix 1 et de 2%
-- pour le prix2 pour le fournisseur 9180

UPDATE vente
SET prix1 = prix1*1.04,
	 prix2 = prix2 *1.02
WHERE numfou = 9180;

-- 2/ Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est
-- null, en affectant a prix2 la valeur de prix1.

UPDATE vente
SET prix2 = prix1

WHERE prix2 = 0;

-- 3/ Mettre à jour le champ obscom en positionnant '*****' pour toutes les
-- commandes dont le fournisseur a un indice de satisfaction < 5

update entcom
join fournis ON fournis.numfou = entcom.numfou
SET obscom = ''
WHERE satisf < 5;

-- 4/ Suppression du produit I110

DELETE FROM vente
	WHERE codart='I110';

DELETE FROM produit
	WHERE codart='I110';

DELETE FROM ligcom
	WHERE codart='I110';

-- 5/ Suppression des entête de commande qui n'ont aucune ligne