# Create User Groups and Users for Minecraft 

You have three groups of users that need access to Minecraft.  They are:

1. Villagers
2. Endermen 
3. Piglins

Each has three users underneath them.  

## Villager Users 

The names for the three villagers are:

1. Anne Butcher, anne.butcher@mcvillage.com
2. John Farmer, john.farmer@mcvillage.com
3. Tom Armorer, tom.armorer@mcvillage.com

## Endermen Users

The names of the three endermen are:

1. Rob Ender, rob.ender@mcender.com
2. Lucy Ender, lucy.ender@mcender.com
3. Izzy Ender. izzy.ender@mcender.com

## Piglin Users 

The names of the three piglin users are:

1. Tom Piglin, tom.piglin@mcpiglin.com
2. Alan Piglin, alan.piglin@mcpiglin.com
3. Bo Piglin, bo.piglin@mcpiglin.com

# MS Graph

Going to use MS Graph SDK for this quest.  To get started, you have to install it.  The command is:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force
```
It's always good to verify that it actually installed.  You can do so by:

```powershell

Get-InstalledModule Microsoft.Graph

```

You should get 

| Version | Name | Repository | Description |
| ------------- | ------------- |------------- | ------------- |
| 2.26.1  | Microsoft.Graph  | PSGallery | Microsoft Graph Powershell module |


# Create groups




