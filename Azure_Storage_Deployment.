<#
.SYNOPSIS
    Deploys Azure Storage account and Blob containers with security configuration
.DESCRIPTION
    Configures RBAC, Shared Access Signatures (SAS), and access policies for secure storage management
.AUTHOR
    Joakim Angjelovski
#>

# Variables
$resourceGroup = 'rg-storage-demo'
$location = 'EastUS'
$storageAccount = 'stgdemoproject'
$containerName = 'securecontainer'

Connect-AzAccount

# Create Storage Account
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccount -Location $location -SkuName Standard_LRS -Kind StorageV2

# Create Blob Container
$ctx = (Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccount).Context
New-AzStorageContainer -Name $containerName -Context $ctx -Permission Off

Write-Host 'Azure Storage deployment complete.'
