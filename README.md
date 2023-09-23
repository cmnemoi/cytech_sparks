# Spark course

Dépôt pour notre cours sur Spark pour le cours de "Programmation Fonctionnelle" à CY Tech.

Auteurs : Aïsha Lehbib, Ahmed Ouinekh, Charles-Meldhine Madi Mnemoi, Jalis Aït-Ouakli, Youssef Saïdi

# Configuration de l'environnement de développment

## Aparté pour les utilisateurs Windows

**Version courte :** Ouvrez un terminal (`Windows + R` puis tapez `cmd`) puis installez Ubuntu avec `wsl --install -d Ubuntu`.

Si vous utilisez Windows, commencez par installer Ubuntu à travers WSL2.

Cela vous permettra d'utiliser les commandes et outils Linux (ce qui va grandement faciliter l'installation) tout en continuant à utiliser Windows (et avec quasiment aucune perte de performance comparée à l'utilisation d'une machine virtuelle).

WSL2 devrait déjà être installé sur les PC CY Tech. Pour vous en assurer, lancez un terminal et tapez `wsl --list`. 

Si la commande renvoie une erreur, suivez les instructions sur https://docs.microsoft.com/fr-fr/windows/wsl/install pour installer WSL2.

Sinon, installez Ubuntu avec `wsl --install -d Ubuntu` puis définissez votre nom d'utilisateur et votre mot de passe.

Vous êtes prêts à continuer l'installation !

## Cloner ce dépôt Git

Si ce n'est pas encore fait, configurez vos comptes Git et GitHub.

- Générez une clé SSH : 
  - `ssh-keygen -t ed25519 -C "Clé SSH pour le dépôt cytech_spaks (https://github.com/cmnemoi/cytech_spark)"`
  - Appuyez sur `Entrée` jusqu'à que la clé soit générée
- Ajoutez la clé SSH à votre agent SSH : `eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519`
- Affichez la clé SSH générée : `cat ~/.ssh/id_ed25519.pub` et copiez-la 
- Ajoutez la clé SSH à votre compte GitHub :
  - Tutoriel : https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account
  - Lien direct : https://github.com/settings/ssh/new

Puis clonez ce dépôt Git : `git clone git@github.com:cmnemoi/cytech_sparks.git && cd cytech_sparks` (entrez `yes` si on vous demande de confirmer l'ajout de la clé SSH à la liste des clés connues)

## Lancer les scripts d'installation

Tout d'abord, installez Miniconda : `make install-miniconda`
