/* REQUÊTE 4 — FONCTIONS D’AGRÉGATION
   Objectif : note moyenne + nb d'avis + min/max par événement
*/
SELECT
  e.id_event AS id_event,
  e.titre    AS titre,
  COUNT(a.id_review)        AS nb_avis,
  ROUND(AVG(a.note), 2)     AS note_moyenne,
  MIN(a.note)               AS note_min,
  MAX(a.note)               AS note_max
FROM evenement e
LEFT JOIN avis a ON a.id_event = e.id_event
GROUP BY e.id_event, e.titre
ORDER BY note_moyenne DESC, nb_avis DESC;