# azure-linux-vm-bicep

One small Ubuntu VM on Azure built two ways: step by step with Azure CLI commands (create-vm-cli.sh) and declared in Bicep (main.bicep). Lab work from week 3 of my Azure and DevOps training.

## What it builds
A Standard_B1s Ubuntu 24.04 VM in uksouth with SSH-key login only, an NSG that allows SSH from my IP alone, a static public IP and auto-shutdown at 19:00 UK time. Every resource is tagged env=lab, owner=jason and week=03.

## Deploy with Bicep
    az group create --name rg-bicep-w03 --location uksouth
    az deployment group what-if --resource-group rg-bicep-w03 --template-file main.bicep --parameters myIp=<your IP> sshPublicKey="$(cat ~/.ssh/id_ed25519.pub)"
    az deployment group create --resource-group rg-bicep-w03 --template-file main.bicep --parameters myIp=<your IP> sshPublicKey="$(cat ~/.ssh/id_ed25519.pub)"

## Tear down
    az group delete --name rg-bicep-w03 --yes

## Cost
A B1s VM, a small disk and a static IP cost a few pence for a two-hour lab. Delete the resource group when you finish.

## CLI or Bicep
- The CLI script runs steps in order (imperative). Run it twice and it fails or repeats work.
- The Bicep file declares the end state (declarative). What-if shows the difference first, and running it twice changes nothing.

## What I learned
- 
- 
- 
