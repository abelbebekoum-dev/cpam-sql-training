-- ============================================================
-- Semaine 1 · J4 · Question 12
-- ============================================================
-- Doublons de facturation : même assuré, même professionnel, même acte, même date de soins.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 3 ligne(s)
-- ============================================================

SELECT
    p.id_assure,
    p.id_ps,
    p.code_acte,
    p.date_soins,
    COUNT(*)                                       AS nombre_facturations,
    GROUP_CONCAT(p.id_prestation, ', ')            AS prestations_concernees,
    ROUND(SUM(p.montant_rembourse), 2)             AS total_rembourse,
    ROUND(SUM(p.montant_rembourse)
          - MIN(p.montant_rembourse), 2)           AS montant_en_trop
FROM prestations p
GROUP BY p.id_assure, p.id_ps, p.code_acte, p.date_soins
HAVING COUNT(*) >= 2
ORDER BY montant_en_trop DESC;
