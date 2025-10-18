# 🛒 Application E-Commerce - JPA & MVC2

Application web de commerce électronique développée avec Jakarta EE, architecture MVC2 et JPA.

## 📖 Description

**ShopMaroc** est une plateforme e-commerce complète permettant aux clients de parcourir un catalogue, gérer leur panier et passer des commandes. Les administrateurs peuvent gérer les utilisateurs, produits et commandes via une interface dédiée.

## ✨ Fonctionnalités Principales

### 👤 Espace Client
- Inscription et connexion sécurisée
- Navigation dans le catalogue de produits
- Ajout/suppression d'articles au panier
- Validation de commandes avec vérification de stock
- Consultation de l'historique des commandes

### 🔧 Espace Administrateur
- **Gestion des utilisateurs** : CRUD complet avec recherche
- **Gestion des produits** : Ajout, modification, suppression avec gestion du stock
- **Gestion des commandes** : Suivi et mise à jour du statut (En attente → Confirmée → Expédiée → Livrée)

## 🔧 Technologies

- **Backend** : Jakarta EE (Servlets, JSP), JPA/EclipseLink
- **Base de données** : MySQL 8.x
- **Build** : Maven 3.x
- **Serveur** : Apache Tomcat 10.x
- **Frontend** : HTML, CSS, JavaScript, JSTL

## 🏗️ Architecture

### Modèle de Données
```
User ──1:1── Panier ──1:N── LignePanier ──N:1── Produit
  │                                               │
  └──1:N── Commande ──1:N── LigneCommande ──────┘
```

### Entités JPA
- **User** : Utilisateurs (id, nom, email, mot de passe, adresse)
- **Produit** : Articles (id, nom, description, prix, stock, image)
- **Panier** : Panier temporaire (id, date, total)
- **LignePanier** : Détails panier (id, quantité, produit)
- **Commande** : Commandes validées (id, date, total, statut)
- **LigneCommande** : Détails commande (id, quantité, produit)

## 📥 Installation

### Prérequis
- JDK 17+
- MySQL 8.x
- Apache Tomcat 10.x
- Maven 3.x

### Configuration

**1. Cloner le projet**
```bash
git clone https://github.com/votre-username/atelier-ecommerce.git
cd atelier-ecommerce
```

**2. Créer la base de données**
```sql
CREATE DATABASE ecommerce_db_2;
```

**3. Configurer la connexion**  
Modifier `src/main/resources/META-INF/persistence.xml` :
```xml
<property name="jakarta.persistence.jdbc.url" 
          value="jdbc:mysql://127.0.0.1:3306/ecommerce_db_2"/>
<property name="jakarta.persistence.jdbc.user" value="root"/>
<property name="jakarta.persistence.jdbc.password" value="votre_mot_de_passe"/>
```

**4. Générer les tables**
```bash
# Exécuter MainTest.java pour créer automatiquement les tables
mvn exec:java -Dexec.mainClass="ma.fstt.atelierecommerce.Model.MainTest"
```

**5. Compiler et déployer**
```bash
mvn clean package
# Copier le fichier .war dans le dossier webapps/ de Tomcat
```

**6. Lancer l'application**
```
http://localhost:8080/atelierecommerce
```

## 📁 Structure du Projet
```
src/main/
├── java/ma.fstt.atelierecommerce/
│   ├── Controller/          # Servlets (UserServlet, ProduitServlet, etc.)
│   ├── Model/              # Entités JPA (User, Produit, Commande, etc.)
│   └── utils/               # JPAUtil (gestion de la persistance)
│
├── resources/
│   └── META-INF/
│       └── persistence.xml # Configuration JPA
│
└── webapp/
    └── WEB-INF/
        └── views/          # Pages JSP (login, produits, panier, etc.)
```

## 🎯 Utilisation

### Routes Principales

**Client**
```
/user?action=login          → Connexion
/user?action=register       → Inscription
/produit?action=list        → Catalogue produits
/panier?action=view         → Voir le panier
/commande?action=list       → Historique commandes
```

**Administration**
```
/admin/user/list            → Gestion utilisateurs
/admin/produit/list         → Gestion produits
/admin/commande/list        → Gestion commandes
```

## 🔐 Règles de Gestion

- Un utilisateur possède **un seul panier** (relation 1:1)
- Un utilisateur peut avoir **plusieurs commandes** (relation 1:N)
- Le **stock est décrémenté** lors de l'ajout au panier
- Le **stock est restauré** lors de la suppression d'un article du panier
- Le **panier est vidé** automatiquement après validation de la commande
- La suppression d'un panier supprime toutes ses lignes (Cascade)

## 🚀 Fonctionnalités Clés

### Gestion Intelligente du Stock
- Vérification en temps réel lors de l'ajout au panier
- Restauration automatique lors de la suppression
- Badge visuel : 🟢 Stock élevé | 🟠 Stock limité | 🔴 Rupture

### Workflow des Commandes
```
Panier → Validation → Commande (En attente)
                         ↓
                    Admin modifie le statut
                         ↓
            Confirmée → Expédiée → Livrée
```

### Sécurité
- Gestion des sessions utilisateurs
- Validation des droits d'accès (un utilisateur ne peut modifier que ses propres données)
- Transactions JPA pour l'intégrité des données
