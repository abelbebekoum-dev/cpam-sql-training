-- ============================================================
-- Semaine 1 · J5 · Question 13
-- ============================================================
-- Arrêts qui se chevauchent pour un même assuré (auto-jointure) : les deux identifiants et le nombre
-- de jours en commun.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 8 ligne(s)
-- ============================================================

SELECT
    a1.id_assure,
    a1.id_arret AS id_arret_1,
    a2.id_arret AS id_arret_2,
    a1.date_debut AS debut_arret_1,
    a1.date_fin AS fin_arret_1,
    a2.date_debut AS debut_arret_2,
    a2.date_fin AS fin_arret_2,

    CAST(
        julianday(
            MIN(a1.date_fin, a2.date_fin)
        )
        -
        julianday(
            MAX(a1.date_debut, a2.date_debut)
        )
        + 1 AS INTEGER
    ) AS nombre_jours_communs

FROM arrets_travail a1

INNER JOIN arrets_travail a2
    ON a1.id_assure = a2.id_assure

WHERE a1.id_arret < a2.id_arret
  AND a1.date_debut <= a2.date_fin
  AND a2.date_debut <= a1.date_fin

ORDER BY nombre_jours_communs DESC;
