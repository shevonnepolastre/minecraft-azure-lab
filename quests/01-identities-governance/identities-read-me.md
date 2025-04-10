# Create User Groups and Users for Minecraft 

You have three groups of users that need access to Minecraft.  They are:

1. Villagers
2. Endermen 
3. Piglins

Each has three users underneath them.  

## Villager Users 

The names for the three villagers are:

1. Anne Butcher, anne.butcher@spolastrelive.onmicrosoft.com
2. John Farmer, john.farmer@spolastrelive.onmicrosoft.com
3. Tom Armorer, tom.armorer@spolastrelive.onmicrosoft.com

## Endermen Users

The names of the three endermen are:

1. Rob Ender, rob.ender@spolastrelive.onmicrosoft.com
2. Lucy Ender, lucy.ender@spolastrelive.onmicrosoft.com
3. Izzy Ender. izzy.ender@spolastrelive.onmicrosoft.com

## Piglin Users 

The names of the three piglin users are:

1. Tom Piglin, tom.piglin@spolastrelive.onmicrosoft.com
2. Alan Piglin, alan.piglin@spolastrelive.onmicrosoft.com
3. Bo Piglin, bo.piglin@spolastrelive.onmicrosoft.com

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

# Evolution of the Powershell Script

At first, I created the following script:

```powershell

# Connect to Azure and MS Graph
Connect-AzAccount
Set-AzContext -Subscription "Your Subscription Name or ID"
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

# Create security groups
$villagers = New-MgGroup -DisplayName "Villagers" `
                         -MailEnabled:$false `
                         -MailNickname "villagers" `
                         -SecurityEnabled:$true `
                         -GroupTypes @()

$endermen = New-MgGroup -DisplayName "Endermen" `
                        -MailEnabled:$false `
                        -MailNickname "endermen" `
                        -SecurityEnabled:$true `
                        -GroupTypes @()

$piglins = New-MgGroup -DisplayName "Piglins" `
                       -MailEnabled:$false `
                       -MailNickname "piglins" `
                       -SecurityEnabled:$true `
                       -GroupTypes @()

# Import users from CSV
$csvPath = "$HOME/Downloads/create_users.csv"
$users = Import-Csv $csvPath

foreach ($user in $users) {
    try {
        # Create the user
        New-MgUser -UserPrincipalName $user.UserPrincipalName -DisplayName $user.DisplayName -PasswordProfile @{
            Password = $user.Password
            ForceChangePasswordNextLogin = $false
        } -AccountEnabled $false

        Write-Host "User $($user.UserPrincipalName) created successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Error creating user $($user.UserPrincipalName): $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Add users to groups by domain
$villagerUsers = Get-MgUser -Filter "endsWith(userPrincipalName,'@mcvillage.com')" `
                            -ConsistencyLevel eventual `
                            -CountVariable temp

foreach ($user in $villagerUsers) {
    New-MgGroupMember -GroupId $villagers.Id -DirectoryObjectId $user.Id
}

$endermenUsers = Get-MgUser -Filter "endsWith(userPrincipalName,'@mcender.com')" `
                            -ConsistencyLevel eventual `
                            -CountVariable temp

foreach ($user in $endermenUsers) {
    New-MgGroupMember -GroupId $endermen.Id -DirectoryObjectId $user.Id
}

$piglinUsers = Get-MgUser -Filter "endsWith(userPrincipalName,'@mcpiglin.com')" `
                           -ConsistencyLevel eventual `
                           -CountVariable temp

foreach ($user in $piglinUsers) {
    New-MgGroupMember -GroupId $piglins.Id -DirectoryObjectId $user.Id
}





```

However, I was getting a few errors.  With a bit of help with ChatGPT, I improved the Powershell script to the following:

```powershell

# Connect to Microsoft Graph with required permissions
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Import specific Microsoft Graph modules and had to specify individual MSGraph modules due to a known issue with updating all of the MSGraph modules on a Mac.  It kept hanging for me.

Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups
Import-Module Microsoft.Graph.DirectoryObjects

# Define the groups to create
$groupNames = @("Villagers", "Endermen", "Piglins")
$groupMap = @{}

foreach ($groupName in $groupNames) {
    try {
        $group = New-MgGroup -DisplayName $groupName `
                             -MailEnabled:$false `
                             -MailNickname $groupName.ToLower() `
                             -SecurityEnabled:$true `
                             -GroupTypes @()
        $groupMap[$groupName] = $group.Id
        Write-Host "Created group: $groupName" -ForegroundColor Green
    } catch {
        Write-Host "Group $groupName may already exist. Skipping..." -ForegroundColor Yellow
        $existing = Get-MgGroup -Filter "displayName eq '$groupName'"
        $groupMap[$groupName] = $existing.Id
    }
}

# Load users from CSV file in your local Downloads folder (update username if needed)
$csvPath = "/Users/shevonnepolastre/Downloads/create_usersv5.csv"
$users = Import-Csv $csvPath

foreach ($user in $users) {
    try {
        # Check if user already exists
        $existingUser = Get-MgUser -Filter "userPrincipalName eq '$($user.UserPrincipalName)'" -ErrorAction SilentlyContinue
        if ($existingUser) {
            Write-Host "User $($user.UserPrincipalName) already exists. Skipping..." -ForegroundColor Yellow
            continue
        }

        # Create user
        Write-Host "Creating user: $($user.UserPrincipalName)" -ForegroundColor Cyan
        $newUser = New-MgUser -DisplayName $user.DisplayName `
                              -UserPrincipalName $user.UserPrincipalName `
                              -PasswordProfile @{
                                  Password = $user.Password;
                                  ForceChangePasswordNextSignIn = $true
                              } `
                              -AccountEnabled:$true `
                              -MailNickname $user.MailNickname

        # Add to group
        $groupName = $user.Group
        if ($newUser -ne $null -and $groupMap.ContainsKey($groupName)) {
            Write-Host "Adding $($user.DisplayName) to $groupName group"
            New-MgGroupMember -GroupId $groupMap[$groupName] -DirectoryObjectId $newUser.Id
        } else {
            Write-Host "User $($user.DisplayName) could not be added to group $groupName" -ForegroundColor Yellow
        }

    } catch {
        Write-Host "❌ Error creating user $($user.UserPrincipalName): $($_.Exception.Message)" -ForegroundColor Red
    }
}

```


