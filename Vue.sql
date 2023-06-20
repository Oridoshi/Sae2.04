--====================================================================================================================--
--                                                        VUES                                                        --
--====================================================================================================================--

-- Q4.1.1. Créer une vue qui regroupe les enfants (numéros, prénoms) et les noms de leur centre.
Create or Replace View  Regroupe_Enfants AS
SELECT prenom_enf, code_enf, nom_c
FROM   Enfant e join Centre c on e.affecte = c.num_c;

-- Q4.1.2. Afficher, en utilisant la vue, les numéros et les prénoms des enfants, ainsi que noms de leur centres groupés.
SELECT * FROM Regroupe_Enfants;

-- Q4.1.3. Utiliser la vue pour afficher les numéros et prénoms des enfants qui sont au centre ‘rigaud’.
SELECT *
FROM Regroupe_Enfants
WHERE nom_c = 'rigaud';

-- Q4.2.1. Créer une vue v_enf16 contenant les enfants de moins de 16 ans (date de naissance '31/12/2006')
Drop View v_enf16;

Create or Replace View v_enf16 AS
SELECT *
FROM   Enfant
WHERE  date_naiss_enf >= '31/12/2006';

-- Q4.2.2. Afficher à l’aide de la vue les informations sur les enfants de moins de 16 ans et leur age.
SELECT prenom_enf as nom, DATE_PART('year', AGE(date_naiss_enf)) as age
FROM v_enf16;

-- Q4.3.1. Insérer, à travers la vue, dans la table enfant, un enfant de 20 ans. (exemple : 80, 'marcus', '01/03/1998', 101, 13, 3, 63).
insert into v_enf16( prenom_enf, date_naiss_enf, parent, affecte, mois_vacances, choix_vacances) values
('marcus', '01/03/1998', 3, 3, 3, 6);

-- Que constatez-vous ? Vérifiez en affichant le contenu de la table enfant.

-- Ont constate que comme l'enfant a plus de 16 ans mais que celui-ci est quand même inséré

-- Q4.3.2. Supprimer et recréer la vue pour éviter ce problème.
Create or Replace View v_enf16 AS
SELECT *
FROM   Enfant
WHERE  date_naiss_enf >= '31/12/2006'
With check option;

-- Q4.3.3. Vérifier que ce n’est pas possible d’insérer, à travers la vue, un tuple dans la table enfant, qui ne répond pas à la définition de la vue. Par exemple en insérant le tuple suivant : 99, 'Jacky', '31/12/1997', 102, 15, 2, 62.
insert into v_enf16( prenom_enf, date_naiss_enf, parent, affecte, mois_vacances, choix_vacances) values
('Jacky', '31/12/1997', 4, 5, 2, 5);

SELECT * FROM enfant;