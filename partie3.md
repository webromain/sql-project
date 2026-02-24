# Projet EventHub - Partie 3 - Requêtes SQL et explications

---

## Requêtes simples

1) **Liste des événements triés par date**

```sql
SELECT id_event, titre, description, date_event, lieu, capacite_max, prix
FROM evenement
ORDER BY date_event ASC;
```

Explication : on récupère toutes les colonnes utiles de `evenement` et on trie par `date_event` en ordre croissant pour afficher les événements à venir du plus proche au plus lointain. Utiliser un index sur `date_event` améliore les performances de tri pour de grandes tables.

2) **Liste des utilisateurs inscrits après le 1er janvier 2024**

```sql
SELECT id_user, nom, prenom, email, date_inscription
FROM utilisateur
WHERE date_inscription > '2024-01-01'
ORDER BY date_inscription ASC;
```

Explication : on filtre sur `utilisateur.date_inscription`. Cette colonne existe dans la table `utilisateur` et stocke la date de création du compte. Le tri permet d'observer l'ordre d'arrivée.

3) **Événements dont le prix est supérieur à 50€**

```sql
SELECT id_event, titre, date_event, lieu, prix
FROM evenement
WHERE prix > 50.00
ORDER BY prix DESC;
```

Explication : on filtre simplement sur la colonne `prix` (type DECIMAL). Tri descendant pour montrer en premier les événements les plus chers. Vérifier la devise/normalisation si nécessaire (ici on suppose euros). Un index sur `prix` peut aider pour des filtres fréquents.

---

## Requêtes complexes

4) **Nombre d’inscrits par événement**

```sql
SELECT e.id_event, e.titre, COUNT(i.id_registration) AS nb_inscrits
FROM evenement e
LEFT JOIN inscription i ON e.id_event = i.id_event
GROUP BY e.id_event, e.titre
ORDER BY nb_inscrits DESC;
```

Explication : on fait une `LEFT JOIN` pour conserver les événements sans inscription (compte 0). La fonction d'agrégation `COUNT` sur l'identifiant d'inscription fournit le nombre d'inscrits. Le `GROUP BY` est nécessaire pour agréger par événement. Utiliser `COUNT(i.id_registration)` exclut les NULLs (événements sans inscription).

Justification d'optimisation : indexer `inscription.id_event` accélère les jointures et l'agrégation.

5) **Événements complets (capacité atteinte)**

```sql
SELECT e.id_event, e.titre, e.capacite_max, COUNT(i.id_registration) AS nb_inscrits
FROM evenement e
LEFT JOIN inscription i ON e.id_event = i.id_event
GROUP BY e.id_event, e.titre, e.capacite_max
HAVING nb_inscrits >= e.capacite_max;
```

Explication : similaire à la requête précédente, mais on utilise `HAVING` pour filtrer les groupes dont le nombre d'inscrits est supérieur ou égal à la capacité maximale (`capacite_max`). La `LEFT JOIN` permet de compter aussi correctement les événements sans inscriptions (nb_inscrits = 0). Si `capacite_max` peut être NULL, ajouter `COALESCE(e.capacite_max, 0)` pour éviter des comparaisons NULL.

6) **Top 3 événements les mieux notés**

```sql
SELECT e.id_event, e.titre, ROUND(AVG(a.note),2) AS moyenne_note, COUNT(a.id_review) AS nb_avis
FROM evenement e
JOIN avis a ON e.id_event = a.id_event
GROUP BY e.id_event, e.titre
HAVING nb_avis >= 1
ORDER BY moyenne_note DESC, nb_avis DESC
LIMIT 3;
```

Explication : on calcule la moyenne des notes (`AVG(a.note)`) pour chaque événement ayant au moins un avis. `ROUND` arrondit à deux décimales. Le tri se fait d'abord sur la moyenne décroissante, puis sur le nombre d'avis pour départager les égalités. `LIMIT 3` fournit le top 3.

7) **Utilisateurs inscrits à tous les événements d’un organisateur**

```sql
SELECT u.id_user, u.nom, u.prenom
FROM utilisateur u
WHERE NOT EXISTS (
  SELECT 1
  FROM session s
  WHERE s.id_speaker = :speaker_id
    AND NOT EXISTS (
      SELECT 1 FROM inscription i
      WHERE i.id_user = u.id_user
        AND i.id_event = s.id_event
    )
);
```

Explication : il s'agit d'une division relationnelle. Pour chaque utilisateur `u`, on vérifie qu'il n'existe pas d'événement (parmi ceux où le speaker intervient) auquel `u` n'est pas inscrit. Si aucune telle session n'existe, alors `u` est inscrit à tous les événements du speaker. Cette méthode respecte le schéma existant (`session` lie `speaker` et `event`).

8) **Speakers qui interviennent dans plusieurs événements**

```sql
SELECT sp.id_speaker, u.nom, u.prenom, COUNT(DISTINCT s.id_event) AS nb_evenements
FROM speaker sp
JOIN utilisateur u ON sp.id_user = u.id_user
JOIN session s ON sp.id_speaker = s.id_speaker
GROUP BY sp.id_speaker, u.nom, u.prenom
HAVING nb_evenements > 1
ORDER BY nb_evenements DESC;
```

Explication : on compte le nombre distinct d'événements (`id_event`) par speaker. On joint `speaker` à `utilisateur` pour afficher le nom du speaker. Le `HAVING` filtre ceux intervenant dans plusieurs événements. Indexer `session(id_speaker, id_event)` accélère cette requête.

---
