# Partie 2 — Étape 4 : Plan des mises à jour

## Objectif

Assurer la mise à jour régulière et sécurisée des dépendances et des composants de l'application.

---

## Dépendances à surveiller

- **Java** : Vérifier les versions de JDK et des bibliothèques utilisées.
- **Node.js** : Vérifier les dépendances front-end avec `npm outdated` ou `yarn outdated`.
- **Spring Boot** : Mettre à jour les versions après validation des tests.

---

## Processus de mise à jour

1. Créer une **branche dédiée** pour les mises à jour.
2. Mettre à jour les dépendances avec les outils appropriés (ex. : `npm install`, `mvn dependency:resolve`).
3. Exécuter une **CI complète** pour valider les mises à jour.
4. Vérifier les résultats SonarQube pour détecter d'éventuelles régressions.
5. Appliquer un **tag SemVer** et effectuer une release.
6. Déployer progressivement en environnement de test avant la production.

---

## Planification des mises à jour

- Planifier les mises à jour critiques en dehors des heures de pointe.
- Informer les parties prenantes des interruptions potentielles.
- Documenter les changements dans un changelog pour chaque release.

---

### Exemples d'outils et commandes pour les mises à jour

- **Java** :
  - Mettre à jour les dépendances avec Maven :
    ```bash
    mvn versions:use-latest-releases
    mvn clean install
    ```
  - Vérifier les dépendances obsolètes avec Gradle :
    ```bash
    ./gradlew dependencyUpdates
    ```

- **Node.js** :
  - Identifier les dépendances obsolètes :
    ```bash
    npm outdated
    ```
  - Mettre à jour les dépendances :
    ```bash
    npm update
    ```
  - Mettre à jour une dépendance spécifique :
    ```bash
    npm install <package-name>@latest
    ```
