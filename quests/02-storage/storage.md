## Storage Account Creation YAML

Do not ever feel like you can't just copy and paste from work you already did.  I took the YAML file for the Linux VM and tweaked it for the storage account. 

I also used this as Microsoft Learn guide: [Quickstart: Deploy Bicep files by using GitHub Actions](http://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=CLI%2Copenid)

Other Changes I Made:

1. Added the bicep lint to the YAML file
2. Changed the Secret structure to point to the JSON script that houses the Tenant ID, Subscription ID, and Client ID

# Storage Account Created 

I ran the new storage account [yaml](https://github.com/shevonnepolastre/minecraft-azure-quests/blob/main/quests/02-storage/deploy-storage-account.yml) and it created a new [storage account](https://github.com/shevonnepolastre/minecraft-azure-quests/blob/main/quests/02-storage/storage.bicep).  

# Blob Creation

Creating the blob container in the portal is super easy.  If you want to use Powershell, you can use the cmdlet "New-AzStorageContainer"

Before you can use that cmdlet, you have to pass in a storage context.  

```powershell 

New-AzStorageContext -StorageAccountName "storageaccountname" -StorageAccountKey "ends with ==" 

```

You will get the following message:

StorageAccountName  : storageaccountname
BlobEndPoint        : https://storageaccountname.blob.core.windows.net/
TableEndPoint       : https://storageaccountname.table.core.windows.net/
QueueEndPoint       : https://storageaccountname.queue.core.windows.net/
FileEndPoint        : https://storageaccountname.file.core.windows.net/
Context             : Microsoft.WindowsAzure.Commands.Storage.Common.AzureStorageContext
Name                : 
StorageAccount      : BlobEndpoint=https://storageaccountname.blob.core.windows.net/;QueueEndpoint=https://storageaccountname.queue.co
                      re.windows.net/;TableEndpoint=https://storageaccountname.table.core.windows.net/;FileEndpoint=https://storageaccountname
                      2kuwb4em.file.core.windows.net/;AccountName=storageaccountname;AccountKey=[key hidden]
TableStorageAccount : BlobEndpoint=https://storageaccountname.blob.core.windows.net/;QueueEndpoint=https://storageaccountname.queue.co
                      re.windows.net/;TableEndpoint=https://storageaccountname.table.core.windows.net/;FileEndpoint=https://storageaccountname
                      2kuwb4em.file.core.windows.net/;DefaultEndpointsProtocol=https;AccountName=storageaccountname;AccountKey=[key 
                      hidden]
Track2OauthToken    : 
ShareTokenIntent    : 
EndPointSuffix      : core.windows.net/
ConnectionString    : BlobEndpoint=https://storageaccountname.blob.core.windows.net/;QueueEndpoint=https://storageaccountname.queue.co
                      re.windows.net/;TableEndpoint=https://storageaccountname.table.core.windows.net/;FileEndpoint=https://storageaccountname
                      2kuwb4em.file.core.windows.net/;AccountName=storageaccountname;AccountKey=randomlettersandnumbers==
ExtendedProperties  : {}