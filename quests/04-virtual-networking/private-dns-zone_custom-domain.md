# Create Private DNS Zone 

This is the script I created 

```powershell

Install-Module -Name Az.PrivateDns -Scope CurrentUser -force

Connect-AzAccount`

Set-AzContext -Subscription "SubID or Name"`

$vnet = Get-AzVirtualNetwork -ResourceGroupName MinecraftRG -Name minecraft-vm-vnet 
$subnet = Get-AzVirtualNetworkSubnetConfig -Name "default" 

$zone = New-AzPrivateDnsZone -Name "minecraftazure.com" -ResourceGroupName "MinecraftRG"

$link = New-AzPrivateDnsVirtualNetworkLink -ZoneName private.minecraftazure.com -ResourceGroupName MinecraftRG -Name "mclink" -VirtualNetworkId $vnet.id -EnableRegistration
```

Go into the portal and make sure to create an A record for "www" that points to your VM
