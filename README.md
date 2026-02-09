<p align="center">
   <img src="./front/src/favicon.png" width="192px" />
</p>

# MicroCRM (P7 - Développeur Full-Stack - Java et Angular - Mettez en œuvre l'intégration et le déploiement continu d'une application Full-Stack)

MicroCRM est une application de démonstration basique ayant pour être objectif de servir de socle pour le module "P7 - Développeur Full-Stack".

L'application MicroCRM est une implémentation simplifiée d'un ["CRM" (Customer Relationship Management)](https://fr.wikipedia.org/wiki/Gestion_de_la_relation_client). Les fonctionnalités sont limitées à la création, édition et la visualisations des individus liés à des organisations.

![Page d'accueil](./misc/screenshots/screenshot_1.png)
![Édition de la fiche d'un individu](./misc/screenshots/screenshot_2.png)

## Sommaire
- [Code source](#code-source)
   - [Organisation](#organisation)
   - [Démarrer avec les sources](#démarrer-avec-les-sources)
   - [Exécution des tests](#exécution-des-tests)
   - [Images Docker](#images-docker)
   - [Docker Compose (recommandé)](#docker-compose-recommandé)
- [CI/CD (GitHub Actions)](#cicd-github-actions)
- [Documentation de la mission](#documentation-de-la-mission)

## Code source

### Organisation

Ce [monorepo](https://en.wikipedia.org/wiki/Monorepo) contient les 2 composantes du projet "MicroCRM":

- La partie serveur (ou "backend"), en Java SpringBoot 3;
- La partie cliente (ou "frontend"), en Angular 17.

### Démarrer avec les sources

#### Serveur

##### Dépendances

- [OpenJDK >= 17](https://openjdk.org/)

##### Procédure

1. Se positionner dans le répertoire `back` avec une invite de commande:

   ```shell
   cd back
   ```

2. Construire le JAR:

   ```shell
   # Sur Linux
   ./gradlew build

   # Sur Windows
   gradlew.bat build
   ```

3. Démarrer le service:

   ```shell
   java -jar build/libs/microcrm-0.0.1-SNAPSHOT.jar
   ```

Puis ouvrir l'URL http://localhost:8080 dans votre navigateur.

#### Client

##### Dépendances

- [NPM >= 10.2.4](https://www.npmjs.com/)

##### Procédure

1. Se positionner dans le répertoire `front` avec une invite de commande:

   ```shell
   cd front
   ```

2. (La première fois seulement) Installer les dépendances NodeJS:

   ```shell
   npm install
   ```

3. Démarrer le service de développement:

   ```shell
   npx @angular/cli serve
   ```

Puis ouvrir l'URL http://localhost:4200 dans votre navigateur.

### Exécution des tests

#### Client

**Dépendances**

- Google Chrome ou Chromium

Dans votre terminal:

```shell
cd front
CHROME_BIN=</path/to/google/chrome> npm test
```

#### Serveur

Dans votre terminal:

```shell
cd back
./gradlew test
```

### Images Docker

#### Client

##### Construire l'image

```shell
docker build --target front -t orion-microcrm-front:latest .
```

##### Exécuter l'image

```shell
docker run -it --rm -p 80:80 -p 443:443 orion-microcrm-front:latest
```

L'application sera disponible sur https://localhost.

#### Serveur

##### Construire l'image

```shell
docker build --target back -t orion-microcrm-back:latest .
```

##### Exécuter l'image

```shell
docker run -it --rm -p 8080:8080 orion-microcrm-back:latest
```

L'API sera disponible sur http://localhost:8080.

#### Tout en un

```shell
docker build --target standalone -t orion-microcrm-standalone:latest .
```

##### Exécuter l'image

```shell
docker run -it --rm -p 8080:8080 -p 80:80 -p 443:443 orion-microcrm-standalone:latest
```

L'application sera disponible sur https://localhost et l'API sur http://localhost:8080.

### Docker Compose (recommandé)

Pour lancer **front + back** ensemble :

```shell
docker compose up --build
```

Arrêt :

```shell
docker compose down
```

### Démo locale (ELK + App)

Ordre recommandé :

1) ELK

```shell
docker compose -f docker-compose-elk.yml up -d
```

2) App

```shell
docker compose up -d --build
```

3) Accès
- Kibana : http://localhost:5601 (créer le data view `microcrm-*` si besoin)
- Front : https://localhost (accepter le certificat auto‑signé)
- Back : http://localhost:8080

## CI/CD (GitHub Actions)

### Workflows

_CI trigger: 2026-02-06 (run #3)_

- **CI** : build + tests front/back + analyse SonarCloud
   - Fichier : `.github/workflows/ci.yml`
- **CD** : build & push des images Docker sur GHCR
   - Fichier : `.github/workflows/cd.yml`
- **Release (optionnel)** : création de release GitHub + artefacts
   - Fichier : `.github/workflows/release.yml`

### Secrets requis (SonarCloud)

Pour activer l’analyse SonarCloud, ajouter ces secrets dans GitHub :

- `SONAR_TOKEN`
- `SONAR_ORGANIZATION`
- `SONAR_PROJECT_KEY_BACK`
- `SONAR_PROJECT_KEY_FRONT`

### Déclenchement

- CI : push et pull request sur `main`
- CD : tag SemVer `vX.Y.Z` (ex: `v1.2.3`) ou manuel
- Release : tag SemVer `vX.Y.Z`

## Documentation de la mission

Les livrables de documentation sont dans le dossier `livrable/` :

### Partie 1
- Étapes CI/CD :
   - [livrable/Documentation CI-CD — Partie 1/Étapes de mise en œuvre CI-CD/etape3-ci.md](livrable/Documentation%20CI-CD%20—%20Partie%201/Étapes%20de%20mise%20en%20œuvre%20CI-CD/etape3-ci.md)
   - [livrable/Documentation CI-CD — Partie 1/Étapes de mise en œuvre CI-CD/etape5-cd.md](livrable/Documentation%20CI-CD%20—%20Partie%201/Étapes%20de%20mise%20en%20œuvre%20CI-CD/etape5-cd.md)
- Plan conteneurisation/déploiement :
   - [livrable/Documentation CI-CD — Partie 1/Plan de conteneurisation-déploiement/etape4-conteneurisation.md](livrable/Documentation%20CI-CD%20—%20Partie%201/Plan%20de%20conteneurisation-déploiement/etape4-conteneurisation.md)
- Plan de testing périodique :
   - [livrable/Documentation CI-CD — Partie 1/Plan de testing périodique/etape2-plans.md](livrable/Documentation%20CI-CD%20—%20Partie%201/Plan%20de%20testing%20périodique/etape2-plans.md)

### Partie 2
- KPI + métriques + analyse :
   - [livrable/Documentation CI-CD — Partie 2/KPI proposés + métriques + analyse/partie2-etape2-dora-kpi.md](livrable/Documentation%20CI-CD%20—%20Partie%202/KPI%20propos%C3%A9s%20+%20m%C3%A9triques%20+%20analyse/partie2-etape2-dora-kpi.md)
- Plan de sécurité :
   - [livrable/Documentation CI-CD — Partie 2/Plan de sécurité/partie2-etape3-securite-sonar.md](livrable/Documentation%20CI-CD%20—%20Partie%202/Plan%20de%20s%C3%A9curit%C3%A9/partie2-etape3-securite-sonar.md)
- Plan de sauvegarde :
   - [livrable/Documentation CI-CD — Partie 2/Plan de sauvegarde des données/partie2-etape4-plans.md](livrable/Documentation%20CI-CD%20—%20Partie%202/Plan%20de%20sauvegarde%20des%20donn%C3%A9es/partie2-etape4-plans.md)
- Plan des mises à jour :
   - [livrable/Documentation CI-CD — Partie 2/Plan des mises à jour/partie2-etape4-plans.md](livrable/Documentation%20CI-CD%20—%20Partie%202/Plan%20des%20mises%20%C3%A0%20jour/partie2-etape4-plans.md)

### Annexes
- Monitoring ELK : [livrable/partie2-etape1-elk.md](livrable/partie2-etape1-elk.md)
- Documentation finale : [livrable/partie2-etape5-doc-finale.md](livrable/partie2-etape5-doc-finale.md)
- Auto-évaluation : [livrable/partie2-etape6-auto-evaluation.md](livrable/partie2-etape6-auto-evaluation.md)

> Exigence livrables : indiquer “Option B” dans le titre du projet.
