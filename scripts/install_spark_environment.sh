#!/bin/bash

echo "Entrée en mode superutilisateur, saisissez votre mot de passe :"
sudo apt-get update && \

echo "Installation de Java..."
sudo apt-get install -y default-jdk && \
echo "Java installé avec succès !"

echo "Installation de Scala..."
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > ~/cs && chmod +x ~/cs && ~/cs setup 
source ~/.profile
echo "Scala installé avec succès !"

echo "Installation de Spark..."
wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O ~/spark-3.5.0-bin-hadoop3.tgz && \
tar -xvzf ~/spark-3.5.0-bin-hadoop3.tgz -C ~/ && \
rm -rf ~/spark-3.5.0-bin-hadoop3.tgz && \

echo "export SPARK_HOME=~/spark-3.5.0-bin-hadoop3" >> ~/.bashrc && \
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.bashrc && \
source ~/.bashrc && \
echo "Spark installé avec succès !"

echo "Installation d'Almond..."
cs launch almond -- --install && \
echo "Almond installé avec succès !"

echo "Installation de Jupyter Notebook..."
pip install notebook && \
echo "Jupyter Notebook installé avec succès !"

echo "Installation complète ! Lancez make jupyter pour démarrer".