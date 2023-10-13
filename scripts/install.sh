#!/bin/bash -i

set -e

echo "Entrée en mode superutilisateur, saisissez votre mot de passe :"
echo "Mise à jour des paquets..."
sudo apt-get update -y -q && \

echo "Installation de pyenv..." && \
if [ -d ~/.pyenv ]; then
    echo "pyenv est déjà installé ! Rien à faire."
    exit 0
fi

curl https://pyenv.run | bash && \
echo 'export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> ~/.bashrc && \
source ~/.bashrc && \

echo "Installation de Python 3.9... (pas de panique, cela prend un certain temps)"
$HOME/.pyenv/bin/pyenv install 3.9 && \
$HOME/.pyenv/bin/pyenv global 3.9 && \
echo "Python 3.9 installé avec succès !"

echo "Installation de Poetry..."
curl -sSL https://install.python-poetry.org | python3 - && \
poetry config virtualenvs.in-project true && \
echo "Poetry installé avec succès !"

echo "Installation de Jupyter Notebook et du kernel Scala..."
poetry install && \
poetry run python -m spylon_kernel install --user && \
echo "Jupyter Notebook installé avec succès !"

echo "Installation de Java..."
sudo apt-get install -y -q default-jdk && \
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
echo "Spark installé avec succès !"

echo "Installation complète ! Lancez make jupyter pour démarrer".