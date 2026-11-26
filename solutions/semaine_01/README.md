# Semaine 1 — Prise en main de la base

15 requêtes sur la base CPAM fictive v1 : agrégats, jointures, contrôles de cohérence des IJ, doublons, carence, synthèse en CTE.

| Jour | Question | Requête | Lignes |
|---|---|---|---|
| J1 | Q1 | [assures par departement sexe](J1_Q01_assures_par_departement_sexe.sql) | 4 |
| J1 | Q2 | [arrets hors delai](J1_Q02_arrets_hors_delai.sql) | 15 |
| J1 | Q3 | [ij payees par risque](J1_Q03_ij_payees_par_risque.sql) | 3 |
| J2 | Q4 | [jours arret par employeur](J2_Q04_jours_arret_par_employeur.sql) | 15 |
| J2 | Q5 | [assures sans medecin traitant](J2_Q05_assures_sans_medecin_traitant.sql) | 2 |
| J2 | Q6 | [prestations ps en cessation](J2_Q06_prestations_ps_en_cessation.sql) | 6 |
| J3 | Q7 | [montant brut incoherent](J3_Q07_montant_brut_incoherent.sql) | 2 |
| J3 | Q8 | [paiements hors periode](J3_Q08_paiements_hors_periode.sql) | 2 |
| J3 | Q9 | [depassement plafond maladie](J3_Q09_depassement_plafond_maladie.sql) | 2 |
| J4 | Q10 | [doublons paiement](J4_Q10_doublons_paiement.sql) | 3 |
| J4 | Q11 | [paiements carence](J4_Q11_paiements_carence.sql) | 3 |
| J4 | Q12 | [doublons facturation](J4_Q12_doublons_facturation.sql) | 3 |
| J5 | Q13 | [chevauchements arrets](J5_Q13_chevauchements_arrets.sql) | 8 |
| J5 | Q14 | [synthese anomalies non detectees](J5_Q14_synthese_anomalies_non_detectees.sql) | 6 |

## Ce que montre cette semaine
- Jointures internes, externes et auto-jointures
- Agrégats avec `GROUP BY` / `HAVING`, fonctions de fenêtrage (`ROW_NUMBER`, `COUNT() OVER`)
- Contrôles métier : carence, plafond IJ, périodes hors arrêt, doublons de paiement et de facturation
- Requête de synthèse en CTE : anomalies IJ non détectées par le service de contrôle et indu associé
