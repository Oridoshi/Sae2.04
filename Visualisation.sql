--====================================================================================================================--
--                                                   VISUALISATION                                                    --
--====================================================================================================================--

-- Lister les libellés et les prix des différents types de cadeaux.
\copy (SELECT lib_cad, prix_cad FROM Type_Cadeau) To './Q7.1.csv' DELIMITER ',' CSV HEADER

-- Afficher les noms des centres et le nombre d'enfants dans chaque centre.
\copy (SELECT c.nom_c as Centre, count(e.*) as NombreEnfant FROM Centre c Join Enfant e on c.num_c = e.affecte group by c.nom_c) To './Q7.2.csv'DELIMITER','CSV HEADER
