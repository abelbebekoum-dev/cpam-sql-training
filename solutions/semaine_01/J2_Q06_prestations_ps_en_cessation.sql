-- ============================================================
-- Semaine 1 · J2 · Question 6
-- ============================================================
-- Prestations facturées par un professionnel au statut Cessation : détail de la prestation +
-- spécialité du professionnel.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 6 ligne(s)
-- ============================================================

SELECT
    p.id_prestation,
    p.id_assure,
    p.id_ps,
    ps.specialite,
    p.code_acte,
    p.date_soins,
    p.date_liquidation,
    p.montant_depense,
    p.base_remboursement,
    p.taux_applique,
    p.montant_rembourse
FROM prestations p
INNER JOIN professionnels_sante ps
    ON p.id_ps = ps.id_ps
WHERE ps.statut = 'Cessation'
ORDER BY p.date_soins ASC;
