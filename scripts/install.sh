#!/bin/bash

set -e

PYENV_ROOT="$HOME/.pyenv"
PYTHON_VERSION="3.9.18"
PYTHON_DIR_PATH="$PYENV_ROOT/versions/$PYTHON_VERSION"
PYTHON_PATH="$PYTHON_DIR_PATH/bin/python3"

echo "Entrée en mode superutilisateur, saisissez votre mot de passe :"
sudo apt update -y -q 
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y -q

echo "Installation de pyenv..."
if [ ! -d "$PYENV_ROOT" ]; then
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"' >> ~/.bashrc
    echo "pyenv installé avec succès !"
else
    echo "pyenv est déjà installé ! Rien à faire."
fi

echo "Installation de Python 3.9... (pas de panique, cela prend un certain temps)"
if [ ! -d $PYTHON_DIR_PATH ]; then
  pyenv install $PYTHON_VERSION
  echo "Python $PYTHON_VERSION installé avec succès !"
else
    echo "Python $PYTHON_VERSION est déjà installé ! Rien à faire."
fi

echo "Installation de Poetry..."
curl -sSL https://install.python-poetry.org | python3 -
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
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > ~/cs && chmod +x ~/cs && ~/cs setup 
echo "Scala installé avec succès !"

echo "Installation de Spark..."
sudo wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O /opt/spark-3.5.0-bin-hadoop3.tgz
sudo tar -xvzf /opt/spark-3.5.0-bin-hadoop3.tgz -C /opt/
sudo rm -rf /opt/spark-3.5.0-bin-hadoop3.tgz
echo "export SPARK_HOME=/opt/spark-3.5.0-bin-hadoop3" >> ~/.bashrc
echo "export PATH=$PATH:/opt/spark-3.5.0-bin-hadoop3/bin:/opt/spark-3.5.0-bin-hadoop3/sbin" >> ~/.bashrc
echo "Spark installé avec succès !"

# exporting pyenv to path
echo 'export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> ~/.bashrc

echo "Installation complète ! Lancez make jupyter pour démarrer".