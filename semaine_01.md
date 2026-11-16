# Semaine 1 — Prise en main de la base (16 → 20 novembre 2026)

Base : `data/v1/cpam_training_v1.db` (SQLite). Règles de gestion : page 2 du PDF.
Une requête = un fichier dans `solutions/semaine_01/` (ex. `J1_Q1_assures_par_departement.sql`), avec en commentaire le résultat obtenu (nombre de lignes, total).

Rappels SQLite : dates au format texte `AAAA-MM-JJ` ; écart en jours = `julianday(b) - julianday(a)` ; ajouter des jours = `date(x, '+3 days')`.

## Lundi — J1 · Agrégats simples
1. Nombre d'assurés par département et par sexe, trié par département puis sexe.
2. Arrêts reçus hors délai (plus de 48 h, soit plus de 2 jours) : `id_arret`, `id_assure`, `date_debut`, `date_reception`, nombre de jours de retard. Tri par retard décroissant.
3. Montant total des IJ au statut *Payé*, par type de risque, avec le nombre de paiements et le montant moyen (arrondi à 2 décimales).

## Mardi — J2 · Jointures
4. Pour **chaque** employeur (y compris ceux sans arrêt) : nombre de salariés ayant eu au moins un arrêt, et nombre total de jours d'arrêt (`date_fin - date_debut + 1`).
5. Assurés sans médecin traitant ayant eu au moins une prestation : identifiant, commune, nombre de prestations, total remboursé.
6. Prestations facturées par un professionnel au statut *Cessation* : détail de la prestation + spécialité du professionnel.

## Mercredi — J3 · Contrôles de cohérence IJ
7. Paiements dont `montant_brut` ≠ `nb_jours × montant_journalier` (tolérance 0,01 €) : afficher l'écart.
8. Paiements dont la période indemnisée sort des bornes de l'arrêt (avant `date_debut` ou après `date_fin`) : nombre de jours payés à tort.
9. Paiements d'arrêts *Maladie* dont le montant journalier dépasse le plafond de 41,95 € : montant versé en trop.

## Jeudi — J4 · Doublons et carence
10. Doublons de paiement : même arrêt, même période, au moins deux paiements non annulés.
11. Paiements en période de carence : arrêt *Maladie* + *Initial* dont la période payée commence avant `date_debut + 3 jours`. Calculer l'indu.
12. Doublons de facturation : même assuré, même professionnel, même acte, même date de soins.

## Vendredi — J5 · Synthèse maîtrise des risques
13. Arrêts qui se chevauchent pour un même assuré (auto-jointure) : les deux identifiants et le nombre de jours en commun.
14. **Requête de synthèse** (CTE) : regrouper les anomalies IJ des questions 7 à 11 dans une seule liste (`id_paiement`, `type_anomalie`, `montant_indu`), puis identifier celles **absentes** de la table `controles`. Total de l'indu non détecté.
15. Classement des prescripteurs par nombre total de jours d'arrêt prescrits (`RANK()`), avec leur part en % du total.

## Vendredi — Rapport Power BI n°1 : « Pilotage des IJ 2025 »
Importer les 8 CSV de `data/v1/csv/` (séparateur `;`, encodage UTF-8).
- Modèle en étoile : relier les tables selon la page 2 du PDF ; créer une table calendrier.
- Page 1 : cartes KPI (montant IJ payé, nombre d'arrêts, durée moyenne), courbe mensuelle des montants payés, répartition par type de risque, top 5 employeurs.
- Page 2 : contrôles par type d'anomalie et par statut, montant d'indu recouvré vs en cours.
- Export : capture PNG des pages dans `powerbi/semaine_01/` + le `.pbix`.
