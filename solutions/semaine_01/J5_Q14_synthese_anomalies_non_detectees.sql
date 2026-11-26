-- ============================================================
-- Semaine 1 · J5 · Question 14
-- ============================================================
-- Requête de synthèse (CTE) : regrouper les anomalies IJ des questions 7 à 11 dans une seule liste
-- (id_paiement, type_anomalie, montant_indu), puis identifier celles absentes de la table controles.
-- Total de l'indu non détecté.
--
-- Base : data/v1/cpam_training_v1.db (SQLite)
-- Résultat : 6 ligne(s)
-- ============================================================

WITH anomalies_ij AS (

    -- QUESTION 7 : incoherence du montant brut
    SELECT
        p.id_paiement,
        'Montant brut incoherent' AS type_anomalie,
        ABS(p.montant_brut -
            p.nb_jours * p.montant_journalier) AS montant_indu
    FROM paiements_ij p
    WHERE ABS(p.montant_brut -
              p.nb_jours * p.montant_journalier) > 0.01

    UNION ALL

    -- QUESTION 8 : paiement hors periode de l'arret
    SELECT
        p.id_paiement,
        'Paiement hors periode' AS type_anomalie,
        (
            p.nb_jours -
            MAX(0,
                julianday(MIN(p.periode_fin, a.date_fin))
                -
                julianday(MAX(p.periode_debut, a.date_debut))
                + 1
            )
        ) * p.montant_journalier AS montant_indu
    FROM paiements_ij p
    INNER JOIN arrets_travail a
        ON p.id_arret = a.id_arret
    WHERE p.periode_debut < a.date_debut
       OR p.periode_fin > a.date_fin

    UNION ALL

    -- QUESTION 9 : depassement du plafond Maladie
    SELECT
        p.id_paiement,
        'Depassement plafond IJ' AS type_anomalie,
        (p.montant_journalier - 41.95) * p.nb_jours AS montant_indu
    FROM paiements_ij p
    INNER JOIN arrets_travail a
        ON p.id_arret = a.id_arret
    WHERE a.type_risque = 'Maladie'
      AND p.montant_journalier > 41.95

    UNION ALL

    -- QUESTION 10 : doublons de paiement
    SELECT
        d.id_paiement,
        'Doublon de paiement' AS type_anomalie,
        d.montant_brut AS montant_indu
    FROM (
        SELECT
            p.*,
            ROW_NUMBER() OVER (
                PARTITION BY
                    p.id_arret,
                    p.periode_debut,
                    p.periode_fin
                ORDER BY p.id_paiement
            ) AS rang_doublon,
            COUNT(*) OVER (
                PARTITION BY
                    p.id_arret,
                    p.periode_debut,
                    p.periode_fin
            ) AS nombre_paiements
        FROM paiements_ij p
        WHERE p.statut <> 'Annulé'
    ) d
    WHERE d.nombre_paiements >= 2
      AND d.rang_doublon > 1

    UNION ALL

    -- QUESTION 11 : paiement pendant la carence
    SELECT
        p.id_paiement,
        'Paiement en periode de carence' AS type_anomalie,
        (
            julianday(
                MIN(p.periode_fin, date(a.date_debut, '+2 days'))
            )
            -
            julianday(p.periode_debut)
            + 1
        ) * p.montant_journalier AS montant_indu
    FROM paiements_ij p
    INNER JOIN arrets_travail a
        ON p.id_arret = a.id_arret
    WHERE a.type_risque = 'Maladie'
      AND a.nature = 'Initial'
      AND p.periode_debut <= date(a.date_debut, '+2 days')
      AND p.periode_fin >= a.date_debut

),

anomalies_non_detectees AS (

    SELECT
        an.id_paiement,
        an.type_anomalie,
        an.montant_indu
    FROM anomalies_ij an
    LEFT JOIN controles c
        ON c.table_source = 'paiements_ij'
       AND c.id_reference = an.id_paiement
    WHERE c.id_reference IS NULL

)

SELECT
    id_paiement,
    type_anomalie,
    ROUND(montant_indu, 2) AS montant_indu,
    ROUND(SUM(montant_indu) OVER (), 2)
        AS total_indu_non_detecte
FROM anomalies_non_detectees
ORDER BY id_paiement, type_anomalie;