Due to some issues with installing MSGraph modules on a Mac, I had to specify the three modules that I was actually going to use. Those are: 

Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups
Import-Module Microsoft.Graph.DirectoryObjects

I then created a ForEach loop.  How it works is that:

1. You specify the group names and store them in a variable called $groupNames
2. You then create a [hashtable](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.5) to collect them.
3. The ForEach loop then indicates that each group name gets created.
   a. MailEnabled means that it is a 365 group.  This was is not so it's set to "false:
   b. The MailNickname is the group name in lower-case
   c. SecurityEnabled means that it's a security group
   d. GroupType being a blank array means that I do not want a dynamic group.  Just a standard one.
   e. You then store the ID for each group in the $groupMap hashtable under a name called $groupName

Difference between a hashtable and array and why you want to use a hashtable:

| Type	| Syntax | 	Example |	What It Does |
| ------------- | ------------- |------------- | ------------- |
|Array	| @()	| @("Villagers", "Piglins")	| Just a list of items by index
|Hashtable |	@{}	| @{ "Villagers" = "abc123" } | A key-value pair dictionary

We need the group ID so that's why it's better to use the hashtable. 


# Define the groups to create
$groupNames = @("Villagers", "Endermen", "Piglins")
$groupMap = @{}

foreach ($groupName in $groupNames) {
    try {
        $group = New-MgGroup -DisplayName $groupName `
                             -MailEnabled:$false `
                             -MailNickname $groupName.ToLower() `
                             -SecurityEnabled:$true `
                             -GroupTypes @()
        $groupMap[$groupName] = $group.Id
        Write-Host "Created group: $groupName" -ForegroundColor Green
    } catch {
        Write-Host "Group $groupName may already exist. Skipping..." -ForegroundColor Yellow
        $existing = Get-MgGroup -Filter "displayName eq '$groupName'"
        $groupMap[$groupName] = $existing.Id
    }
}

# Import CSV file

Instead of creating users one-by-one, add them all into a [CSV file]( and then import into this script to have the users you want to create. 

# Create users

After importing the file, you can now create the users. This code is similar to what I used for creating the groups.

```powershell

foreach ($user in $users) {
    try {
        # Check if user already exists
        $existingUser = Get-MgUser -Filter "userPrincipalName eq '$($user.UserPrincipalName)'" -ErrorAction SilentlyContinue
        if ($existingUser) {
            Write-Host "User $($user.UserPrincipalName) already exists. Skipping..." -ForegroundColor Yellow
            continue
        }

        # Create user
        Write-Host "Creating user: $($user.UserPrincipalName)" -ForegroundColor Cyan
        $newUser = New-MgUser -DisplayName $user.DisplayName `
                              -UserPrincipalName $user.UserPrincipalName `
                              -PasswordProfile @{
                                  Password = $user.Password;
                                  ForceChangePasswordNextSignIn = $true
                              } `
                              -AccountEnabled:$true `
                              -MailNickname $user.MailNickname


```

# Add to group

We have created our groups and users.  It's now time to add those users into their groups.  

```powershell
 $groupName = $user.Group
        if ($newUser -ne $null -and $groupMap.ContainsKey($groupName)) {
            Write-Host "Adding $($user.DisplayName) to $groupName group"
            New-MgGroupMember -GroupId $groupMap[$groupName] -DirectoryObjectId $newUser.Id
        } else {
            Write-Host "User $($user.DisplayName) could not be added to group $groupName" -ForegroundColor Yellow
        }
```

You have your hashtable with the group IDs.  It will be for each user.  If the new user is not existing, then it will be added as a member of its related group.  If not, you will be a message (Write-Host are outputs) that say that the user could be not be added. 


# My experience 

The only way to learn is trial and error, and then trying to figure out what went wrong.  I made five iterations of the CSV file because I had forgotten key data in the previous four.  Additionally, my original script created the groups and users, but it would not add the users to the groups.  Using the hashtable helped tremendously because I was having trouble getting the group ID.  
