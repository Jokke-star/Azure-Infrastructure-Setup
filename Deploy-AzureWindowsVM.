<#
.SYNOPSIS
    Deploys a Windows Server 2019 Virtual Machine in Microsoft Azure using PowerShell.

.DESCRIPTION
    This script creates a complete Azure infrastructure setup:
    - Resource Group
    - Virtual Network and Subnet
    - Network Security Group with RDP rule
    - Public IP
    - Network Interface
    - Windows Virtual Machine

    It uses the Az PowerShell module and requires the user to sign in before running.

.AUTHOR
    Joakim Angjelovski
#>

# Variables - Modify these as needed
$resourceGroup = "MyResourceGroup"
$location = "EastUS"
$vmName = "MyWindowsVM"
$vnetName = "$vmName-VNet"
$subnetName = "$vmName-Subnet"
$ipName = "$vmName-PublicIP"
$nsgName = "$vmName-NSG"
$nicName = "$vmName-NIC"

# Sign in to Azure account
Write-Host "Signing in to Azure..."
Connect-AzAccount

# Create Resource Group
Write-Host "Creating Resource Group..."
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Virtual Network and Subnet
Write-Host "Creating Virtual Network and Subnet..."
$vnet = New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location `
    -AddressPrefix "10.0.0.0/16"

$subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix "10.0.0.0/24" -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

# Create Public IP Address
Write-Host "Creating Public IP..."
$publicIP = New-AzPublicIpAddress -Name $ipName -ResourceGroupName $resourceGroup -Location $location `
    -AllocationMethod Dynamic

# Create Network Security Group and RDP Rule
Write-Host "Creating Network Security Group and RDP rule..."
$nsgRuleRDP = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Protocol "Tcp" -Direction Inbound `
    -Priority 1000 -SourceAddressPrefix "*" -SourcePortRange "*" `
    -DestinationAddressPrefix "*" -DestinationPortRange 3389 -Access Allow

$nsg = New-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $resourceGroup -Location $location `
    -SecurityRules $nsgRuleRDP

# Create Network Interface
Write-Host "Creating Network Interface..."
$nic = New-AzNetworkInterface -Name $nicName -ResourceGroupName $resourceGroup -Location $location `
    -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIP.Id -NetworkSecurityGroupId $nsg.Id

# Prompt for Admin Credentials
Write-Host "Enter administrator credentials for the VM:"
$cred = Get-Credential

# Configure the Virtual Machine
Write-Host "Configuring Virtual Machine..."
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_DS1_v2" |
    Set-AzVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred -ProvisionVMAgent -EnableAutoUpdate |
    Set-AzVMSourceImage -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" `
        -Skus "2019-Datacenter" -Version "latest" |
    Add-AzVMNetworkInterface -Id $nic.Id

# Create the VM
Write-Host "Deploying Virtual Machine..."
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vmConfig

Write-Host "Deployment Complete!"
