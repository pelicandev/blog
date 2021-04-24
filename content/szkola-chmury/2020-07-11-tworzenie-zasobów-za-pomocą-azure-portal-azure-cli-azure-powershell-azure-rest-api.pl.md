---
title: 'Tworzenie zasobów za pomocą Azure Portal, Azure CLI, Azure PowerShell, Azure Rest API'
date: 2020-07-11T21:00:00+02:00
tags: ["azure","azure-development", "development", "szkoła-chmury", "homework"]
aliases: 
     - "/pl/2020/07/11/tworzenie-zasobów-za-pomocą-azure-portal-azure-cli-azure-powershell-azure-rest-api/"
     - "/pl/szkola-chmury/2020-07-11-tworzenie-zasobów-za-pomocą-azure-portal-azure-cli-azure-powershell-azure-rest-api/"
---

[Zadanie domowe z tygodnia 2 (Microsoft Azure – Software Development)](https://szkolachmury.pl/google-cloud-platform-droga-architekta/tydzien-2-podstawy-pracy-z-gcp/zadanie-domowe-nr-2/)

---

#### 1. Utworzenie `Resource group`
Utworzenie `Resource group` za pomocą:
* Azure Portal
* Azure CLI
* PowerShell
* Azure Rest API

#### 1.1 Azure Portal

![azure portal create resource group][img-azure-portal-create-resource-group]
![azure portal review creating resource group][img-azure-portal-review-creating-resource-group]
![azure portal list of resource group][img-azure-portal-list-of-resource-group]

#### 1.2 Azure CLI
```bash
RG_NAME="rg-azdev-zad2-cli"
RG_LOCATION="westeurope"

az group create -n $RG_NAME -l $RG_LOCATION 
```

```bash
bartosz@Azure:~$ az account list-locations -o table
DisplayName           Latitude    Longitude    Name
--------------------  ----------  -----------  ------------------
East Asia             22.267      114.188      eastasia
Southeast Asia        1.283       103.833      southeastasia
Central US            41.5908     -93.6208     centralus
East US               37.3719     -79.8164     eastus
East US 2             36.6681     -78.3889     eastus2
West US               37.783      -122.417     westus
North Central US      41.8819     -87.6278     northcentralus
South Central US      29.4167     -98.5        southcentralus
North Europe          53.3478     -6.2597      northeurope
West Europe           52.3667     4.9          westeurope
{...}
bartosz@Azure:~$ RG_NAME="rg-azdev-zad2-cli"
bartosz@Azure:~$ RG_LOCATION="westeurope"
bartosz@Azure:~$ az group create -n $RG_NAME -l $RG_LOCATION
{
  "id": "/subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-azdev-zad2-cli",
  "location": "westeurope",
  "managedBy": null,
  "name": "rg-azdev-zad2-cli",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
bartosz@Azure:~$ az group list -o table
Name                            Location    Status
------------------------------  ----------  ---------
rg-automation                   westeurope  Succeeded
rg-azdev-zad2-portal            westeurope  Succeeded
cloud-shell-storage-westeurope  westeurope  Succeeded
rg-azdev-zad2-cli               westeurope  Succeeded
```

#### 1.3 PowerShell
```PowerShell
$RG_NAME="rg-azdev-zad2-powershell"
$RG_LOCATION="westeurope"

New-AzureRmResourceGroup -Name $RG_NAME -Location $RG_LOCATION
```

```PowerShell
PS /home/bartosz> $RG_NAME="rg-azdev-zad2-powershell"
PS /home/bartosz> $RG_LOCATION="westeurope"
PS /home/bartosz> New-AzureRmResourceGroup -Name $RG_NAME -Location $RG_LOCATION

ResourceGroupName : rg-azdev-zad2-powershell
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-azdev-zad2-powershell

PS /home/bartosz> Get-AzureRmResourceGroup

ResourceGroupName : rg-automation
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
                    Name    Value
                    ======  =====
                    Locked  yes

ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-automation

ResourceGroupName : rg-azdev-zad2-portal
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-azdev-zad2-portal

ResourceGroupName : cloud-shell-storage-westeurope
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/cloud-shell-storage-westeurope

ResourceGroupName : rg-azdev-zad2-cli
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-azdev-zad2-cli

ResourceGroupName : rg-azdev-zad2-powershell
Location          : westeurope
ProvisioningState : Succeeded
Tags              :
ResourceId        : /subscriptions/748173f1-20c4-4e68-ac58-641f67a83501/resourceGroups/rg-azdev-zad2-powershell
```

#### 1.4 Azure Rest API

![azure rest api create resource group][img-azure-rest-api-create-resource-group]
![azure rest api list of resource group][img-azure-rest-api-list-of-resource-group]

---

[img-azure-portal-create-resource-group]: https://pelicandev.io/images/2020/07/11/azure-portal-create-resource-group.jpg
[img-azure-portal-review-creating-resource-group]: https://pelicandev.io/images/2020/07/11/azure-portal-review-creating-resource-group.jpg
[img-azure-portal-list-of-resource-group]: https://pelicandev.io/images/2020/07/11/azure-portal-list-of-resource-group.jpg
[img-azure-rest-api-create-resource-group]: https://pelicandev.io/images/2020/07/11/azure-rest-api-create-resource-group.jpg
[img-azure-rest-api-list-of-resource-group]: https://pelicandev.io/images/2020/07/11/azure-rest-api-list-of-resource-group.jpg
