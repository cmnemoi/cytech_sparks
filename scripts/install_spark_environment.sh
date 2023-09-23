#!/bin/bash

echo "Installation de Spylon-kernel..."
pip install spylon-kernel notebook && \
python -m spylon_kernel install --user && \
echo "Spylon-kernel installé avec succès !"

echo "Installation de Java..."
sudo apt-get update -y && \
sudo apt-get install -y default-jdk && \
java -version && \
echo "Java installé avec succès !"

echo "Installation de Spark..."
sudo wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O /opt/spark-3.5.0-bin-hadoop3.tgz && \
sudo tar -xvzf /opt/spark-3.5.0-bin-hadoop3.tgz -C /opt/ && \
sudo rm -rf /opt/spark-3.5.0-bin-hadoop3.tgz && \

echo "export SPARK_HOME=/opt/spark-3.5.0-bin-hadoop3" >> ~/.bashrc && \
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.bashrc && \
source ~/.bashrc && \
echo "Spark installé avec succès ! Lancez make jupyter pour commencer à l'utiliser."

