-- ============================================================
-- Semaine 1 · J1 · Question 1
-- ============================================================
-- Nombre d'assurés par département et par sexe, trié par département puis sexe.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 4 ligne(s)
-- ============================================================

SELECT
    departement,
    sexe,
    COUNT(*) AS nombre_assures
FROM assures
GROUP BY departement, sexe
ORDER BY departement ASC, sexe ASC;
