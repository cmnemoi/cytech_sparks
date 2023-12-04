#!/bin/bash

set -e

echo "Entrée en mode superutilisateur, saisissez votre mot de passe :"
sudo echo "Mode superutilisateur activé !"

echo "Désinstallation de pyenv..."
rm -rf ~/.pyenv
sed -i '/pyenv/d' ~/.bashrc
sed -i '/PYENV_ROOT/d' ~/.bashrc
sed -i '/PATH.*PYENV_ROOT/d' ~/.bashrc
sed -i '/eval.*pyenv/d' ~/.bashrc
echo "pyenv désinstallé avec succès !"

echo "Désinstallation de Poetry..."
curl -sSL https://install.python-poetry.org | python3 - --uninstall &&\
echo "Poetry désinstallé avec succès !"

echo "Désinstallation de Java..."
sudo apt-get purge -y -q default-jdk openjdk*
sudo apt-get autoremove -y -q
echo "Java désinstallé avec succès !"

echo "Désinstallation de Spark..."
sudo rm -rf ~/spark
sed -i '/SPARK_HOME/d' ~/.bashrc
sed -i '/PATH.*SPARK_HOME/d' ~/.bashrc
echo "Spark désinstallé avec succès !"

echo "Désinstallation de Jupyter et du kernel Scala..."
rm -rf .venv
rm -rf ~/.local/share/jupyter/kernels/spylon-kernel
echo "Jupyter désinstallé avec succès !"

echo "Désinstallation complète ! Relancez votre terminal pour que les changements soient pris en compte."