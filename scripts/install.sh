#!/bin/bash

set -e -o pipefail

POETRY_VERSION="1.6.1"
PYENV_ROOT="$HOME/.pyenv"
PYENV_EXEC="$PYENV_ROOT/bin/pyenv"
PYENV_VERSION="2.3.33"
PYTHON_VERSION="3.9.18"
PYTHON_DIR_PATH="$PYENV_ROOT/versions/$PYTHON_VERSION"
PYTHON_PATH="$PYTHON_DIR_PATH/bin/python3"

echo "Installation de pyenv..."
if [ ! -d "$PYENV_ROOT" ]; then
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
    source ~/.bashrc
    echo "pyenv installé avec succès !"
else
    echo "pyenv est déjà installé ! Rien à faire."
fi

echo "Installation de Python $PYTHON_VERSION... (pas de panique, cela prend un certain temps)"
if [ ! -d $PYTHON_DIR_PATH ]; then
    $PYENV_EXEC install $PYTHON_VERSION
    echo "Python $PYTHON_VERSION installé avec succès !"
else
    echo "Python $PYTHON_VERSION est déjà installé ! Rien à faire."
fi

echo "Installation de Poetry..."
curl -sSL https://install.python-poetry.org | python3 - --version $POETRY_VERSION
poetry config virtualenvs.in-project true
echo "Poetry installé avec succès !"

echo "Installation de Jupyter Notebook et du kernel Scala..."
poetry env use $PYTHON_PATH
poetry install
poetry run python -m spylon_kernel install --user
echo "Jupyter Notebook installé avec succès !"

echo "Installation de Java..."
sudo apt-get install -y -q default-jdk
echo "Java installé avec succès !"

echo "Installation de Scala..."
if [ ! -d "$HOME/cs" ]; then
    curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > ~/cs && chmod +x ~/cs && ~/cs setup
    echo "Scala installé avec succès !"
else
    echo "Scala est déjà installé ! Rien à faire."
fi

echo "Installation de Spark..."
if [ ! -d "/opt/spark-3.5.0-bin-hadoop3" ]; then
    sudo wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O /opt/spark-3.5.0-bin-hadoop3.tgz # on télécharge Sparks
    sudo tar -xvzf /opt/spark-3.5.0-bin-hadoop3.tgz -C /opt/ # On décompresse l'archive
    sudo rm -rf /opt/spark-3.5.0-bin-hadoop3.tgz # On supprime l'archive
    echo "export SPARK_HOME=/opt/spark-3.5.0-bin-hadoop3" >> ~/.bashrc # On met l'emplacement de Spark en variable d'environnement pour que Scala le trouve
    echo "export PATH=$PATH:/opt/spark-3.5.0-bin-hadoop3/bin:/opt/spark-3.5.0-bin-hadoop3/sbin" >> ~/.bashrc # On met l'emplacement de Spark en variable d'environnement pour que Scala le trouve
    echo "Spark installé avec succès !"
else
    echo "Spark est déjà installé ! Rien à faire."
fi

echo "Installation complète ! Lancez make jupyter pour démarrer".