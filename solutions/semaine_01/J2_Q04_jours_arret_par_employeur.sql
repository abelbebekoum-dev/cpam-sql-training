-- ============================================================
-- Semaine 1 · J2 · Question 4
-- ============================================================
-- Pour chaque employeur (y compris ceux sans arrêt) : nombre de salariés ayant eu au moins un arrêt,
-- et nombre total de jours d'arrêt (date_fin - date_debut + 1).
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 15 ligne(s)
-- ============================================================

SELECT
    e.id_employeur,
    e.raison_sociale,
    COUNT(DISTINCT ar.id_assure) AS nombre_salaries_avec_arret,
    COALESCE(
        SUM(
            CAST(
                julianday(ar.date_fin) - julianday(ar.date_debut) + 1
                AS INTEGER
            )
        ),
        0
    ) AS nombre_total_jours
FROM employeurs e
LEFT JOIN assures a
    ON e.id_employeur = a.id_employeur
LEFT JOIN arrets_travail ar
    ON a.id_assure = ar.id_assure
GROUP BY
    e.id_employeur,
    e.raison_sociale
ORDER BY e.id_employeur ASC;
