# Azure Infrastructure Setup using Azure CLI

# Variables
location="eastus"
resourceGroup="rg-prod-eus"
virtualNetwork="vnet-prod-eus"
subnetName="subnet-prod-eus"
virtualMachine="vm-prod-eus"
image="UbuntuLTS"
adminUser="azureuser"

# Create Resource Group
echo "Creating resource group..."
az group create \
  --name $resourceGroup \
  --location $location

# Create Virtual Network
echo "Creating virtual network..."
az network vnet create \
  --resource-group $resourceGroup \
  --name $virtualNetwork \
  --address-prefix 10.0.0.0/16 \
  --subnet-name $subnetName \
  --subnet-prefix 10.0.0.0/24

# Create Public IP
echo "Creating public IP..."
az network public-ip create \
  --resource-group $resourceGroup \
  --name ${virtualMachine}-pip

# Create Network Interface
echo "Creating NIC..."
az network nic create \
  --resource-group $resourceGroup \
  --name ${virtualMachine}-nic \
  --vnet-name $virtualNetwork \
  --subnet $subnetName \
  --public-ip-address ${virtualMachine}-pip

# Create Virtual Machine
echo "Creating virtual machine..."
az vm create \
  --resource-group $resourceGroup \
  --name $virtualMachine \
  --nics ${virtualMachine}-nic \
  --image $image \
  --admin-username $adminUser \
  --generate-ssh-keys \
  --output json

echo "Deployment complete!"
echo "VM Username: $adminUser"
az vm show \
  --resource-group $resourceGroup \
  --name $virtualMachine \
  --show-details \
  --query [fqdns,publicIps,osProfile.computerName] \
  --output table
