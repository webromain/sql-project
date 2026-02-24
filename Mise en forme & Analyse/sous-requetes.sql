/* REQUÊTE 3 — SOUS-REQUÊTE
   Objectif : afficher l'événement qui a le plus grand chiffre d’affaires
*/

SELECT
  t.id_event,
  t.titre,
  t.chiffre_affaires
FROM (
  SELECT
    e.id_event,
    e.titre,
    ROUND(SUM(CASE WHEN i.statut_paiement = 'confirme' THEN e.prix ELSE 0 END), 2) AS chiffre_affaires
  FROM evenement e
  LEFT JOIN inscription i ON i.id_event = e.id_event
  GROUP BY e.id_event, e.titre
) AS t
WHERE t.chiffre_affaires = (
  SELECT MAX(t2.chiffre_affaires)
  FROM (
    SELECT
      e2.id_event,
      ROUND(SUM(CASE WHEN i2.statut_paiement = 'confirme' THEN e2.prix ELSE 0 END), 2) AS chiffre_affaires
    FROM evenement e2
    LEFT JOIN inscription i2 ON i2.id_event = e2.id_event
    GROUP BY e2.id_event
  ) AS t2
);


