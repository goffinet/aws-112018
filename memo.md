# Mémo

<!-- toc -->

## Comment puis-je convertir un fichier .pem en .ppk et vice versa, sur Windows et Linux ?

Source : [Comment puis-je convertir un fichier .pem en .ppk et vice versa, sur Windows et Linux ?](https://aws.amazon.com/fr/premiumsupport/knowledge-center/convert-pem-file-into-ppk/)

### Problème

Comment convertir mon fichier Amazon EC2 Privacy Enhanced Mail (.pem) en un fichier PuTTY Private Key (.ppk)? Ou convertir un fichier .ppk en fichier .pem?

### Brève description

Par défaut, PuTTY ne supporte pas le format clé privée (.pem) généré par Amazon Elastic Compute Cloud (EC2). Vous devez convertir votre clé privée en un fichier .ppk avant de pouvoir vous connecter à votre instance utilisant PuTTY. PuTTY a un outil nommé PuTTYgen qui peut être utilisé pour convertir les clés, aussi bien par les utilisateurs du système d’exploitation Windows, que par les utilisateurs de Unix.

### Résolution

#### Windows - Installer PuTTYgen

Téléchargez et installez [PuTTYgen](https://www.ssh.com/ssh/putty/windows/puttygen).

#### Windows - convertir un fichier .pem en fichier .ppk

* Démarrez PuTTYgen puis convertissez le fichier .pem en ficheir .ppk

* Sous "Type of key to generate", sélectionnez "RSA".
  ![](https://docs.aws.amazon.com/fr_fr/AWSEC2/latest/UserGuide/images/puttygen-key-type.png	)

* Choisissez "Load". Par défaut, PuTTYgen affiche uniquement les fichiers ayant l'extension .ppk. Pour retrouver votre fichier .pem, sélectionnez l'option permettant d'afficher tous les types de fichiers.
  ![Sélectionnez tous les types de fichiers](https://docs.aws.amazon.com/fr_fr/AWSEC2/latest/UserGuide/images/puttygen-load-key.png)

* Sélectionnez votre fichier .pem pour la paire de clés que vous avez spécifiée lorsque vous avez lancé votre instance, puis choisissez "Open". Sélectionnez OK pour ignorer la boîte de dialogue de confirmation.

* Choisissez "Enregistrer la clé privée" pour enregistrer la clé au format utilisable par PuTTY. PuTTYgen affiche un avertissement sur l'enregistrement de la clé sans une phrase passe. Choisissez "Yes".

#### Windows - Convertir un fichier .ppk en fichier .pem

1. Démarrez `puttygen`. Sous l’option Actions, sélectionnez Charger, puis naviguez vers votre fichier .ppk.
* Sélectionnez le fichier .ppk puis sélectionnez Ouvrir.
* Dans le menu qui se trouve en haut du générateur de clé PuTTY, Sélectionnez l’option Conversions et ensuite sélectionnez Exporter clé OpenSSH.
* Concernant l’alerte de `puttygen` Êtes-vous sûr que vous voulez sauvegarder cette clé sans la protéger par une phrase de sécurité?, Choisissez Oui.
* Nommez le fichier puis ajoutez l'extension .pem .

#### Unix ou Linux - installer PuTTY

Installez PuTTY, s'il n'est pas déjà dans votre système, en exécutant une de ces commandes:

```bash
$ sudo yum install putty || sudo apt-get install putty-tools
```

#### Unix ou Linux - convertir un fichier .pem en fichier .ppk

Exécutez la commande `puttygen` pour convertir votre fichier .pem en fichier .ppk:

```bash
$ sudo puttygen pemKey.pem -o ppkKey.ppk -O private
```

#### Unix ou Linux - convertir un fichier .ppk en fichier .pem

Exécutez la commande `puttygen` pour convertir un fichier .ppk en fichier .pem:

```bash
$ sudo puttygen ppkkey.ppk -O private-openssh -o pemkey.pem
```
