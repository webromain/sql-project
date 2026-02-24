DELIMITER $$

CREATE PROCEDURE TopSpeaker()
BEGIN
    SELECT utilisateur.nom, utilisateur.prenom, COUNT(session.id_session) AS nbr_sesssions FROM speaker
    INNER JOIN utilisateur ON utilisateur.id_user = speaker.id_user
    INNER JOIN session ON session.id_speaker = speaker.id_speaker
    WHERE utilisateur.role = 'intervenant'
    GROUP BY utilisateur.id_user, utilisateur.prenom, utilisateur.nom
    ORDER BY nbr_sesssions DESC;

END$$

DELIMITER ;