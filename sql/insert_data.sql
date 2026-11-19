-- Clients fictifs
INSERT INTO clients (id_client, nom_complet, genre, age, region, secteur_activite, date_inscription) VALUES
('CLT-001', 'Aminata Coulibaly',  'F', 28, 'Bamako',    'Commerce',    '2025-01-10'),
('CLT-002', 'Moussa Traoré',      'M', 41, 'Sikasso',   'Agriculture', '2025-01-15'),
('CLT-003', 'Fatoumata Diarra',   'F', 34, 'Segou',     'Artisanat',   '2025-02-01'),
('CLT-004', 'Oumar Koné',         'M', 54, 'Kayes',     'Elevage',     '2025-02-12'),
('CLT-005', 'Salimata Maïga',     'F', 25, 'Bamako',    'Commerce',    '2025-03-05'),
('CLT-006', 'Issa Sidibé',        'M', 46, 'Mopti',     'Commerce',    '2025-03-18'),
('CLT-007', 'Aïssata Keïta',      'F', 31, 'Koulikoro', 'Agriculture', '2025-04-02'),
('CLT-008', 'Boubacar Samaké',    'M', 38, 'Sikasso',   'Agriculture', '2025-04-20');

-- Prêts accordés
INSERT INTO prets (id_pret, id_client, date_decaissement, date_echeance, montant_pret_xof, taux_interet_pct, statut_pret) VALUES
('PRT-101', 'CLT-001', '2025-02-01', '2025-08-01',  500000, 10.0, 'A jour'),
('PRT-102', 'CLT-002', '2025-02-10', '2025-08-10',  750000, 12.0, 'En souffrance (> 90 j)'),
('PRT-103', 'CLT-003', '2025-02-15', '2025-07-15',  400000,  8.0, 'Solde'),
('PRT-104', 'CLT-004', '2025-03-01', '2025-09-01',  900000, 10.0, 'A jour'),
('PRT-105', 'CLT-005', '2025-03-15', '2025-09-15',  350000,  9.0, 'Solde'),
('PRT-106', 'CLT-006', '2025-04-01', '2025-10-01',  600000, 11.0, 'En souffrance (> 90 j)'),
('PRT-107', 'CLT-007', '2025-04-10', '2025-10-10', 1200000, 10.0, 'En souffrance (> 90 j)'),
('PRT-108', 'CLT-008', '2025-05-01', '2025-11-01',  800000, 10.0, 'A jour');

-- Remboursements enregistrés
INSERT INTO remboursements (id_remboursement, id_pret, date_remboursement, montant_rembourse_xof, canal_paiement) VALUES
('RMB-001', 'PRT-101', '2025-04-01', 200000, 'Orange Money'),
('RMB-002', 'PRT-101', '2025-06-01', 200000, 'Orange Money'),
('RMB-003', 'PRT-102', '2025-03-15', 250000, 'Moov Money'),
('RMB-004', 'PRT-103', '2025-05-10', 400000, 'Agence'),
('RMB-005', 'PRT-104', '2025-05-01', 300000, 'Orange Money'),
('RMB-006', 'PRT-104', '2025-07-01', 300000, 'Agence'),
('RMB-007', 'PRT-105', '2025-06-20', 350000, 'Orange Money'),
('RMB-008', 'PRT-106', '2025-05-20', 150000, 'Agence'),
('RMB-009', 'PRT-107', '2025-06-10', 400000, 'Orange Money'),
('RMB-010', 'PRT-108', '2025-07-15', 450000, 'Moov Money');