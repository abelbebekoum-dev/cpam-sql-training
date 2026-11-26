-- ============================================================
-- Semaine 1 · J3 · Question 9
-- ============================================================
-- Paiements d'arrêts Maladie dont le montant journalier dépasse le plafond de 41,95 € : montant versé
-- en trop.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 2 ligne(s)
-- ============================================================

SELECT
    p.id_paiement,
    p.id_arret,
    a.type_risque,
    p.montant_journalier,
    p.nb_jours,
    (p.montant_journalier - 41.95) * p.nb_jours AS trop_percu
FROM paiements_ij p
INNER JOIN arrets_travail a
    ON p.id_arret = a.id_arret
WHERE a.type_risque = 'Maladie'
  AND p.montant_journalier > 41.95
ORDER BY trop_percu DESC;
