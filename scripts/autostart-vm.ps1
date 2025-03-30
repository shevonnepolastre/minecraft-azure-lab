Param(
    [string]$resourceGroup = "MinecraftRG",
    [string]$vmName = "minecraft-vm"
)

Disable-AzContextAutosave -Scope Process

# Connect using User-assigned Managed Identity
$clientId = "caf18728-b23d-47d8-936f-abbe6bc7056e"
Connect-AzAccount -Identity -AccountId $clientId

$subscriptionId = "3d36185b-63ee-4012-b04c-98a78f4bf5d7"
$AzureContext = Set-AzContext -SubscriptionId $subscriptionId

Start-AzVM -ResourceGroupName $resourceGroup -Name $vmName -DefaultProfile $AzureContext
