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

## 3) Plan de sécurité (à finaliser)

### Règles prioritaires
- Validation des entrées
- Gestion des exceptions
- Logique métier sûre (pas de secrets hardcodés)

### Actions proposées
- Ajout de tests sur les zones critiques
- Réduction des duplications
- Refactoring léger si complexité élevée
- Mise en place d’un rapport de couverture (Jacoco / Karma) pour remonter la couverture dans SonarCloud

## 4) Alertes prioritaires (extrait)

| Type | Règle / Message | Gravité | Emplacement | Action |
|---|---|---|---|---|
| Code smell | Refactor this asynchronous operation outside of the constructor | Critical | front/src/app/person-details/person-details.component.ts:L33 | Refactor (déplacer l’opération async hors du constructeur) |
| Code smell | Use a specific version tag for the image | Major | Dockerfile:L1 | Pinner les images (tag explicite) |
| Code smell | Replace "as" with upper case format "AS" | Major | Dockerfile:L1 | Mettre `AS` en majuscules |
| Code smell | Replace "as" with upper case format "AS" | Major | Dockerfile:L10 | Mettre `AS` en majuscules |
| Code smell | Replace "as" with upper case format "AS" | Major | Dockerfile:L18 | Mettre `AS` en majuscules |
| Code smell | Replace "as" with upper case format "AS" | Major | Dockerfile:L32 | Mettre `AS` en majuscules |
| Code smell | Replace "as" with upper case format "AS" | Major | Dockerfile:L44 | Mettre `AS` en majuscules |
| Code smell | Unexpected empty source | Major | front/src/app/app.component.css:L1 | Supprimer le fichier vide ou ajouter du style utile |
| Code smell | Unexpected empty source | Major | front/src/app/main-dashboard/main-dashboard.component.css:L1 | Supprimer le fichier vide ou ajouter du style utile |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/main-dashboard/main-dashboard.component.ts:L18 | Ajouter `readonly` |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/main-dashboard/main-dashboard.component.ts:L18 | Ajouter `readonly` |
| Code smell | Unexpected empty source | Major | front/src/app/organization-details/organization-details.component.css:L1 | Supprimer le fichier vide ou ajouter du style utile |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly` |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly` |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly` |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/organization-details/organization-details.component.ts:L26 | Ajouter `readonly` |
| Code smell | Member is never reassigned; mark it as `readonly` | Major | front/src/app/organization.service.ts:L10 | Ajouter `readonly` |
| Code smell | Unexpected empty source | Major | front/src/app/person-details/person-details.component.css:L1 | Supprimer le fichier vide ou ajouter du style utile |

> Note: certains éléments sont répétés avec plusieurs occurrences (Dockerfile, `readonly`).

---

## 5) Croisement SonarQube ↔ ELK (observations)
- **ELK** : 0 erreurs sur 15 jours. Aucun hotspot applicatif visible côté logs → priorité aux code smells Sonar (maintenabilité).
- **Pic INFO** : 3 événements à **11:26:20** (arrêt propre du pool DB) → lié à des logs d’infrastructure (Hikari). Pas d’issue Sonar critique associée.

---
