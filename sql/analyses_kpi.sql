--Vue consolidée par prêt
CREATE OR REPLACE VIEW vue_suivi_prets AS
WITH remb_par_pret AS (
    SELECT
        id_pret,
        COALESCE(SUM(montant_rembourse_xof), 0) AS total_rembourse_xof
    FROM remboursements
    GROUP BY id_pret
)
SELECT
    p.id_pret,
    c.id_client,
    c.nom_complet,
    c.genre,
    c.age,
    CASE
        WHEN c.age < 35 THEN 'Jeune (< 35 ans)'
        WHEN c.age <= 50 THEN 'Adulte (35-50 ans)'
        ELSE 'Senior (> 50 ans)'
    END AS tranche_age,
    c.region,
    c.secteur_activite,
    p.statut_pret,
    p.montant_pret_xof,
    COALESCE(r.total_rembourse_xof, 0) AS montant_rembourse_xof,
    (p.montant_pret_xof - COALESCE(r.total_rembourse_xof, 0)) AS reste_a_rembourser_xof,
    ROUND(
        (COALESCE(r.total_rembourse_xof, 0) / p.montant_pret_xof) * 100,
        1
    ) AS taux_remboursement_pct,
    CASE
        WHEN p.statut_pret = 'En souffrance (> 90 j)' THEN 1
        ELSE 0
    END AS indicateur_par90
FROM prets p
INNER JOIN clients c ON p.id_client = c.id_client
LEFT JOIN remb_par_pret r ON p.id_pret = r.id_pret;

-- Indicateurs globaux du portefeuille
SELECT
    COUNT(*) AS nombre_prets,
    SUM(montant_pret_xof) AS montant_total_accorde_xof,
    SUM(montant_rembourse_xof) AS montant_total_recouvre_xof,
    SUM(reste_a_rembourser_xof) AS encours_global_xof,
    ROUND((SUM(montant_rembourse_xof) / SUM(montant_pret_xof)) * 100, 1) AS taux_recouvrement_global_pct,
    SUM(indicateur_par90) AS nb_prets_par90,
    ROUND(
        (SUM(CASE WHEN indicateur_par90 = 1 THEN reste_a_rembourser_xof ELSE 0 END)
         / NULLIF(SUM(reste_a_rembourser_xof), 0)) * 100,
        1
    ) AS part_encours_par90_pct
FROM vue_suivi_prets;

--performance et risque par région
SELECT
    region,
    COUNT(*) AS nb_prets,
    SUM(montant_pret_xof) AS total_accorde_xof,
    SUM(reste_a_rembourser_xof) AS total_encours_xof,
    SUM(indicateur_par90) AS prets_en_souffrance
FROM vue_suivi_prets
GROUP BY region
ORDER BY total_encours_xof DESC;

--Classement des clients selon leur encours restant dû
SELECT
    nom_complet,
    region,
    tranche_age,
    montant_pret_xof,
    reste_a_rembourser_xof,
    statut_pret,
    RANK() OVER (ORDER BY reste_a_rembourser_xof DESC) AS rang_encours
FROM vue_suivi_prets
WHERE reste_a_rembourser_xof > 0;

-- Contrôle qualité des données(Détection d'éventuels sur-remboursements (anomalie métier))
SELECT
    id_pret,
    nom_complet,
    montant_pret_xof,
    montant_rembourse_xof,
    (montant_rembourse_xof - montant_pret_xof) AS excedent_xof
FROM vue_suivi_prets
WHERE montant_rembourse_xof > montant_pret_xof;