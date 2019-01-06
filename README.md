# AWS 11-2018

_Notes de formation_

François-Emmanuel Goffinet

<!-- toc -->

## Environnement

* https://github.com/goffinet/aws-112018
* Installation Centos 7
* `yum -y install epel-release ; yum -y upgrade`
* Installtion de Atom.io : https://atom.io/
* Installtion de chromium
* Création d'un compte Github
* https://github.com/goffinet/virt-scripts
* vagarant, vagrant-libvirt, vagrant-mutate

## Administration Linux : 1e partie

### [I. Administration système](https://linux.goffinet.org/00_administration_systeme/)

- [1. Introduction à Linux](https://linux.goffinet.org/01-00-introduction-a-linux/)
    - [1.1. Evolution de Linux](https://linux.goffinet.org/01-01-evolution-de-linux/)
    - [1.2. Distributions Linux](https://linux.goffinet.org/01-02-distributions-linux-et-cycles-de-maintenance/)
    - [1.3. Licences Open Source](https://linux.goffinet.org/01-03-licences-open-source/)
    - [1.4. Applications Open Source](https://linux.goffinet.org/01-04-applications-open-source/)
    - [1.5. Utiliser Linux en console graphique (Centos7)](https://linux.goffinet.org/01-05-utiliser-linux-en-console-graphique-centos7/)
    - [1.6. Environnements de bureau](https://linux.goffinet.org/01-06-environnements-de-bureau/)
    - [1.7. Installation Linux Debian](https://linux.goffinet.org/01-07-installation-linux-debian/)
- [2. Le Shell](https://linux.goffinet.org/02-00-le-shell/)
    - [2.1. La ligne de commande](https://linux.goffinet.org/02-01-la-ligne-de-commande/)
    - [2.2. Filtres sur les fichiers (globbing)](https://linux.goffinet.org/02-02-filtres-sur-les-fichiers-globbing/)
    - [2.3. Premier script shell](https://linux.goffinet.org/02-03-premier-script-shell/)
    - [2.4. Configuration des langues, locales et clavier](https://linux.goffinet.org/02-04-langues-locales-clavier/)
    - [2.5. Aide sous Linux](https://linux.goffinet.org/02-05-aide-sous-linux/)
    - [2.6. Prendre connaissance de la version de la distribution](https://linux.goffinet.org/02-06-prendre-connaissance-de-la-version-de-la-distribution/)
- [3. Traitement du texte](https://linux.goffinet.org/03-00-traitement-du-texte/)
    - [3.1. Outils de base de traitement du texte](https://linux.goffinet.org/03-01-outils-de-base-traitement-du-texte/)
    - [3.2. Outils avancés de traitement du texte](https://linux.goffinet.org/03-02-outils-avances-traitement-du-texte/)
    - [3.3. L'éditeur de texte VI](https://linux.goffinet.org/03-03-editeur-de-texte-vi/)
- [4. Arborescence de fichiers](https://linux.goffinet.org/04-00-arborescence-de-fichiers/)
    - [4.1. Filesystem Hierachy Standard (FHS)](https://linux.goffinet.org/04-01-filesystem-hierachy-standard/)
    - [4.2. Opérations sur les fichiers](https://linux.goffinet.org/04-02-operations-sur-les-fichiers/)
    - [4.3. Recherche de fichiers](https://linux.goffinet.org/04-03-recherche-de-fichiers/)
    - [4.4. Archivage et compression](https://linux.goffinet.org/04-04-archivage-et-compression/)
- [5. Sécurité locale](https://linux.goffinet.org/05-00-securite-locale/)
    - [5.1. Utilisateurs et groupes Linux](https://linux.goffinet.org/05-01-utilisateurs-et-groupes-linux/)
    - [5.2. Opérations sur les utilisateurs et les groupes](https://linux.goffinet.org/05-02-operations-sur-les-utilisateurs-et-les-groupes/)
    - [5.3. Permissions Linux](https://linux.goffinet.org/05-03-permissions-linux/)
    - [5.4. Access control lists (ACLs) Linux](https://linux.goffinet.org/05-04-access-control-lists-acls-linux/)
    - [5.5. Pluggable Authentication Modules (PAM)](https://linux.goffinet.org/05-05-pluggable-authentication-modules-pam/)
- [6. Processus et démarrage](https://linux.goffinet.org/06-00-processus-et-demarrage/)
    - [6.1. Noyau Linux](https://linux.goffinet.org/06-01-noyau-linux/)
    - [6.2. Démarrage du système Linux](https://linux.goffinet.org/06-02-demarrage-du-systeme-linux/)
    - [6.3. Processus Linux](https://linux.goffinet.org/06-03-processus-linux/)
    - [6.4. Console virtuelles Screen](https://linux.goffinet.org/06-04-consoles-virtuelles-screen/)
- [7. Installation de logiciels](https://linux.goffinet.org/07-00-installation-logiciels/)
    - [7.1. Paquets Linux](https://linux.goffinet.org/07-01-paquets-linux/)
    - [7.2. Installation par les sources](https://linux.goffinet.org/07-02-installation-par-les-sources/)
    - [7.3. Mettre en place un dépôt de paquets](https://linux.goffinet.org/07-03-mettre-en-place-un-depot-de-paquets/)
    - [7.4. Installations automatiques](https://linux.goffinet.org/07-04-installations-automatiques/)
- [8. Scripts Shell](https://linux.goffinet.org/08-scripts-shell/)
- [9. Virtualisation KVM](https://linux.goffinet.org/09-virtualisation-kvm/)
- [10. Disques et Stockage LVM](https://linux.goffinet.org/10-disques-et-stockage-lvm/)
- [11. Configuration du réseau](https://linux.goffinet.org/11-00-configuration-du-reseau/)
    - [11.1. Introduction à TCP/IP](https://linux.goffinet.org/11-01-introduction-a-tcp-ip/)
    - [11.2. Synthèse rapide des commandes réseau sous Linux](https://linux.goffinet.org/11-02-synthese-des-commandes-reseau/)
    - [11.3. Gestion du réseau Linux avec NetworkManager](https://linux.goffinet.org/11-03-gestion-du-reseau-linux-avec-networkmanager/)
    - [11.4. Gestion du réseau Linux avec la librairie iproute2](https://linux.goffinet.org/11-04-gestion-du-reseau-linux-avec-la-librairie-iproute2/)
    - [11.5. Outils Linux réseau](https://linux.goffinet.org/11-05-outils-linux-reseau/)
- [12. Secure Shell](https://linux.goffinet.org/12-secure-shell/)
- [13. Gestion sécurisée](https://linux.goffinet.org/13-gestion-securisee/)
- [14. Routage et Pare-feu](https://linux.goffinet.org/14-routage-et-pare-feu/)
- [15. Confidentialité](https://linux.goffinet.org/41_securite_linux_confidentialite/)
- [16. PKI et TLS ](https://linux.goffinet.org/42_securite_linux_pki_et_tls/)
- [17. Audit](https://linux.goffinet.org/43_securite_linux_audit/)

### [II. Services Réseau](https://linux.goffinet.org/20_services_reseau/)

- [1. Laboratoires Services Réseau](https://linux.goffinet.org/20a_laboratoires_services_reseau/)
- [2. Services de passerelle](https://linux.goffinet.org/21_services_de_passerelle/)
- [3. Services d'infrastructure](https://linux.goffinet.org/22_services_infrastructure/)
- [4. Services de partage](https://linux.goffinet.org/23_services_partage/)
- [5. Authentification centralisée](https://linux.goffinet.org/24_services_authentification_centralisee/)
- [6. Services de Messagerie](https://linux.goffinet.org/25_services_messagerie/)
- [7. Services de surveillance](https://linux.goffinet.org/26_services_de_surveillance/)
- [8. Services Web](https://linux.goffinet.org/30_services_web/)
- [9. Apache HTTP Server](https://linux.goffinet.org/31_services_apache_http_server/)
- [10. Nginx comme Proxy](https://linux.goffinet.org/32_services_nginx/)
- [11. Services de Base de Données](https://linux.goffinet.org/33_services_base_de_donnees/)

## Administration Linux : 2e partie

* [Lab Automation LAMP Wordpress](lab-automation-wordpress.md)

## Docker

* **[https://docker.goffinet.org](https://docker.goffinet.org)**
* https://github.com/jpetazzo/container.training
* https://docs.docker.com/get-started/
* https://labs.play-with-docker.com/

### Étude de cas

* https://github.com/jpetazzo/figdemo
* https://docs.docker.com/compose/wordpress/#define-the-project
* https://github.com/scaleway-community/scaleway-wordpress/tree/master/latest
* plone: https://docs.plone.org/manage/docker/docs/index.html


## Puppet

* **[https://puppet.goffinet.org](https://puppet.goffinet.org)**
* https://puppet.com/download-learning-vm
* https://github.com/puppetlabs/puppet-quest-guide

### Lectures

* [https://doc.fedora-fr.org/wiki/Puppet](https://doc.fedora-fr.org/wiki/Puppet)
* [FICHE TECHNIQUE : AUTOMATISATION DES TESTS D’INFRASTRUCTURE AVEC PUPPET, FGOUTEROUX](https://blog.d2si.io/2015/03/18/technique-puppet-beaker/)
* [Puppet white papers](https://puppet.com/resources/whitepaper)

## Ansible

**[https://ansible.goffinet.org](https://ansible.goffinet.org)**

## Git

* **[Pro Git, le livre](https://book.git-scm.com/book/fr/v2), [PDF](https://github.com/progit/progit2-fr/releases/download/2.1.32/progit_v2.1.32.pdf)**
* [Création d'un compte Github](https://nexus-coding.blogspot.com/2015/10/tutoriel-creation-dun-compte-github-et.html)
* [git - petit guide](http://rogerdudler.github.io/git-guide/index.fr.html), [PDF](http://rogerdudler.github.io/git-guide/files/git_cheat_sheet.pdf)
* [Ajouter une clé SSH à son compte github](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)
* [Changer d'origine https en ssh](https://help.github.com/articles/changing-a-remote-s-url/)

## Jenkins

* **[Jenkins - Le guide complet](https://jenkins-le-guide-complet.github.io/), [PDF](https://jenkins-le-guide-complet.github.io/continuous-integration-with-hudson.pdf), [source](https://github.com/Jenkins-Le-guide-complet)**
* [Jenkins User Handbook](https://jenkins.io/doc/book/getting-started/), [PDF](https://jenkins.io/user-handbook.pdf)
* [Jenkins Tutorials](https://jenkins.io/doc/tutorials/)
* **[Joostvdg's Software Engineering Page sur Jenkins](https://joostvdg.github.io/jenkins/)**
* https://go.cloudbees.com/docs/cloudbees-documentation/use/automating-projects/jenkinsfile/

Alternatives : Gitlab CI, Bitbucket, Travis CI

## DevOps

* [Apprendre le déploiement continu avec des générateurs de site statique](https://ci-cd.goffinet.org/)
* [PERIODIC TABLE OF DEVOPS TOOLS (V3)](https://xebialabs.com/periodic-table-of-devops-tools/)
* [The Three Ways: The Principles Underpinning DevOps](https://itrevolution.com/the-three-ways-principles-underpinning-devops/)
* [Elements Of The First Way: And The DevOps Implications…](https://itrevolution.com/elements-of-the-first-way-and-the-devops-implications/)
* [DevOps Culture (Part 1)](https://itrevolution.com/devops-culture-part-1/)
* [DevOps Culture (Part 2)](https://itrevolution.com/devops-culture-part-2/)

<iframe src='https://xebialabs.com/periodic-table-of-devops-tools/embed/' style='border:0px #FFFFFF none;' name='Periodic Table of DevOps' scrolling='no' frameborder='1' marginheight='0px' marginwidth='0px' height='625px' width='925px'></iframe>

## Administration de serveur Web Apache

* [8. Services Web](https://linux.goffinet.org/30_services_web/)
  * API HTTP Rest : https://medium.freecodecamp.org/build-restful-api-with-authentication-under-5-minutes-using-loopback-by-expressjs-no-programming-31231b8472ca
  * Postman : https://www.getpostman.com/
* [9. Apache HTTP Server](https://linux.goffinet.org/31_services_apache_http_server/)
* [10. Nginx comme Proxy](https://linux.goffinet.org/32_services_nginx/)

## Administration Websphere

* [WebSphere Application Server V8.5.5 Technical Overview](http://www.redbooks.ibm.com/redpapers/pdfs/redp4855.pdf)
* [WebSphere Application Server V8.5 Administration and Configuration Guide for the Full Profile](http://www.redbooks.ibm.com/redbooks/pdfs/sg248056.pdf)
* [WebSphere Application Server V8.5 Concepts, Planning, and Design Guide](https://www.redbooks.ibm.com/redbooks/pdfs/sg248022.pdf)
* [Introduction à Websphere Application Server](https://www.supinfo.com/articles/single/3240-introduction-websphere-application-server)
* [IBM WebSphere Application Server (WAS) V9.0 Tutorial](https://mindmajix.com/ibm-was-tutorial)
* [Configuring a web server and an application server profile on the same machine](https://www.ibm.com/support/knowledgecenter/en/SSAW57_8.5.5/com.ibm.websphere.nd.multiplatform.doc/ae/tins_webplugins_local.html)
* [ibmcom/websphere-traditional](https://hub.docker.com/r/ibmcom/websphere-traditional/)
* [WASdev/ci.docker.websphere-traditional](https://github.com/WASdev/ci.docker.websphere-traditional)
* [Modernizing Traditional Java Applications](https://training.play-with-docker.com/java-mta/)
* [Websphere Application Server V8.5.5.9 Network Deployment 2-Node Cluster on Docker](https://redheadhat.wordpress.com/2016/11/01/websphere-application-server-v8-5-5-9-network-deployment-2-node-cluster-on-docker/)
* [How to configure IBM WebSphere Application Server Network Deployment Cell Topology using Docker Containers](https://developer.ibm.com/recipes/tutorials/how-to-configure-ibm-websphere-application-server-network-deployment-cell-topology-using-docker-containers/)
* [Configuring WebSphere Application Server Network Deployment Cell Topology using Docker Compose](https://developer.ibm.com/recipes/tutorials/configuring-websphere-application-server-network-deployment-cell-topology-using-docker-compose/)
* [WebSphere full profile Installed in a Docker container](https://www.ibm.com/developerworks/community/blogs/devTips/entry/running_websphere_on_docker_container?lang=en)
* [50 Frequently Asked WebSphere Interview Questions and Answers](https://geekflare.com/websphere-interview-quetstions/)

## Programmation Python

* [Apprendre à programmer en Python 2 et en Python 3](https://inforef.be/swi/python.htm)
* [Programmation Python](https://fr.wikibooks.org/wiki/Programmation_Python)
* [Apprendre le langage de programmation python](http://apprendre-python.com/)
* [Digital Ocean Learn Python](https://www.digitalocean.com/community/tags/python?type=tutorials)
* [Digital Ocean Programming Projects](https://www.digitalocean.com/community/tags/project/tutorials?page=1)

### Projets Python

1. Parler Geek, un simple calculateur
* Algorithme de chiffrement Rot13 et Vigenère
* "Scraper" et "Scrawler" des pages Web
* Manipuler des API HTTP REST
* Manipuler l'API de SLACK, de Github, de Gitlab
* Comment créer un TwitterBot
* Créer un Gitbook à partir d'un Jekyll
* Mettre en graphe des fréquences de mot
* Se connecter à une base de données
* Manipuler S3 et EC2

## Amazon Web Services

En travail. [Amazon Web Services](https://aws-dev.goffinet.org)

* https://templates.cloudonaut.io/en/stable/
