<#
.SYNOPSIS
    Deploys an Azure Firewall with network security rules
.DESCRIPTION
    Configures application and network rules to control inbound/outbound traffic
.AUTHOR
    Joakim Angjelovski
#>

# Variables
$resourceGroup = 'rg-fw-demo'
$location = 'EastUS'
$firewallName = 'fw-demo'
$vnetName = 'vnet-fw-demo'
$subnetName = 'AzureFirewallSubnet'

Connect-AzAccount

# Create Firewall
$firewall = New-AzFirewall -Name $firewallName -ResourceGroupName $resourceGroup -Location $location -VirtualNetworkId '/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/' + $resourceGroup + '/providers/Microsoft.Network/virtualNetworks/' + $vnetName

# Add Network Rule
$networkRule = New-AzFirewallNetworkRule -Name 'Allow-HTTP' -Protocol 'TCP' -SourceAddress 'Any' -DestinationAddress 'Any' -DestinationPort 80
Add-AzFirewallNetworkRuleCollection -AzureFirewall $firewall -Name 'NetRuleCollection' -Priority 100 -Action 'Allow' -Rule $networkRule

Write-Host 'Azure Firewall deployment complete.'
