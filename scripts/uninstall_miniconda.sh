#!/bin/bash

if [ ! -d ~/miniconda3 ]; then
    echo "Miniconda n'est pas installé ! Rien à faire."
    exit 0
fi

echo "Désinstallation de Miniconda..."

conda install -y anaconda-clean && \
anaconda-clean --yes && \
rm -rf ~/miniconda3 && \
echo "Miniconda désinstallé avec succès !"