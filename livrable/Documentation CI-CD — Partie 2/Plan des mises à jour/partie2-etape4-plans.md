# Partie 2 — Étape 4 : Plans déploiement, sauvegarde, mises à jour

## 1) Plan de déploiement (simple)

### Objectif
Décrire comment déployer l’application de manière cohérente avec la conteneurisation et la CI/CD.

### Procédure
1. **CI** : build + tests (front/back).
2. **CD** : build des images Docker et publication sur GHCR.
3. **Déploiement** : récupération des images et lancement via `docker compose`.

### Prérequis
- Images disponibles sur le registre (GHCR).
- Ports disponibles : **8080** (back), **80/443** (front).
- Variables d’environnement configurées si besoin.

---

## 2) Plan de sauvegarde

### Données à sauvegarder
- Données applicatives (si DB externalisée).
- Configurations et fichiers de déploiement (docker-compose, env).

### Fréquence
- **Quotidienne** (minimum) + sauvegarde avant release.

### Méthode
- Export DB (dump) ou snapshot de volume Docker.
- Stockage chiffré (ex: NAS/Cloud interne).

---

## 3) Plan de mise à jour

### Dépendances
- Vérifier régulièrement les versions **Java**, **Node**, **Spring Boot**.
- Mettre à jour après **tests CI complets**.

### Processus
1. Mise à jour sur **branche dédiée**.
2. Exécution CI complète + vérification SonarQube.
3. Tag SemVer + release.
4. Déploiement progressif (validation en environnement de test).

---

## Checklist
- [x] Plan de déploiement défini
- [x] Plan de sauvegarde défini
- [x] Plan de mise à jour défini
