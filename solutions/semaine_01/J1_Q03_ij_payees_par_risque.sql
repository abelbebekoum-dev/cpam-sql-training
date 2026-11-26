-- ============================================================
-- Semaine 1 · J1 · Question 3
-- ============================================================
-- Montant total des IJ au statut Payé, par type de risque, avec le nombre de paiements et le montant
-- moyen (arrondi à 2 décimales).
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 3 ligne(s)
-- ============================================================

SELECT
    a.type_risque,
    COUNT(*) AS nombre_paiements,
    ROUND(SUM(p.montant_brut),2) AS montant_total_ij,
    ROUND(AVG(p.montant_brut), 2) AS montant_moyen
FROM paiements_ij p
INNER JOIN arrets_travail a
    ON p.id_arret = a.id_arret
WHERE p.statut = 'Payé'
GROUP BY a.type_risque
ORDER BY montant_total_ij DESC;
