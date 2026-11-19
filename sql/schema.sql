-- Nettoyage préalable si relance du script
DROP TABLE IF EXISTS remboursements;
DROP TABLE IF EXISTS prets;
DROP TABLE IF EXISTS clients;

-- 1. Table des clients / emprunteurs
CREATE TABLE clients (
    id_client        VARCHAR(20) PRIMARY KEY,
    nom_complet      VARCHAR(120) NOT NULL,
    genre            CHAR(1) NOT NULL CHECK (genre IN ('F', 'M')),
    age              INT NOT NULL CHECK (age >= 18),
    region           VARCHAR(60) NOT NULL,
    secteur_activite VARCHAR(80) NOT NULL,
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE
);

-- 2. Table des prêts accordés
CREATE TABLE prets (
    id_pret            VARCHAR(20) PRIMARY KEY,
    id_client          VARCHAR(20) NOT NULL REFERENCES clients(id_client),
    date_decaissement  DATE NOT NULL,
    date_echeance      DATE NOT NULL,
    montant_pret_xof   NUMERIC(14, 2) NOT NULL CHECK (montant_pret_xof > 0),
    taux_interet_pct   NUMERIC(5, 2) NOT NULL DEFAULT 10.00 CHECK (taux_interet_pct >= 0),
    statut_pret        VARCHAR(30) NOT NULL CHECK (
        statut_pret IN ('A jour', 'En souffrance (> 90 j)', 'Solde')
    ),
    CONSTRAINT chk_dates_pret CHECK (date_echeance >= date_decaissement)
);

-- 3. Table historique des remboursements
CREATE TABLE remboursements (
    id_remboursement     VARCHAR(20) PRIMARY KEY,
    id_pret              VARCHAR(20) NOT NULL REFERENCES prets(id_pret),
    date_remboursement   DATE NOT NULL,
    montant_rembourse_xof NUMERIC(14, 2) NOT NULL CHECK (montant_rembourse_xof >= 0),
    canal_paiement       VARCHAR(40) NOT NULL DEFAULT 'Mobile Money'
);