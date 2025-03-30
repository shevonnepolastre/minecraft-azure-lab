Param(
    [string]$resourceGroup = "MinecraftRG",
    [string]$vmName = "minecraft-vm"
)

Disable-AzContextAutosave -Scope Process

# Connect using User-assigned Managed Identity
$clientId = "[client ID]"
Connect-AzAccount -Identity -AccountId $clientId

$subscriptionId = "[subscription ID]"
$AzureContext = Set-AzContext -SubscriptionId $subscriptionId

Stop-AzVM -ResourceGroupName $resourceGroup -Name $vmName -Force -DefaultProfile $AzureContext
