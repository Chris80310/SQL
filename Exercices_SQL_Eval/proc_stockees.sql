/*********************************************************************/
/*************** Programmer des procédures stockées ******************/
/*********************************************************************/

-- Une procédure stockée, aussi appelée 'stored procedure' en anglais, est un concept utilisé 
-- en administration de base de données afin d’exécuter un ensemble d’instructions SQL. 
-- Une telle procédure est stockée au sein du Système de Gestion de Base de Donneés (SGBD) 
--et peut être appelée à tout moment par son nom afin d’exécuter celle-ci.

-- Exercice 1 : création d'une procédure stockée sans paramètre

DELIMITER |
CREATE PROCEDURE Lst_fournis()
BEGIN
SELECT f.numfou, nomfou, p.codart, libart, priuni, qteliv FROM ligcom l
JOIN produit p ON p.codart = l.codart
JOIN vente v ON v.codart = p.codart
JOIN fournis f ON f.numfou = v.numfou
WHERE qteliv > 0
GROUP BY numfou;

END
DELIMITER ;
call Lst_fournis ;

-- Exercice 2 : création d'une procédure stockée avec un paramètre en entrée

DELIMITER |
CREATE PROCEDURE Lst_Commandes()
BEGIN
SELECT * FROM entcom
WHERE obscom LIKE 'c%';

END
DELIMITER ;

-- Exercice 3 : création d'une procédure stockée avec plusieurs paramètres

DELIMITER |
CREATE PROCEDURE CA_Fournisseur()
BEGIN
SELECT numfou, SUM(qtecde * priuni * 1.20) AS 'total ttc', derliv
FROM ligcom l, entcom e
WHERE e.numcom = l.numcom
GROUP BY derliv DESC;

END |DELIMITER ;
