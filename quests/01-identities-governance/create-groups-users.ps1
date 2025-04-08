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



