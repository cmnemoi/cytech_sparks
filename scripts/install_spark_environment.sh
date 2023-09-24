#!/bin/bash

set -e

echo "Entrée en mode superutilisateur, saisissez votre mot de passe :"
sudo apt-get update -y && \

echo "Installation de Jupyter Notebook et du kernel Scala..."
pip install spylon-kernel notebook && \
python -m spylon_kernel install --user && \
echo "Jupyter Notebook installé avec succès !"

echo "Installation de Java..."
sudo apt-get install -y default-jdk && \
echo "Java installé avec succès !"

echo "Installation de Scala..."
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > ~/cs && chmod +x ~/cs && ~/cs setup 
source ~/.profile
echo "Scala installé avec succès !"

echo "Installation de Spark..."
sudo wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O /opt/spark-3.5.0-bin-hadoop3.tgz && \
sudo tar -xvzf /opt/spark-3.5.0-bin-hadoop3.tgz -C /opt/ && \
sudo rm -rf /opt/spark-3.5.0-bin-hadoop3.tgz && \

echo "export SPARK_HOME=/opt/spark-3.5.0-bin-hadoop3" >> ~/.bashrc && \
echo "export PATH=$PATH:/opt/spark-3.5.0-bin-hadoop3/bin:/opt/spark-3.5.0-bin-hadoop3/sbin" >> ~/.bashrc && \
source ~/.bashrc && \
echo "Spark installé avec succès !"

echo "Installation complète ! Lancez make jupyter pour démarrer".