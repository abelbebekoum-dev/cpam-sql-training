-- ============================================================
-- Semaine 1 · J4 · Question 10
-- ============================================================
-- Doublons de paiement : même arrêt, même période, au moins deux paiements non annulés.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 3 ligne(s)
-- ============================================================

SELECT
    p.id_arret,
    a.id_assure,
    p.periode_debut,
    p.periode_fin,
    COUNT(*) AS nombre_paiements
FROM paiements_ij p
INNER JOIN arrets_travail a
    ON p.id_arret = a.id_arret
WHERE p.statut <> 'Annulé'
GROUP BY
    p.id_arret,
    a.id_assure,
    p.periode_debut,
    p.periode_fin
HAVING COUNT(*) >= 2
ORDER BY nombre_paiements DESC;
