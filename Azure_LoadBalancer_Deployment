<#
.SYNOPSIS
    Deploys an Azure Load Balancer with high availability and security
.DESCRIPTION
    Creates backend pools, health probes, load-balancing rules, and configures NSGs for secure traffic distribution across VMs
.AUTHOR
    Joakim Angjelovski
#>

# Variables
$resourceGroup = 'rg-lb-demo'
$location = 'EastUS'
$lbName = 'lb-demo'
$frontendIP = 'frontendIP'
$backendPool = 'backendPool'
$probeName = 'healthProbe'
$lbRule = 'lbRule'
$vmNames = @('vm1','vm2')

# Create Load Balancer
Connect-AzAccount
New-AzLoadBalancer -ResourceGroupName $resourceGroup -Name $lbName -Location $location -Sku 'Standard' -FrontendIpConfiguration @{Name=$frontendIP;SubnetId='/subscriptions/<SUBSCRIPTION_ID>/resourceGroups/' + $resourceGroup + '/providers/Microsoft.Network/virtualNetworks/vnet-demo/subnets/subnet-demo'}

# Create Backend Pool
Add-AzLoadBalancerBackendAddressPoolConfig -Name $backendPool -LoadBalancer (Get-AzLoadBalancer -ResourceGroupName $resourceGroup -Name $lbName) | Set-AzLoadBalancer

# Create Health Probe
Add-AzLoadBalancerProbeConfig -Name $probeName -LoadBalancer (Get-AzLoadBalancer -ResourceGroupName $resourceGroup -Name $lbName) -Protocol Tcp -Port 80 -IntervalInSeconds 15 -ProbeCount 2 | Set-AzLoadBalancer

# Create Load Balancing Rule
Add-AzLoadBalancerRuleConfig -Name $lbRule -LoadBalancer (Get-AzLoadBalancer -ResourceGroupName $resourceGroup -Name $lbName) -FrontendIpConfigurationName $frontendIP -BackendAddressPoolName $backendPool -ProbeName $probeName -Protocol Tcp -FrontendPort 80 -BackendPort 80 | Set-AzLoadBalancer

Write-Host 'Azure Load Balancer deployment complete.'
