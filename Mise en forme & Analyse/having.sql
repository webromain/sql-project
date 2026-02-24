/* 
REQUETE HAVING: 
montre uniquement les evenement avec au moins un inscription confirmé et un ca minimum a 50€
*/

SELECT
  e.id_event AS id_event,
  e.titre    AS titre,
  COUNT(i.id_registration)                         AS total_inscriptions,
  COALESCE(SUM(i.statut_paiement='confirme'),0)    AS nb_confirmes,
  ROUND(SUM(CASE WHEN i.statut_paiement='confirme' THEN e.prix ELSE 0 END),2) AS chiffre_affaires
FROM evenement e
LEFT JOIN inscription i ON i.id_event = e.id_event
GROUP BY e.id_event, e.titre
HAVING nb_confirmes >= 1 AND chiffre_affaires >= 50
ORDER BY chiffre_affaires DESC;
