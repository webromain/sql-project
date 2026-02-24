DELIMITER $$

CREATE PROCEDURE ChiffreAffairesEvent(IN event_id INT, OUT total_revenue DECIMAL(10,2))
BEGIN
    SELECT SUM(evenement.prix) INTO total_revenue
    FROM evenement
    INNER JOIN inscription ON evenement.id_event = inscription.id_event
    WHERE evenement.id_event = event_id;
END$$

DELIMITER ;