#!/bin/bash
# Creates the week 3 lab VM with Azure CLI commands, one step at a time (imperative).
# Needs az login and ~/.ssh/id_ed25519.pub.
set -euo pipefail

RG=rg-vm-w03
VM=vm-lab-w03
NSG=nsg-vm-lab-w03
MYIP=$(curl -s https://api.ipify.org)

az group create --name "$RG" --location uksouth --tags env=lab owner=jason week=03
az vm create --resource-group "$RG" --name "$VM" --image Ubuntu2404 --size Standard_B1s \
  --admin-username jason --ssh-key-values ~/.ssh/id_ed25519.pub \
  --nsg "$NSG" --nsg-rule NONE --public-ip-sku Standard --tags env=lab owner=jason week=03
az network nsg rule create --resource-group "$RG" --nsg-name "$NSG" --name allow-ssh-from-me \
  --priority 100 --source-address-prefixes "$MYIP/32" --destination-port-ranges 22 \
  --protocol Tcp --access Allow
az vm auto-shutdown --resource-group "$RG" --name "$VM" --time 1800
IP=$(az vm show --show-details --resource-group "$RG" --name "$VM" --query publicIps --output tsv)
echo "ssh jason@$IP"
