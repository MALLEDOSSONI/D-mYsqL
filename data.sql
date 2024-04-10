-- Création de la base de données
CREATE DATABASE bdd_devoir_data2;

-- Utilisation de la base de données créée
USE bdd_devoir_data2;

-- Création de la table eleves
CREATE TABLE eleves (
    eleve_id INT(5) PRIMARY KEY AUTO_INCREMENT,
    eleve_nom VARCHAR(45),
    eleve_prenom VARCHAR(45)
);

-- Création de la table professeurs
CREATE TABLE professeurs (
    professeur_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    professeur_nom VARCHAR(50),
    professeur_prenom VARCHAR(50)
);

-- Création de la table rdv
CREATE TABLE rdv (
    rdv_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    eleve_id INT(11),
    matiere_id INT(11),
    prof_id INT(11),
    rdv_date DATE,
    rdv_h_deb TIME,
    rdv_h_fin TIME,
    FOREIGN KEY (eleve_id) REFERENCES eleves(eleve_id),
    FOREIGN KEY (matiere_id) REFERENCES matieres(matiere_id),
    FOREIGN KEY (prof_id) REFERENCES professeurs(professeur_id)
);

-- Création de la table matieres
CREATE TABLE matieres (
    matiere_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    matiere_nom VARCHAR(200),
    matiere_desc VARCHAR(250)
);

-- Création de la table enseigner
CREATE TABLE enseigner (
    enseigner_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    professeur_id INT(11),
    matiere_id INT(11),
    date_deb_ens DATE,
    date_fin_ens DATE,
    FOREIGN KEY (professeur_id) REFERENCES professeurs(professeur_id),
    FOREIGN KEY (matiere_id) REFERENCES matieres(matiere_id)
);

-- Création de la table cours
CREATE TABLE cours (
    cours_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    cours_nom VARCHAR(50),
    cours_desc VARCHAR(250),
    matiere_id INT(11),
    FOREIGN KEY (matiere_id) REFERENCES matieres(matiere_id)
);

-- Création de la table devoirs
CREATE TABLE devoirs (
    devoir_id INT(11) PRIMARY KEY AUTO_INCREMENT,
    devoir_nom VARCHAR(250),
    devoir_desc TEXT,
    cours_id INT(11),
    FOREIGN KEY (cours_id) REFERENCES cours(cours_id)
);


CREATE ROLE professeur;
GRANT SELECT, DELETE ON rdv TO professeur;
GRANT SELECT, INSERT, UPDATE ON cours TO professeur;

CREATE ROLE eleve;
GRANT SELECT, INSERT, UPDATE, DELETE ON rdv TO eleve;

-- Attribuer le rôle professeur à un utilisateur spécifique prof
GRANT professeur TO 'prof'@'localhost';

-- Attribuer le rôle élève à un utilisateur spécifique eleve
GRANT eleve TO 'eleve'@'localhost';

CREATE USER 'prof0'@'localhost' IDENTIFIED BY 'mot_de_passe_professeur';

CREATE USER 'eleve0'@'localhost' IDENTIFIED BY 'mot_de_passe_eleve';

GRANT professeur TO 'prof0'@'localhost';
GRANT eleve TO 'eleve0'@'localhost';

GRANT SELECT, INSERT, UPDATE ON cours TO 'prof0'@'localhost';
GRANT INSERT ON devoirs TO 'prof0'@'localhost';

