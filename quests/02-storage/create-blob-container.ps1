$resourceGroupName = "MinecraftRG"
$storageAccountName = "mystorekffa42kuwb4em"

$keys = Get-AzStorageAccountKey -ResourceGroupName "MinecraftRG" -Name "mystorekffa42kuwb4em"
$key = $keys[1].Value  # try the second key this time
$storageContext = New-AzStorageContext -StorageAccountName "mystorekffa42kuwb4em" -StorageAccountKey $key
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $key

New-AzStorageContainer -Name "worldstorage" -Context $storageContext -Permission Off

