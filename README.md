<p align="center">
   <img src="./front/src/favicon.png" width="192px" />
</p>

# MicroCRM (P7 - Développeur Full-Stack - Java et Angular - Mettez en œuvre l'intégration et le déploiement continu d'une application Full-Stack)

MicroCRM est une application de démonstration basique ayant pour objectif de servir de socle pour le module "P7 - Développeur Full-Stack". L'application est conçue pour illustrer la mise en œuvre d'une chaîne CI/CD complète, la conteneurisation et le déploiement d'une architecture Full-Stack Spring Boot / Angular.

## Prérequis

### Outils nécessaires

- [OpenJDK >= 17](https://openjdk.org/)
- [NPM >= 10.2.4](https://www.npmjs.com/)
- [Docker >= 20.x](https://www.docker.com/)
- [Docker Compose >= 2.x](https://docs.docker.com/compose/)

## Instructions d'installation

### Cloner le dépôt

```bash
git clone <url-du-repo>
cd <nom-du-repo>
```

### Backend

1. Se positionner dans le répertoire `back` :
   ```bash
   cd back
   ```
2. Construire le JAR :
   ```bash
   ./gradlew build
   ```
3. Démarrer le service :
   ```bash
   java -jar build/libs/microcrm-0.0.1-SNAPSHOT.jar
   ```
   L'API sera disponible sur `http://localhost:8080`.

### Frontend

1. Se positionner dans le répertoire `front` :
   ```bash
   cd front
   ```
2. Installer les dépendances NodeJS :
   ```bash
   npm install
   ```
3. Démarrer le service de développement :
   ```bash
   npm start
   ```
   L'application sera disponible sur `http://localhost:4200`.

## Instructions d'exécution

### Avec Docker Compose

Pour lancer **front + back** ensemble :

```bash
docker compose up --build
```

Arrêt :

```bash
docker compose down
```

### Démo locale (ELK + App)

1. Lancer la stack ELK :
   ```bash
   docker compose -f docker-compose-elk.yml up -d
   ```
2. Lancer l'application :
   ```bash
   docker compose up -d --build
   ```
3. Accès :
   - Kibana : `http://localhost:5601` (créer le data view `microcrm-*` si besoin)
   - Front : `https://localhost` (accepter le certificat auto-signé)
   - Back : `http://localhost:8080`

## Explication des choix techniques

### Pourquoi ces technologies ?

- **Caddy** : Simplicité et gestion automatique de HTTPS.
- **ELK** : Centralisation et visualisation des logs.
- **Docker** : Isolation et reproductibilité des environnements.

### Structure du projet

- `back/` : Contient le backend Spring Boot.
- `front/` : Contient le frontend Angular.
- `misc/` : Contient les configurations Docker et ELK.

## CI/CD

### Workflows

- **CI** : Build + tests front/back + analyse SonarCloud.
  - Fichier : `.github/workflows/ci.yml`
- **CD** : Build & push des images Docker sur GHCR.
  - Fichier : `.github/workflows/cd.yml`
- **Release (optionnel)** : Création de release GitHub + artefacts.
  - Fichier : `.github/workflows/release.yml`

### Déclenchement

- CI : Push et pull request sur `main`.
- CD : Tag SemVer `vX.Y.Z` (ex: `v1.2.3`) ou manuel.
- Release : Tag SemVer `vX.Y.Z`.

## Tests

### Backend

Exécuter les tests :

```bash
cd back
./gradlew test
```

### Frontend

Exécuter les tests :

```bash
cd front
npm test
```

## Sauvegarde et mises à jour

### Sauvegarde

- **Données Elasticsearch** : Utiliser l'outil Snapshot and Restore pour sauvegarder les index.
- **Fichiers critiques** : Sauvegarder les fichiers `docker-compose.yml`, `logstash.conf`, et les sources du projet.

### Mises à jour

- **Dépendances** :
  - Backend :
    ```bash
    ./gradlew dependencyUpdates
    ```
  - Frontend :
    ```bash
    npm outdated
    npm update
    ```
- **Images Docker** :
  ```bash
  docker compose pull
  docker compose up -d
  ```
