/* REQUÊTE 6 — FORMATAGE (CONCAT, alias explicites)
   Objectif : afficher une "fiche événement" lisible + résumé d'inscription
*/
SELECT
  e.id_event                                                   AS `ID`,
  CONCAT('📌 ', e.titre)                                        AS `Titre`,
  CONCAT('📍 ', e.lieu)                                         AS `Lieu`,
  DATE_FORMAT(e.date_event, '%d/%m/%Y à %H:%i')                AS `Date`,
  CONCAT(e.capacite_max, ' places')                             AS `Capacité`,
  CONCAT(FORMAT(e.prix, 2), ' €')                               AS `Prix`,
  CONCAT(
    COUNT(i.id_registration), ' inscrit(s) (',
    COALESCE(SUM(i.statut_paiement='confirme'),0), ' confirmé(s), ',
    COALESCE(SUM(i.statut_paiement='en_attente'),0), ' en attente)'
  ) AS `Résumé inscriptions`,
  CONCAT(
    'CA confirmé : ',
    FORMAT(ROUND(SUM(CASE WHEN i.statut_paiement='confirme' THEN e.prix ELSE 0 END),2), 2),
    ' €'
  ) AS `Chiffre d’affaires`
FROM evenement e
LEFT JOIN inscription i ON i.id_event = e.id_event
GROUP BY e.id_event, e.titre, e.lieu, e.date_event, e.capacite_max, e.prix
ORDER BY e.date_event;