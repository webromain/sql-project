/* Requete GROUP BY : 
Analyse par evenement : total inscriptions, inscription confirmées et CA genere 
*/


SELECT 
    e.id_event as id_event,
    e.titre as titre,
    DATE_FORMAT(e.date_event, '%Y-%m-%d') AS date_event,
    e.lieu as lieu,
    e.capacite_max as capacite_max,
    e.prix as prix_unitaire,
    COUNT(i.id_registration) as total_inscriptions,
    SUM(i.statut_paiement = 'confirme') as inscriptions_confirmees,
    SUM(i.statut_paiement = "en_attente") as inscriptions_en_attente,
    ROUND(SUM(CASE WHEN i.statut_paiement = 'confirme' THEN e.prix ELSE 0 END), 2) AS chiffre_affaires
FROM 
    evenement e
LEFT JOIN inscription i ON i.id_event = e.id_event
GROUP BY
    e.id_event, e.titre, e.date_event, e.lieu, e.capacite_max, e.prix
ORDER BY
    e.date_event;
