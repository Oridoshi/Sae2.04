-------------------------------------------------------
-- cas NOTE
-------------------------------------------------------
-- script creer.sql
-- connexion a postgresql:    	$plsql di-a2-17
-- execution du script:		=>\i creer.sql
-- verif:			=>\dt
-------------------------------------------------------

--====================================================================================================================--
--                                                      CREATION                                                      --
--====================================================================================================================--


-- suppression des tables si elles existent déjà
DROP TABLE if exists cadeau        cascade ;
DROP TABLE if exists br_cadeau     cascade ;
DROP TABLE if exists enfant        cascade ;
DROP TABLE if exists centre        cascade ;
DROP TABLE if exists salarie       cascade ;
DROP TABLE if exists lieu          cascade ;
DROP TABLE if exists fournisseur   cascade ;
DROP TABLE if exists type_cadeau   cascade ;
DROP TABLE if exists etablissement cascade ;


-- creation de la table Etablissement
CREATE TABLE Etablissement(
	nom_et varchar(20) primary key,
	adr_et varchar(30)
);

-- creation de la table Type_Cadeau
CREATE TABLE Type_Cadeau(
	ref_cad   SERIAL        primary key,
	lib_cad   varchar(20) ,
	photo_cad varchar(200), -- lien de l'image
	prix_cad  float
);

-- creation de la table Fournisseur
CREATE TABLE Fournisseur(
	code_f   SERIAL       primary key,
	nom_f    varchar(20),
	adr_f    varchar(20),
	date_com date
);

-- creation de la table Lieu
CREATE TABLE Lieu (
	num_lieu  SERIAL      primary key,
	nom_lieu  varchar(20),
	type_lieu varchar(20) check (type_lieu in ('mer', 'montagne', 'campagne'))
);

-- creation de la table Salarie
CREATE TABLE Salarie(
	matricule_s   SERIAL       primary key,
	nom_s         varchar(20),
	tranche_impot integer      check (tranche_impot between 1 and 5),
	couple        integer      references Salarie(matricule_s),
	travaille     varchar(20)  not null references Etablissement (nom_et)
);

-- creation de la table Centre
CREATE TABLE Centre(
	num_c       SERIAL      primary key,
	nom_c       varchar(20),
	adr_c       varchar(20),
	tarif_c     float,
	capacite_c  integer,
	tranche_age integer,
	correspond  integer     references Lieu(num_lieu)
);

-- creation de la table Enfant
CREATE TABLE Enfant(
	code_enf       SERIAL      primary key,
	prenom_enf     varchar(20),
	date_naiss_enf date,
	parent         integer     references Salarie(matricule_s),
	affecte        integer     references Centre(num_c),
	choix_vacances integer     references Lieu(num_lieu),
	mois_vacances  integer     check (mois_vacances between 1 and 12 and choix_vacances != null)
);

-- creation de la table Br_Cadeau
CREATE TABLE Br_Cadeau(
	num_br    SERIAL  primary key,
	remplit   integer references Enfant(code_enf),
	reference integer references Type_Cadeau(ref_cad)
);

-- creation de la table Cadeau
CREATE TABLE Cadeau(
	num_cad  SERIAL  primary key,
	contient integer references Type_Cadeau(ref_cad),
	provient integer references Fournisseur(code_f)
);

--====================================================================================================================--
--                                                     INSERTION                                                      --
--====================================================================================================================--


-- suppression des tuples dans les tables
DELETE FROM salarie       ;
DELETE FROM etablissement ;
DELETE FROM enfant        ;
DELETE FROM br_cadeau     ;
DELETE FROM type_cadeau   ;
DELETE FROM cadeau        ;
DELETE FROM fournisseur   ;
DELETE FROM centre        ;
DELETE FROM lieu          ;

-- initialisation de la table Etablissement
INSERT INTO etablissement ( nom_et, adr_et )VALUES 
('saint-jo'         , 'rue de Lilas'           ),
('lambert'          , 'rue Massillon'          ),
('trocadero'        , 'square Jean'            ),
('tour montparnasse', 'rue des lois'           ),
('capitol'          , 'rue du poids'           ),
('franco-Belge'     , 'La Samaritaine'         ),
('volcan'           , 'rue de Paris'           ),
('sirius'           , 'cours de la république' );

