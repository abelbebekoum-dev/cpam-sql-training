-- ============================================================
-- Semaine 1 · J4 · Question 11
-- ============================================================
-- Paiements en période de carence : arrêt Maladie + Initial dont la période payée commence avant
-- date_debut + 3 jours. Calculer l'indu.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 3 ligne(s)
-- ============================================================

SELECT
    p.id_paiement,
    p.id_arret,
    a.id_assure,
    a.date_debut,
    p.periode_debut,
    date(a.date_debut, '+3 days') AS premier_jour_indemnisable,
    CAST(julianday(date(a.date_debut, '+3 days'))
         - julianday(p.periode_debut) AS INTEGER) AS jours_carence_payes,
    ROUND((julianday(date(a.date_debut, '+3 days'))
           - julianday(p.periode_debut)) * p.montant_journalier, 2) AS indu
FROM paiements_ij p
INNER JOIN arrets_travail a
    ON p.id_arret = a.id_arret
WHERE a.type_risque = 'Maladie'
  AND a.nature = 'Initial'
  AND p.statut <> 'Annulé'
  AND p.periode_debut < date(a.date_debut, '+3 days')
ORDER BY indu DESC;
