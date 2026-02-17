# Partie 2 — Étape 3 : Sécurité & Qualité (SonarQube)

## Objectif

Analyser les résultats SonarQube et finaliser le plan de sécurité.

---

## 1) Points à analyser

- **Vulnérabilités** (Security)
- **Bugs**
- **Code smells**
- **Duplications**
- **Complexité**
- **Couverture de tests**

### Résultats relevés (SonarCloud)

- **Vulnérabilités** : 0
- **Bugs** : 2
- **Code smells** : 39
- **Security Hotspots** : 2
- **Duplications** : 0.0%
- **Coverage** : non configurée (pas de rapport de couverture)

---

## 2) Méthode

1. Lancer une analyse SonarQube via la CI.
2. Relever 10 à 20 alertes prioritaires.
3. Classer par gravité (Critical, Major, Minor).

---

## 3) Plan de sécurité

### Règles prioritaires

- Validation des entrées
- Gestion des exceptions
- Logique métier sûre (pas de secrets hardcodés)

### Actions proposées

- Ajout de tests sur les zones critiques
- Réduction des duplications
- Refactoring léger si complexité élevée
- Mise en place d’un rapport de couverture (Jacoco / Karma) pour remonter la couverture dans SonarCloud

---

## 4) Alertes prioritaires (extrait)

| Type       | Règle / Message                                                 | Gravité  | Emplacement                                                              | Action                                                     |
| ---------- | --------------------------------------------------------------- | -------- | ------------------------------------------------------------------------ | ---------------------------------------------------------- |
| Code smell | Refactor this asynchronous operation outside of the constructor | Critical | front/src/app/person-details/person-details.component.ts:L33             | Refactor (déplacer l’opération async hors du constructeur) |
| Code smell | Use a specific version tag for the image                        | Major    | Dockerfile:L1                                                            | Pinner les images (tag explicite)                          |
| Code smell | Replace "as" with upper case format "AS"                        | Major    | Dockerfile:L1                                                            | Mettre `AS` en majuscules                                  |
| Code smell | Replace "as" with upper case format "AS"                        | Major    | Dockerfile:L10                                                           | Mettre `AS` en majuscules                                  |
| Code smell | Replace "as" with upper case format "AS"                        | Major    | Dockerfile:L18                                                           | Mettre `AS` en majuscules                                  |
| Code smell | Replace "as" with upper case format "AS"                        | Major    | Dockerfile:L32                                                           | Mettre `AS` en majuscules                                  |
| Code smell | Replace "as" with upper case format "AS"                        | Major    | Dockerfile:L44                                                           | Mettre `AS` en majuscules                                  |
| Code smell | Unexpected empty source                                         | Major    | front/src/app/app.component.css:L1                                       | Supprimer le fichier vide ou ajouter du style utile        |
| Code smell | Unexpected empty source                                         | Major    | front/src/app/main-dashboard/main-dashboard.component.css:L1             | Supprimer le fichier vide ou ajouter du style utile        |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/main-dashboard/main-dashboard.component.ts:L18             | Ajouter `readonly`                                         |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/main-dashboard/main-dashboard.component.ts:L18             | Ajouter `readonly`                                         |
| Code smell | Unexpected empty source                                         | Major    | front/src/app/organization-details/organization-details.component.css:L1 | Supprimer le fichier vide ou ajouter du style utile        |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly`                                         |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly`                                         |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly`                                         |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly`                                         |
| Code smell | Member is never reassigned; mark it as `readonly`               | Major    | front/src/app/organization.service.ts:L10                                | Ajouter `readonly`                                         |
| Code smell | Unexpected empty source                                         | Major    | front/src/app/person-details/person-details.component.css:L1             | Supprimer le fichier vide ou ajouter du style utile        |

> Note: certains éléments sont répétés avec plusieurs occurrences (Dockerfile, `readonly`).

---

## 5) Croisement SonarQube ↔ ELK (observations)

- **ELK** : 0 erreurs sur 15 jours. Aucun hotspot applicatif visible côté logs → priorité aux code smells Sonar (maintenabilité).
- **Pic INFO** : 3 événements à **11:26:20** (arrêt propre du pool DB) → lié à des logs d’infrastructure (Hikari). Pas d’issue Sonar critique associée.

---

## 6) Intégration de la gestion des secrets dans le pipeline CI/CD

### Étapes pour intégrer la gestion des secrets

1. **Choisir un gestionnaire de secrets** :
   - Exemples : **HashiCorp Vault**, **AWS Secrets Manager**, **Azure Key Vault**.

2. **Configurer le gestionnaire de secrets** :
   - Créer un coffre-fort pour stocker les secrets (ex. : clés API, mots de passe).
   - Définir des politiques d'accès pour restreindre l'accès aux secrets.

3. **Intégrer au pipeline CI/CD** :
   - Ajouter des étapes dans le pipeline pour récupérer les secrets au moment de l'exécution.
   - Exemple avec GitHub Actions :
     ```yaml
     - name: Récupérer les secrets depuis AWS Secrets Manager
       uses: aws-actions/aws-secretsmanager-get-secrets@v1
       with:
         secret-id: "my-secret-id"
         region: "us-east-1"
     ```
   - Exemple avec Azure Key Vault :
     ```yaml
     - name: Azure Key Vault
       uses: Azure/get-keyvault-secrets@v1
       with:
         keyvault: "my-keyvault-name"
         secrets: "my-secret-name"
     ```

4. **Utiliser les secrets dans les étapes suivantes** :
   - Passer les secrets comme variables d'environnement aux scripts ou commandes.
   - Exemple :
     ```yaml
     - name: Utiliser les secrets
       run: |
         echo "Utilisation du secret : ${{ secrets.MY_SECRET }}"
     ```

5. **Auditer régulièrement les secrets** :
   - Vérifier les accès et les journaux d'utilisation.
   - Mettre en place une rotation automatique des secrets.

---

## 7) Tests de sécurité

### Tests de sécurité

- Utilisation d'outils comme **OWASP ZAP** pour détecter les vulnérabilités dans les applications web.
- Tests de pénétration réguliers pour identifier les failles potentielles.
- Automatisation des tests de sécurité dans le pipeline CI/CD.

### Gestion des secrets

- Utilisation d'outils comme **HashiCorp Vault** ou **AWS Secrets Manager** pour stocker et gérer les secrets.
- Rotation régulière des clés d'accès et des mots de passe.
- Chiffrement des données sensibles en transit et au repos.