-- initialisation de la table Type_Cadeau
INSERT INTO type_cadeau ( lib_cad, photo_cad, prix_cad ) VALUES 
('BALLON'    , 'https://pixabay.com/fr/vectors/football-balle-sport-le-football-157930/'             ,   2.13),
('POUPÉE'    , 'https://pixabay.com/fr/vectors/poup%c3%a9e-vaudou-%c3%a9pingles-poup%c3%a9e-4659327/',  42.00),
('SMARTPHONE', 'https://pixabay.com/fr/vectors/t%c3%a9l%c3%a9phone-intelligent-pomme-153650/'        , 123.45),
('PS5'       , 'https://pixabay.com/fr/vectors/playstation-ps4-ps5-contr%c3%b4leur-5326719/'         , 666.66),
('SOULIERS'  , 'https://pixabay.com/fr/vectors/chaussures-athl%c3%a9tiques-les-chaussures-25493/'    ,   3.17),
('ASPIRATEUR', 'https://pixabay.com/fr/vectors/vide-nettoyeur-nettoyage-travailler-24229/'           ,  69.69),
('TÉLÉ'      , 'https://pixabay.com/fr/vectors/surveiller-filtrer-plat-lcd-32743/'                   , 321.54);

-- initialisation de la table Fournisseur
INSERT INTO fournisseur ( nom_f, adr_f, date_com ) VALUES 
('marc'   , 'rue CASAUX'          , '18-05-2020'),
('eric'   , 'rue frenet'          , '31-03-2020'),
('marc'   , 'cours de la rue'     , '25-08-2021'),
('fabien' , 'hotel de ville'      , '13-12-2022'),
('jacques', 'patinoire'           , '15-09-2020'),
('antoine', 'boulevard des titans', '05-07-2021');

-- initialisation de la table Lieu
INSERT INTO lieu ( nom_lieu, type_lieu ) VALUES 
('grenoble', 'montagne'),
('andore'  , 'montagne'),
('nice'    , 'mer'     ),
('honfleur', 'campagne'),
('etretat' , 'mer'     ),
('harfleur', 'campagne');

-- initialisation de la table Salarie
INSERT INTO salarie (nom_s, tranche_impot, couple, travaille) VALUES
('Georges'  , 2, null, 'saint-jo'         ),
('Jean'     , 3, null, 'lambert'          ),
('Philippe' , 2,    5, 'tour montparnasse'),
('Corinne'  , 1, null, 'saint-jo'         ),
('Louisette', 2,    3, 'trocadero'        ),
('Sylvain'  , 4,    8, 'capitol'          ),
('Marie'    , 5, null, 'saint-jo'         ),
('Georges'  , 4,    6, 'sirius'           );

-- initialisation de la table Centre
INSERT INTO centre ( nom_c, adr_c, tarif_c, capacite_c, tranche_age, correspond ) VALUES 
('rigaud'   , 'rue de Paris'    , 14.39, 30, 20, 1),
('alouettes', 'rue de Rouen'    , 15.72, 50, 10, 3),
('soleil'   , 'avenue du soleil', 12.65, 70, 12, 5),
('praxie'   , 'square jannot'   ,  9.84, 90, 15, 2),
('redoit'   , 'cours Mimosa'    , 18.33, 20, 17, 4),
('montgeon' , 'rue du Prado'    , 10.00, 40, 18, 6),
('la ramet' , 'Arènes'          , 24.96, 60, 16, 1),
('sesquie'  , 'place Jenner'    , 37.56, 80, 13, 4);

-- initialisation de la table Enfant
INSERT INTO enfant ( prenom_enf, date_naiss_enf, parent, affecte, choix_vacances, mois_vacances ) VALUES
('juan'  , '15-01-1999', 5, 2,    1,    2 ),
('marc'  , '11-08-2020', 5, 4, null, null ),
('jean'  , '04-11-2009', 6, 6,    3, null ),
('cedric', '12-12-2012', 5, 8, null, null ),
('eric'  , '31-05-2018', 6, 1,    5,    4 ),
('juan'  , '17-11-2000', 7, 3, null, null ),
('cyril' , '14-10-2006', 5, 5,    6,    3 ),
('jannot', '03-08-2015', 6, 7, null, null ),
('remy'  , '14-08-1994', 7, 4,    2,    7 );

-- initialisation de la table Br_Cadeau
INSERT INTO br_cadeau ( remplit, reference ) VALUES 
(1, 2),
(3, 1),
(7, 5),
(8, 4),
(5, 6),
(6, 3);

-- initialisation de la table Cadeau
INSERT INTO cadeau ( contient, provient ) VALUES 
( 1, 2 ),
( 3, 4 ),
( 5, 6 ),
( 3, 1 ),
( 2, 3 ),
( 4, 5 ),
( 6, 2 ),
( 1, 1 ),
( 4, 6 );






