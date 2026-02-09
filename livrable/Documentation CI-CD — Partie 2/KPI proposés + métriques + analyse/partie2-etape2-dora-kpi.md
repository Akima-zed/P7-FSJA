# Partie 2 — Étape 2 : Métriques DORA + KPI

## Objectif
Mesurer la performance du pipeline et définir des KPI opérationnels.

---

## 1) Métriques DORA (méthode)

### Lead Time for Changes
**Définition** : temps entre un commit et sa mise en production.
**Méthode** : comparer l’heure du commit et l’heure du tag/release.

### Deployment Frequency
**Définition** : fréquence de déploiement sur une période.
**Méthode** : compter les tags `vX.Y.Z` par semaine/mois.

### Mean Time to Restore (MTTR)
**Définition** : temps moyen pour restaurer un service après incident.
**Méthode** : temps entre détection et résolution d’un incident.

### Change Failure Rate
**Définition** : % de déploiements causant un incident.
**Méthode** : (déploiements échoués / déploiements totaux) x 100.

---

## 2) KPI proposés (exemples)
- **Temps de build back** (GitHub Actions)
- **Temps des tests front**
- **Taux de réussite CI**
- **Nombre d’erreurs applicatives** (ELK)
- **Dette technique / Code smells** (SonarQube)

---

## 3) Tableau à compléter

| Indicateur | Valeur | Source | Méthode de calcul |
|---|---:|---|---|
| Lead Time | N/A (pas de release) | GitHub Actions + tags | commit → release |
| Deployment Frequency | 0 (pas de tag SemVer) | GitHub Releases | nb tags / période |
| MTTR | N/A (aucun incident) | ELK / incidents | incident → résolution |
| Change Failure Rate | 33% (1 échec / 3 runs) | CI/CD | échecs / total |
| Temps build back | 49s (run #2) / 27s (run #3) | Actions | durée job back |
| Temps tests front | 56s (run #2) / 48s (run #3) | Actions | durée job front |
| Taux réussite CI | 67% (2 succès / 3 runs) | Actions | succès / total |
| Erreurs applicatives | 0 erreurs (15 derniers jours) | ELK | volume erreurs |
| Code smells | À compléter (SonarQube) | SonarQube | compteur |

---

## 4) Analyse commentée
- **Run #1 en échec** : `gradlew` non exécutable (exit code 126) → correction via `chmod +x ./gradlew`.
- **Temps CI** raisonnable : 1m28 et 1m18 pour les runs réussis.
- **Stabilité** : 2 runs OK sur 3 (amélioration après correction).
- **ELK** : 0 erreurs sur 15 jours, pic de logs INFO à **11:26:20** (3 événements) → bonne stabilité perçue, faible bruit d’erreurs.
- **À compléter** : code smells (SonarQube) si nouvelles mesures.

---

## Checklist
- [x] DORA définies
- [x] KPI listés
- [x] tableau prêt à compléter
