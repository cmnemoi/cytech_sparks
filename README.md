# Cours sur le traitement de "Big avec Spark

Dépôt pour notre cours sur Spark pour le cours de "Programmation Fonctionnelle" à CY Tech.

Auteurs : Aïcha Lehbib, Ahmed Ouinekh, Charles-Meldhine Madi Mnemoi, Lucas Terra, Jalis Aït-Ouakli, Youssef Saïdi

# Installation

Pour profiter du cours, il faut **Docker** sur votre machine.  **Docker** devrait déjà être installé sur les PC CY Tech, **sous Linux** (ouvrez un terminal et tapez `docker --version` pour vérifier).

Si ce n'est pas le cas, vous pouvez suivre les instructions d'installation sur le site officiel de [Docker](https://docs.docker.com/get-docker/).
 
Il vous suffit de lancer la commande `make` pour installer le cluster Spark utilisé pour le cours.

# Curriculum du cours

# Partie 1 : Présentation du Big Data, Apache Spark et installation du cluster

- Big Data : les 3V
- En quoi Spark est-il un outil adapté au Big Data ?
- Installation du cluster Spark avec Docker : avantages

![Schéma représentant le cluster Spark du cours](images/cluster_schema.png)

# Partie I : Création d'un ELT avec Spark SQL

- Définition d'un ELT (Extract, Load, Transform)
- Cas pratique sur les données Titanic
  - Extraction des données à partir de plusieurs fichiers
  - Chargement des données dans un DataFrame
  - Transformation des données : nettoyage, création de nouvelles variables

[Notebook - Création_d'un_ELT_avec_Spark_SQL.ipynb](notebooks/001_Création_d'un_ELT_avec_Spark_SQL.ipynb)

# Partie II : Analyse de données avec les Spark DataFrames

- Quelques fonctions utiles inspirés de la programmation fonctionnelles (`filter`, `sort`, `groupBy`, `count`...)
- Exercices pratiques sur le jeu de données Titanic

[Notebook - Analyse_de_données_avec_les_Spark_DataFrames.ipynb](notebooks/001_Analyse_de_données_avec_les_Spark_DataFrames.ipynb)

# Partie III : Création d'un modèle de Machine Learning avec Spark MLlib

- Méthodologie d'un projet de Machine Learning (définition du problème, train/test split, création du modèle et évaluation)
- Cas pratique sur les données Titanic

# Partie IV : Analyse de données graphes avec Spark GraphX

- Qu'est ce qu'un graphe (TODO)
- Cas pratique (TODO)

# [Lien vers les slides du cours](presentation.pptx)

