#!/bin/bash

if [ -d ~/miniconda3 ]; then
    echo "Miniconda est déjà installé ! Rien à faire."
    exit 0
fi

echo "Installation de Miniconda..."

mkdir -p ~/miniconda3 && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh  && \
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && \
rm -rf ~/miniconda3/miniconda.sh && \
~/miniconda3/bin/conda init bash && \
echo "Miniconda installé avec succès ! Relancez votre terminal pour que les changements soient pris en compte."

