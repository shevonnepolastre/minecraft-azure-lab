## Storage Account Creation YAML

Do not ever feel like you can't just copy and paste from work you already did.  I took the YAML file for the Linux VM and tweaked it for the storage account. 

I also used this as Microsoft Learn guide: [Quickstart: Deploy Bicep files by using GitHub Actions](http://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=CLI%2Copenid)

Other Changes I Made:

1. Added the bicep lint to the YAML file
2. Changed the Secret structure to point to the JSON script that houses the Tenant ID, Subscription ID, and Client ID

