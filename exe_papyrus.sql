<----exos1------
SELECT numcom AS NumeroCommande, 
	   nomfou AS Fournisseur

	FROM ligcom
NATURAL JOIN entcom, fournis

WHERE fournis.numfou = 9120 AND entcom.numfou = 9120;

-----exos2--------

SELECT numfou AS IDFournisseur, 
       nomfou AS NomFournisseur 
	FROM fournis
NATURAL JOIN entcom
GROUP BY nomfou;

-------exos3-------

SELECT nomfou AS 'Nom fournisseur',
		 COUNT(numcom) AS 'Commande passée'
	FROM entcom
NATURAL JOIN fournis
GROUP BY nomfou;

-------exos4-------

SELECT codart AS 'n° produit', 
	  	 libart AS 'libellé produit', 
		 stkphy AS 'stock actuel', 
		 stkale AS 'quantité alerte', 
		 qteann AS 'quantité annuelle'

	FROM produit
WHERE stkphy < stkale AND qteann < 1000;

------exos5---------

SELECT posfou AS 'Département fournisseur',
		 nomfou AS 'Nom fournisseur'
	FROM fournis
ORDER BY posfou DESC, nomfou ASC;

--------exos6-------

SELECT numcom AS 'numéro de commande',
	   datcom AS 'date de commande'
		
	FROM entcom
WHERE MONTH (datcom) in (3,4);

--------exos7--------

SELECT numcom AS 'Numéro de commande',
		datcom AS 'Date de commande',
		obscom AS 'Commentaire commande'
		FROM entcom
WHERE obscom != '';

-------exos8--------

SELECT  numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
	
GROUP BY numcom;

-------ou-------

SELECT numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
	
ORDER BY numcom;

-------exos9--------

SELECT numcom AS 'Numéro de commande',
		(qtecde*priuni) AS 'Prix total'
		
	FROM ligcom
WHERE  (qtecde*priuni) >10000 AND qtecde <= 1000

ORDER BY numcom;

--------EXOS10---------

SELECT  numfou AS 'Fournisseur',
		numcom AS 'Numéro de commande',
		datcom AS 'Date de commande'
	FROM entcom
ORDER BY numfou;

--------exos11----------

SELECT numcom AS 'Numéro de commande',
		numfou AS 'Fournisseur',
		codart AS 'Libellé produit',
		(qtecde*priuni) AS 'Total commande',
		obscom
	FROM ligcom
natural JOIN entcom

WHERE obscom LIKE '%urgente%'

---------exos12----------
SELECT nomfou AS 'Founisseur'
		
	FROM fournis
NATURAL JOIN entcom,vente,ligcom
WHERE qteliv != 0
GROUP BY nomfou;

---------ou--------

SELECT nomfou AS 'Fournisseur'

	FROM fournis
NATURAL JOIN entcom, ligcom, produit, vente
WHERE qte1 >= 1
GROUP BY nomfou;

---------exos13----------

SELECT  numcom AS 'Numéro de Commande',
		datcom AS 'Date de Commande'
	FROM ligcom
NATURAL JOIN entcom, fournis
WHERE nomfou = (
    SELECT nomfou
	 	FROM fournis
    NATURAL JOIN entcom
    WHERE numcom = 70210);

---------ou---------

SELECT  entcom.numcom AS 'Numéro de Commande',
		datcom AS 'Date de Commande'
	FROM ligcom
	
INNER JOIN entcom ON entcom.numcom = ligcom.numcom
INNER JOIN fournis ON entcom.numfou = fournis.numfou;

---------exos14-----------

SELECT libart, prix1
	FROM produit
JOIN vente ON produit.codart = vente.codart

WHERE prix1 < (

    SELECT MIN(prix1)
    FROM produit
    JOIN vente ON produit.codart = vente.codart
    WHERE LEFT(libart, 1) IN ( 'R', 'r'));

---------exos15----------

SELECT  libart AS 'libellé article',
		nomfou AS 'fournisseur'
	FROM produit
JOIN vente ON produit.codart = vente.codart
JOIN fournis ON vente.numfou = fournis.numfou

WHERE stkphy <=(stkale*1.5)
ORDER BY  libart, numfou;

----------exos16----------

SELECT  nomfou AS 'fournisseur',
		libart AS 'libellé article',
		 delliv AS 'délai de livraison'
	FROM produit
JOIN vente ON produit.codart = vente.codart
JOIN fournis ON vente.numfou = fournis.numfou

WHERE stkphy <=(stkale*1.5) AND delliv <= 30
ORDER BY  nomfou, libart;

---------exos17---------

SELECT nomfou,
		SUM(STKPHY) AS 'stock'
	FROM vente,produit,fournis

WHERE vente.codart = produit.codart
GROUP BY nomfou
ORDER BY stock DESC;

--------exos18---------

SELECT  libart,
		SUM(qtecde) AS 'Quantité' 
	FROM produit, ligcom
WHERE produit.codart = ligcom.codart
GROUP BY libart, qteann
HAVING (qteann * 0.90) < SUM(qtecde);

---------exos19----------

SELECT numfou, 
		SUM(qtecde * priuni *1.20) AS 'prix ttc'
FROM ligcom, entcom
WHERE entcom.numcom = ligcom.numcom
GROUP BY numfou;


                            --------modificationTable--------

--------exos1--------

UPDATE vente
SET prix1 = prix1*1.04,
	 prix2 = prix2 *1.02
WHERE numfou = 9180;

--------exos2--------

UPDATE vente
SET prix2 = prix1

WHERE prix2 = 0;

--------exos3--------

update entcom
join fournis ON fournis.numfou = entcom.numfou
SET obscom = ''
WHERE satisf < 5;

--------exos4--------

DELETE FROM vente
	WHERE codart='I110';

DELETE FROM produit
	WHERE codart='I110';

DELETE FROM ligcom
	WHERE codart='I110';
