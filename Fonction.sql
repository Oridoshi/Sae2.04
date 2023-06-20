--====================================================================================================================--
--                                                      FONCTION                                                      --
--====================================================================================================================--

-- Q6.1. Écrire une fonction SQL type_cadeau_NonResv sans paramètre et qui retourne les types de cadeaux qui n'ont pas fait l'objet de réservation par les enfants. 
Create or Replace Function type_cadeau_NonResv() returns setOf Type_Cadeau
as
$$
  SELECT *
  FROM Type_Cadeau t1
  WHERE NOT EXISTS (
    SELECT 1
    FROM Br_Cadeau t2
    WHERE t2.reference = t1.ref_cad)
$$ LANGUAGE SQL;


-- Donner deux versions.
Create or Replace Function type_cadeau_NonResv_V2() returns setOf Type_Cadeau
as
$$
  SELECT *
  FROM Type_Cadeau
  WHERE ref_cad not in ( SELECT reference
                         FROM   Br_Cadeau)
$$ LANGUAGE SQL;

-- Q6.2. Écrire une fonction SQL nombre_enfResv qui prend en paramètre ref_cad et qui retourne le nombre d'enfants qui ont réservé le type de cadeau ayant cette référence.
Create or Replace Function nombre_enfResv(typeCadeau Br_Cadeau.reference%Type) returns int
as
$$
  SELECT count(*)
  FROM   Br_Cadeau
  WHERE  typeCadeau = reference
$$ LANGUAGE SQL;