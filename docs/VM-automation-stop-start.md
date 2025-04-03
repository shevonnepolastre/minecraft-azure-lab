# Azure Automation: Auto Start/Stop VM

Having your VMs running 24/7 can be super expensive.  If you are not someone who needs a Minecraft server running all day, then a good way to shut it down is to create runbooks that you put on a schedule so you never have to wake up with a huge bill.  

## High-Level Steps
1. Create a Automation Account
2. Create scripts for stopping and starting your VMs
3. Add to Runbooks 
4. Create a schedule 

### Create an Automation Account 

You can either create it in the portal or use this command [New-AzAutomationAccount](https://learn.microsoft.com/en-us/powershell/module/az.automation/new-azautomationaccount?view=azps-13.3.0)  

If you do it via the portal, just search for "Automation Accounts" and then follow the promppts to create it.  

### Create scripts 

I found this in a [Stack Overflow](https://stackoverflow.com/questions/76004466/start-stop-azvm-not-working-properly-with-automation) thread, tweaked it, and used it:

```powershell
workflow new
{
Param(
[Parameter(Mandatory=$true)]
[String]
$TagName,
[Parameter(Mandatory=$true)]
[String]
$TagValue,
[Parameter(Mandatory=$true)]
[Boolean]
$PowerState
)

$AzureContext = (Connect-AzAccount -Identity -AccountId "Userclient_ID").context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext
$vms = Get-AzResource -ResourceType Microsoft.Compute/virtualMachines -TagName $TagName -TagValue $TagValue
Foreach -Parallel ($vm  in  $vms){
if($PowerState){
Start-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName;
Write-Output "Starting $($vm.Name)";
}
else{
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName -Force;
Write-Output "Stopping $($vm.Name)";
    }
 }
}
```
