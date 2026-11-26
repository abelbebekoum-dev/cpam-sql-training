-- ============================================================
-- Semaine 1 · J2 · Question 5
-- ============================================================
-- Assurés sans médecin traitant ayant eu au moins une prestation : identifiant, commune, nombre de
-- prestations, total remboursé.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 2 ligne(s)
-- ============================================================

SELECT
    a.id_assure,
    a.commune,
    COUNT(pr.id_prestation) AS nombre_prestations,
    SUM(pr.montant_rembourse) AS total_rembourse
FROM assures a
INNER JOIN prestations pr
    ON a.id_assure = pr.id_assure
WHERE a.id_medecin_traitant IS NULL
GROUP BY
    a.id_assure,
    a.commune
ORDER BY total_rembourse DESC;
