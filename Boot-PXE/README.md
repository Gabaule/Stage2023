# Boot PXE
Pour l'installation des NUC, le choix du boot s'est porté sur PXE  
Retire la nécéssité d'avoir une clé USB avec l'OS prêt à booter  
Besoin uniquement d'un accès à internet  

Voici la documentation utilisée et adaptée pour mettre en place un boot via le PXE : [LinuxHint](https://linuxhint.com/pxe_boot_ubuntu_server/)  

## Pré-requis

Prérequis pour mettre en place sur un serveur (ici un serveur avec Ubuntu comme OS) :  
- avoir une IP fixe de préférence, ce qui implique d'avoir accès à internet
- avoir les droits de root sur le serveur

Paquets pré-requis pour mettre en place le PXE :
- wget
- nfs-kernel-server
- dnsmasq
- build-essential 
- liblzma-dev 
- isolinux 
- git

## Structure des dossiers

Nous allons mettre en place une petite structure de dossiers  
Créer un dossier dans lequel tout sera mis : `mkdir /pxeboot`  
Dans ce dossier créer 3 sous dossiers : `mkdir -pv /pxeboot/{config,firmware,os-images}`
 - config : contient les fichiers de configuration du démarrage iPXE
 - firmaware : contient les fichiers d'amorçage des OS bootés par iPXE
 - os-images : contient un sous dossier par OS stocké avec le contenu des fichiers ISOs  

## Télecharger et compiler iPXE

Télécharger les sources de iPXe via Git `git clone https://github.com/ipxe/ipxe.git`  
Entrer dans le dossier télécharger puis dans le sous dossier `src` : `cd ipxe/src`  
Pour configurer l'iPXE afin qu'il démarre automatiquement à partir d'un script de démarrage iPXE stocké dans le répertoire `/pxeboot/config/` de votre ordinateur, créer un script de démarrage iPXE et l'intégrer au microprogramme iPXE lorsque vous le compilez. `nano bootconfig.ipxe`
Lui ajouter le contenu suivant : 
``` bash
#!ipxe
dhcp
chain tftp://<IP-V4-du-serveur>/config/boot.ipxe
```
Compiler le programme avec la commande suivante : `make bin/ipxe.pxe bin/undionly.kpxe bin/undionly.kkpxe bin/undionly.kkkpxe bin-x86_64-efi/ipxe.efi EMBED=bootconfig.ipxe`  

Copier les fichiers compilés : `cp -v bin/{ipxe.pxe,undionly.kpxe,undionly.kkpxe,undionly.kkkpxe} bin-x86_64-efi/ipxe.efi /pxeboot/firmware/`  

## Configurer le servuer DHCP et TFTP 
Copier l'ancienne configuration de **dnsmasq** (Serveur TFTP,PXE et DNS) : `mv -v /etc/dnsmasq.conf /etc/dnsmasq.conf.backup`
Créer un nouveau fichier de configuration `nano /etc/dnsmasq.conf`  
Lui ajouter le contenu suivant : 
```bash
interface=<nom-de-l-interface-reseau-du-serveur> #on peut obtenir le nmo de l'interface en faisant la commande `ip a`
bind-interfaces
dhcp-range=<interface>,<debut-de-range-possible-pour-IPv4-des-clients>,<fin-de-range-possible-pour-IP-des-clients>,<masque-du-reseau>,8h 

enable-tftp
tftp-root=/pxeboot

# boot config for BIOS systems
dhcp-match=set:bios-x86,option:client-arch,0
dhcp-boot=tag:bios-x86,firmware/ipxe.pxe

# boot config for UEFI systems
dhcp-match=set:efi-x86_64,option:client-arch,7
dhcp-match=set:efi-x86_64,option:client-arch,9
dhcp-boot=tag:efi-x86_64,firmware/ipxe.efi
```

Redémarrer le service `dnsmasq` : `systectl restart dnsmasq`

## Configuration du serveur NFS
Le serveur NFS est nécessaire afin d'installer Ubuntu
Modifier le fichier d'exports nfs : `nano /etc/exports`  
Ajouter la ligne suivante : `/pxeboot *(ro,sync,no_wdelay,insecure_locks,no_root_squash,insecure,no_subtree_check)`  
Pour rendre le partage disponible : `exportfs -av`

## Servir un OS à booter
Télecharger l'ISO de l'OS voulue via wget `wget <link-to-ISO>`  
Monter l'ISO `mount -o loop path/to/ISO /mnt`  
Créer un dossier où sera mis le contenu de l'ISO :  `mkdir -pv /pxeboot/os-images/<ISO-name>`  
Copier le contenu de l'ISO : `rsync -avz /mnt/ /pxeboot/os-images/<ISO-name>/`  
Démonter l'ISO : `umount /mnt`  

Créer le fichier de configuration pour le boot des ISO : `nano /pxeboot/config/boot.ipxe`  
Lui ajouter le contenu suivant :
```bash
#!ipxe

set server_ip  <IP-V4-du-serveur>

set root_path  /pxeboot

menu Select an OS to boot

item <nom-de-la-distribution>         <Description>

choose --default exit --timeout 10000 option && goto ${option}

:ubuntu-22.04-desktop-amd64

set os_root os-images/<iso-to-serve>

kernel tftp://${server_ip}/${os_root}/casper/vmlinuz

initrd tftp://${server_ip}/${os_root}/casper/initrd

imgargs vmlinuz initrd=initrd boot=casper maybe-ubiquity netboot=nfs ip=dhcp nfsroot=${server_ip}:${root_path}/${os_root} quiet splash ---

boot
```
