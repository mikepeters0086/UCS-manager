# Collect Inventory for CAG Cisco UCS Blade Servers
# Created by zmp0167    02\26\2020

# Load Cisco UCS PowerTools module
'D:\Program Files (x86)\Cisco\Cisco UCS PowerTool\Modules\CiscoUcsPS\startucsps.ps1'

# Allow Multiple UCS Domain logins
Set-UcsPowerToolConfiguration -SupportMultipleDefaultUcs $true

#Get Creds
#Enter UCS credentials
$cred = Get-Credential -Message "Enter UCSM Credentials (Username format: ucs-cag\zID)"

#Connect to CAG UCS Domains
Write-Output ""
Write-Output "UCS BlockBA"
connect-ucs blockba -credential $cred
Write-Output "UCS BlockBE"
connect-ucs blockbe -credential $cred
Write-Output "UCS BlockCA"
connect-ucs blockca -credential $cred
Write-Output "UCS BlockCB"
connect-ucs blockcb -credential $cred
Write-Output "UCS BlockCC"
connect-ucs blockcc -credential $cred

$bladeData=get-ucsblade |Select-Object Ucs, Dn, Serial, NumOfCpus, NumOfCores, TotalMemory, AvailableMemory, MemorySpeed, Model, MfgTime, OperState, AssignedToDn

$logFile="\\vnasfil02\scratch$\zmp0167\UCS Inventory\CAGUCSinv-$((Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')).csv"

$bladeData |export-csv -Path $logFile

Disconnect-Ucs

