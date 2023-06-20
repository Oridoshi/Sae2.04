--====================================================================================================================--
--                                                       DROIT                                                        --
--====================================================================================================================--

-- Q5.1. Supposons que vous êtes le propriétaire des toutes les tables. Écrire une commande SQL pour donner les droits SELECT, et UPDATE sur la table salarie à tous les utilisateurs
GRANT SELECT, UPDATE ON salarie TO all;

-- Q5.2. Écrire une commande SQL pour donner le droit UPDATE sur la colonne nom_etde la table etablissement à un camarade (soit xxxx), et qu’il puisse transmettre ce droit à tous les utilisateurs
GRANT UPDATE(nom_et) ON etablissement to xxxx;

-- Q5.3. Retirer le droit UPDATE sur la table salarie au compte xxxx.
REVOKE UPDATE ON salarie FROM xxxx;