Write-Output "On est dans le script général"
Start-Sleep 3
Invoke-Expression -Command "C:\Users\Gabriel\Desktop\Stage2023\PowerShell-Test\Call1.ps1"
Write-Output "----- Script 1 fini -----"
Write-Output "`n"
Invoke-Expression -Command "C:\Users\Gabriel\Desktop\Stage2023\PowerShell-Test\Call2.ps1"
Write-Output "----- Script 2 fini -----"
Write-Output "`n"