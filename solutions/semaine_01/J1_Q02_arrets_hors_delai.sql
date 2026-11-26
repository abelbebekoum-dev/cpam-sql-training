-- ============================================================
-- Semaine 1 · J1 · Question 2
-- ============================================================
-- Arrêts reçus hors délai (plus de 48 h, soit plus de 2 jours) : id_arret, id_assure, date_debut,
-- date_reception, nombre de jours de retard. Tri par retard décroissant.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 15 ligne(s)
-- ============================================================

SELECT
    id_arret,
    id_assure,
    date_debut,
    date_reception,
    CAST(julianday(date_reception) - julianday(date_debut) AS INTEGER) AS nombre_jours_retard
FROM arrets_travail
WHERE julianday(date_reception) - julianday(date_debut) > 2
ORDER BY nombre_jours_retard DESC;
