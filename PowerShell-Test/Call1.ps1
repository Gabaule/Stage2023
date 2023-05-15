Write-Output "On est dans le script 1"


# connexion ESX
#
Set-PowerCLIConfiguration -ProxyPolicy NoProxy -Confirm:$false

write-output "**** Connexion ESX "
Connect-VIServer -Server 192.168.99.128 -User root -Password vfsi7813 -Force

# ESX version et numero de build

$ESXver=(Get-VMHost).version
$ESXBuild=(Get-VMHost).build

write-output "**** Versions présentes : " $ESXver $ESXBuild



# fin et reboot

write-output "**** Reboot ESX "
Restart-VMHost -Server 192.168.99.128 -Confirm:$false -Force
Disconnect-VIServer -Force
Start-Sleep -Seconds 90
