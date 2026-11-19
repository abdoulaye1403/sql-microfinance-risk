# 🗄️ Analyse SQL de Portefeuille Microfinance & Risque Crédit (`sql-microfinance-risk`)

Projet **SQL** complet modélisant un portefeuille de microfinance (**XOF**) avec contraintes d'intégrité, règles métier, requêtes d'analyse (**PAR 90**, taux de recouvrement, segmentation par âge, fonctions de fenêtrage) et contrôle qualité.

## 📁 Structure du projet

```text
sql-microfinance-risk/
├── sql/
│   ├── schema.sql        # Création des tables et règles d'intégrité
│   ├── insert_data.sql   # Jeu de données fictives
│   └── analyses_kpi.sql  # Vue consolidée, indicateurs PAR 90 et audit SQL
└── README.md