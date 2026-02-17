# Partie 2 — Étape 4 : Plan de sauvegarde des données

## Objectif

Assurer la sécurité et la disponibilité des données critiques de l'application.

---

## Données à sauvegarder

- Données applicatives (si base de données externalisée).
- Configurations et fichiers de déploiement (docker-compose, fichiers d'environnement).

---

## Fréquence

- **Quotidienne** (minimum).
- Sauvegarde avant chaque release.

---

## Méthodes de sauvegarde

- Export de la base de données :
  - **PostgreSQL** : Utiliser `pg_dump` pour exporter les bases de données.
  - **MySQL** : Utiliser `mysqldump` pour les sauvegardes.
- Snapshot des volumes Docker :
  - Utiliser `docker volume inspect` et `docker run` pour créer des snapshots.
- Stockage sécurisé :
  - Utiliser un stockage chiffré (exemple : NAS ou Cloud interne).

---

## Plan de restauration

1. Identifier les données à restaurer.
2. Récupérer les sauvegardes depuis le stockage sécurisé.
3. Restaurer les bases de données avec les outils appropriés (ex. : `pg_restore`, `mysql`).
4. Vérifier l'intégrité des données restaurées.
5. Relancer les services applicatifs et valider leur bon fonctionnement.
