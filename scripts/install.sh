#!/bin/bash

set -e -o pipefail

POETRY_VERSION="1.6.1"
PYENV_ROOT="$HOME/.pyenv"
PYENV_EXEC="$PYENV_ROOT/bin/pyenv"
PYTHON_VERSION="3.9.18"
PYTHON_DIR_PATH="$PYENV_ROOT/versions/$PYTHON_VERSION"
PYTHON_PATH="$PYTHON_DIR_PATH/bin/python3"

# Install Python build tools
sudo apt update &&\
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

echo "Installation de pyenv..."
if [ ! -d "$PYENV_ROOT" ]; then
    curl https://pyenv.run | bash
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

echo "Installation de Spark..."
if [ ! -d "~/spark" ]; then
    mkdir ~/spark
    wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz -O ~/spark/spark-3.5.0-bin-hadoop3.tgz
    tar -xvzf ~/spark/spark-3.5.0-bin-hadoop3.tgz -C ~/spark/
    mv ~/spark/spark-3.5.0-bin-hadoop3/* ~/spark/
    rm -rf ~/spark/spark-3.5.0-bin-hadoop3.tgz ~/spark/spark-3.5.0-bin-hadoop3
    echo "export SPARK_HOME=$HOME/spark" >> ~/.bashrc
    echo "export PATH=$PATH:$HOME/spark/bin:$HOME/spark/sbin:$HOME/spark/bin/spark-shell" >> ~/.bashrc
    echo "alias spark=spark-shell" >> ~/.bashrc
    echo "Spark installé avec succès !"
else
    echo "Spark est déjà installé ! Rien à faire."
fi

# Add pyenv to PATH
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

echo "Installation complète ! Lancez make jupyter dans un nouveau terminal pour commencer".