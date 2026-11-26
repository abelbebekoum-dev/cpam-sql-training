-- ============================================================
-- Semaine 1 · J3 · Question 8
-- ============================================================
-- Paiements dont la période indemnisée sort des bornes de l'arrêt (avant date_debut ou après date_fin)
-- : nombre de jours payés à tort.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 2 ligne(s)
-- ============================================================

SELECT
    p.id_paiement,
    a.id_assure,
    p.id_arret,
    a.date_debut,
    a.date_fin,
    p.periode_debut,
    p.periode_fin,
    p.nb_jours,
    p.nb_jours -
    MAX(0,
        julianday(MIN(p.periode_fin, a.date_fin))
        - julianday(MAX(p.periode_debut, a.date_debut))
        + 1
    ) AS jours_payes_a_tort
FROM paiements_ij p
INNER JOIN arrets_travail a
    ON p.id_arret = a.id_arret
WHERE p.periode_debut < a.date_debut
   OR p.periode_fin > a.date_fin
ORDER BY jours_payes_a_tort DESC;
