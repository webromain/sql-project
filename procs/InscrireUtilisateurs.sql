DELIMITER $$

CREATE PROCEDURE InscrireUtilisateur(IN user_id INT, event_id INT)
BEGIN
    DECLARE max_capacity INT;
    DECLARE actual_capacity INT;

    SELECT evenement.capacite_max INTO max_capacity
    FROM evenement
    WHERE evenement.id_event = event_id;

    SELECT COUNT(inscription.id_user) INTO actual_capacity
    FROM inscription
    WHERE inscription.id_event = event_id;

    IF max_capacity > actual_capacity THEN
        INSERT INTO inscription(id_user, id_event, date_inscription, statut_paiement)
        VALUES (user_id, event_id, SYSDATE(), 'en_attente');
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Capacite pleine';
    END IF;
END$$

DELIMITER ;