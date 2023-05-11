# Installation d'un NUC intel partie sur place

## Matériel nécessaire

Voici une liste du matériel nécessaire :

- Un tournevis cruciforme
- Un clavier
- Une souris
- Un écran
- Un câble HDMI
- Un câble Ethernet

## Matériel fourni

Voici une liste du matériel qui doit être fourni

- NUC Intel avec son alimentation
- Barette de RAM DDR4 au format SO-DIMM
- SSD au format NVME

![Matériel recu](./images/NUC/01-kit-recu.jpg)

## Installation du matériel dans le NUC

- Sortir le unc de sa boite et retirer les plastiques qui le protège
- Le positionner face avant vers soi (seulement 2 ports usb sont alors apparents)
- Le retourner afin d'avoir le dessous sur le haut (les patins avec les vis sont alors visibles)
![NUC face dessous](./images/NUC/face-dessous.jpg)
- A l'aide du tournevis déserrer les vis (ce sont des vis sans fin)
![NUC Vis démontées](./images/NUC/demontage-vis.jpg)
- Retirer doucement la plaque arrière en tirant par 2 vis en diagonale
![Enlevement de la plaque dessous](./images/NUC/enlevement-plaque-dessous.jpg)
![Carte mère visible](./images/NUC/carte-mere-vide.jpg)
- Ouvrir le paquet contenant la RAM et la positionner face au port à droite situé le plus en profondeur, insérer la doucement en biais, puis abaisser la barette doucement jusqu'a ce qu'un clic se fasse entendre
![Photos de la ram](./images/NUC/ram-1.jpg)
![Photos de la ram](./images/NUC/ram-2.jpg)
![Photos de la ram](./images/NUC/ram-3.jpg)
![Photos de la ram](./images/NUC/ram-4.jpg)
- Retirer la vis se situant au dessus de la carte WIFI (en face de l'étiquette avec la mention "NVMe ONLY)
![Photos de l'emplacement SSD](./images/NUC/ssd-2.jpg)
- Ouvrir le sachet contenant le SSD , l'insérer en biais dans le slot en respectant le détrompeur, puis appuyer pour mettre le SSD à plat, enfin revenir visser par-dessus
![Isntallation SSD](./images/NUC/ssd-1.jpg)
![Isntallation SSD](./images/NUC/ssd-3.jpg)
- Refermer le boitier (attention il y a un sens, la flèche dessinées avec la mention "FRONT" doit pointer vers les 2 ports usb bleus situés à l'avant du boitier)
![Reinstallation de la plaque arrière](./images/NUC/plaque-remise.jpg)

## Branchement du NUC

Brancher un câble hdmi sur un écran et le relier au NUC sur leport HDMI 1 (écrit au dessus) , faire de même avec câble ethernet,le clavier et la souris. Puis finir de brancher le NUC en reliant l'alimentation à ce dernier.

## Démarrage du NUC et installation de la partie V-Pro

Allumer l'ecran puis le NUC via son bouton dédié sur la façade avant. Puis appuyer simultanément sur les touches "control" et "p" de votre clavier jusqu'à l'apparition d'un écran gris et bleu. Si cela ne marche pas, appuyer sur les touches "control","alt" et "suppr" pour recommncer l'étape.  
![Premier écran du V-Pro](./images/VPro/Vpro-Accueil.png)
Sur le premier écran taper sur la touche "entrée" et saisir le mot de passe "qd,in"
![Premier mot de passe](./images/VPro/Vpro-Password1.png)

Saisir le nouveau mot de passe "1*xg9ioV" (on prendra soin d'utiilser le pavé numérique pour les chiffres et l'astérisque), appuyer sur la touche "entree" puis re-entrer le mot de passe pour valider.  
Activer la fonction AMt comme dans l'image ci-dessous
![Activation AMT](./images/VPro/Vpro-ActivationAMT.png)
Sortir du menu avec la touche "échap", puis rentrer dans le menu "intel amt configuration"  
![Config AMT 1](./images/VPro/Vpro-AMTConfig1.png)

Puis dans le sous-menu "user consent" passer les valeurs :
User Opt-in -> none
Opt-in configurable from Remote IT -> Enable
![Config AMT 2](./images/VPro/Vpro-AMTConfig2.png)
![Config AMT 3](./images/VPro/Vpro-AMTConfig3.png)

Sortir du menu et activer l'option "activate network access" et valider avec la touche "y"

Passer au sous menu Network setup : mettre les options DHCP en false et remplir les champs avec ce qui à été fourni par la production
![Config AMT 4](./images/VPro/Vpro-AMTConfig4.png)
![Config AMT 5](./images/VPro/Vpro-AMTConfig5.png)  
Puis passer au menu "power control" et mettre la valeur du "IDLE timeout" à 1800  

![Config AMT 6](./images/VPro/Vpro-AMTConfig6.png)
![Config AMT 7](./images/VPro/Vpro-AMTConfig7.png)
![Config AMT 8](./images/VPro/Vpro-AMTConfig8.png)

Quitter avec la touche échap et penser à valider avec la touche "Y"  
![Config AMT 9](./images/VPro/Vpro-AMTConfig9.png)
