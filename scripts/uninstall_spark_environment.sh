#!/bin/bash

echo "Désinstallation de Java..."
sudo apt-get purge -y default-jdk openjdk* && \
sudo apt-get autoremove -y && \
echo "Java désinstallé avec succès !"

echo "Désinstallation de Scala..."
cs uninstall --all && \
rm -rf ~/cs && \
echo "Scala désinstallé avec succès !"

echo "Désinstallation de Spark..."
sudo rm -rf ~/spark-3.5.0-bin-hadoop3 && \
sudo rm -rf ~/spark-3.5.0-bin-hadoop3.tgz && \
sed -i '/SPARK_HOME/d' ~/.bashrc && \
sed -i '/PATH.*SPARK_HOME/d' ~/.bashrc && \
source ~/.bashrc && \
echo "Spark désinstallé avec succès !"

echo "Désinstallation de Jupyter et du kernel Scala..."
rm -rf ~/.local/share/jupyter/kernels/scala
echo "Jupyter désinstallé avec succès !"
