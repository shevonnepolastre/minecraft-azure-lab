# Connect to Microsoft Graph with required permissions
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All"

# Import specific Microsoft Graph modules
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
$csvPath = "/Users/shevonnepolastre/Downloads/create_users.csv"
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
