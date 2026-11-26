-- ============================================================
-- Semaine 1 · J3 · Question 7
-- ============================================================
-- Paiements dont montant_brut ≠ nb_jours × montant_journalier (tolérance 0,01 €) : afficher l'écart.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 2 ligne(s)
-- ============================================================

SELECT
    id_paiement,
    id_arret,
    nb_jours,
    montant_journalier,
    montant_brut,
    ABS(montant_brut - nb_jours * montant_journalier) AS ecart_paiement
FROM paiements_ij
WHERE ABS(montant_brut - nb_jours * montant_journalier) > 0.01
ORDER BY ecart_paiement DESC;
