/* REQUÊTE 5 — CALCULS (Chiffre d'affaires par événement)
   - CA_confirmé : prix * nb_confirmés
   - CA_potentiel : prix * total inscriptions
   - Reste_à_encaisser : potentiel - confirmé
   - Taux_confirmation : confirmés / total
*/
SELECT
  e.id_event AS id_event,
  e.titre    AS titre,
  e.prix     AS prix_unitaire,
  COUNT(i.id_registration) AS total_inscriptions,
  COALESCE(SUM(i.statut_paiement='confirme'),0) AS nb_confirmes,
  COALESCE(SUM(i.statut_paiement='en_attente'),0) AS nb_en_attente,

  ROUND(COALESCE(SUM(CASE WHEN i.statut_paiement='confirme' THEN e.prix END),0), 2) AS ca_confirme,
  ROUND(e.prix * COUNT(i.id_registration), 2) AS ca_potentiel,
  ROUND((e.prix * COUNT(i.id_registration)) - COALESCE(SUM(CASE WHEN i.statut_paiement='confirme' THEN e.prix END),0), 2) AS reste_a_encaisser,

  CONCAT(
    ROUND(
      (COALESCE(SUM(i.statut_paiement='confirme'),0) / NULLIF(COUNT(i.id_registration),0)) * 100
    , 1),
    '%'
  ) AS taux_confirmation
FROM evenement e
LEFT JOIN inscription i ON i.id_event = e.id_event
GROUP BY e.id_event, e.titre, e.prix
ORDER BY ca_confirme DESC;