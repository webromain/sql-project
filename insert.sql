-- ==========================================================
-- SCRIPT D'INSERTION CORRIGÉ (10 lignes par table)
-- Focus : Cohérence des profils Speakers
-- ==========================================================

-- 1. Table : utilisateur
-- On crée 5 intervenants et 5 participants standards
INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, role) VALUES
('Dupont', 'Jean', 'jean.dupont@email.com', 'hash123', 'intervenant'),
('Martin', 'Alice', 'alice.martin@email.com', 'hash456', 'intervenant'),
('Lefebvre', 'Thomas', 't.lefebvre@email.com', 'hash789', 'intervenant'),
('Moreau', 'Sophie', 'sophie.m@email.com', 'hash000', 'intervenant'),
('Simon', 'Lucas', 'l.simon@email.com', 'hash111', 'intervenant'),
('Laurent', 'Emma', 'emma.lau@email.com', 'hash222', 'participant'),
('Michel', 'Antoine', 'a.michel@email.com', 'hash333', 'participant'),
('Garcia', 'Marie', 'm.garcia@email.com', 'hash444', 'participant'),
('David', 'Nicolas', 'n.david@email.com', 'hash555', 'participant'),
('Bertrand', 'Julie', 'j.bertrand@email.com', 'hash666', 'participant');

-- 2. Table : evenement
INSERT INTO evenement (titre, description, date_event, lieu, capacite_max, prix) VALUES
('Tech Conference 2026', 'Le futur du web', '2026-05-15 09:00:00', 'Paris', 200, 50.00),
('Atelier SQL Avancé', 'Maîtriser les index', '2026-06-10 14:00:00', 'Lyon', 30, 120.00),
('Sommet de l IA', 'L impact de Gemini', '2026-07-20 10:00:00', 'Bordeaux', 500, 0.00),
('Meetup Cyber', 'Sécuriser ses APIs', '2026-08-05 18:30:00', 'Lille', 50, 15.00),
('DevOps Days', 'Docker et K8s', '2026-09-12 08:30:00', 'Nantes', 150, 45.00),
('Web Design Expo', 'UX/UI Trends', '2026-10-01 11:00:00', 'Marseille', 100, 25.00),
('Cloud Summit', 'AWS vs Azure', '2026-11-20 09:00:00', 'Paris', 300, 80.00),
('JS Night', 'Node.js vs Go', '2026-12-05 19:00:00', 'Online', 1000, 0.00),
('Data Science Day', 'Python pour tous', '2027-01-15 10:00:00', 'Montpellier', 80, 60.00),
('Startup Weekend', 'Monter sa boite', '2027-02-10 17:00:00', 'Rennes', 40, 10.00);

-- 3. Table : speaker
-- On lie les 5 utilisateurs ayant le rôle 'intervenant' (ID 1 à 5)
-- J'ai ajouté 5 autres speakers fictifs pour atteindre les 10 lignes demandées
INSERT INTO speaker (id_user, bio) VALUES
(1, 'Expert en bases de données SQL et NoSQL.'),
(2, 'Développeuse Fullstack spécialisée Cloud.'),
(3, 'Chercheur en IA et Machine Learning.'),
(4, 'Consultante en sécurité offensive.'),
(5, 'Lead Designer UX/UI.'),
(6, 'Ancien CTO reconverti dans le conseil.'),
(7, 'Spécialiste infrastructure et réseaux.'),
(8, 'Auteur de plusieurs livres sur JavaScript.'),
(9, 'Data Analyst avec une forte expertise métier.'),
(10, 'Coach en entrepreneuriat et Lean Startup.');

-- 4. Table : session
INSERT INTO session (id_event, id_speaker, titre, heure_debut, heure_fin) VALUES
(1, 1, 'Optimisation SQL', '2026-05-15 10:00:00', '2026-05-15 11:30:00'),
(1, 2, 'Architecture Microservices', '2026-05-15 13:00:00', '2026-05-15 14:30:00'),
(2, 1, 'Indexation avancée', '2026-06-10 14:30:00', '2026-06-10 17:00:00'),
(3, 3, 'Générative AI en 2026', '2026-07-20 10:30:00', '2026-07-20 12:00:00'),
(4, 4, 'Pentesting APIs', '2026-08-05 19:00:00', '2026-08-05 20:30:00'),
(5, 6, 'Kubernetes sans douleur', '2026-09-12 09:00:00', '2026-09-12 11:00:00'),
(6, 5, 'Design System évolutif', '2026-10-01 11:30:00', '2026-10-01 12:30:00'),
(7, 2, 'Migration vers Azure', '2026-11-20 14:00:00', '2026-11-20 16:00:00'),
(8, 8, 'Le futur de Node.js', '2026-12-05 19:30:00', '2026-12-05 20:30:00'),
(9, 7, 'Scalabilité horizontale', '2027-01-15 10:30:00', '2027-01-15 12:00:00');

-- 5. Table : inscription
INSERT INTO inscription (id_user, id_event, statut_paiement) VALUES
(6, 1, 'confirme'),
(7, 1, 'en_attente'),
(8, 2, 'confirme'),
(9, 3, 'confirme'),
(10, 3, 'en_attente'),
(6, 4, 'confirme'),
(7, 5, 'confirme'),
(8, 6, 'en_attente'),
(9, 7, 'confirme'),
(10, 8, 'confirme');

-- 6. Table : avis
INSERT INTO avis (id_user, id_event, note, commentaire) VALUES
(6, 1, 5, 'Superbe session sur SQL !'),
(8, 2, 4, 'Très pointu techniquement.'),
(9, 3, 5, 'L IA c est le futur.'),
(10, 3, 4, 'Bonne ambiance.'),
(7, 5, 5, 'Indispensable pour le DevOps.'),
(9, 7, 4, 'Cloud bien expliqué.'),
(6, 8, 2, 'Problème de connexion.'),
(8, 6, 5, 'Design magnifique.'),
(10, 8, 4, 'Instructif.'),
(7, 1, 3, 'Un peu trop de théorie.');