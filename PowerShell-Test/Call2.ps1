Write-Output "On est dans le script 2"
$ESX = "192.168.99.128"
$LicenceESXFree = '5101H-06H11-080P8-03CHH-ANAL0'


# connexion ESX
#
Set-PowerCLIConfiguration -ProxyPolicy NoProxy -Confirm:$false

write-output "**** Connexion ESX "
Connect-VIServer -Server 192.168.99.128 -User root -Password vfsi7813 -Force

# Retour Licence

write-output "**** Installation Licence ESX FREE "
Set-VMHost -Server $ESX -LicenseKey $LicenceESXFree

# fin des opérations et deconnexion

Disconnect-VIServer -Server $ESX -Confirm:$false
