# Enter the base name for Azure resources (i.e. nosql)
$baseName = "nosql"
# Enter the location for the first resource group (i.e. eastus)
$location1 = "eastus"
# Enter the location for the second resource group (i.e. westus)
$location2 = "westus"

$resourceGroup1Name = $baseName + "-rg"
$resourceGroup2Name = $baseName + "dr-rg"

New-AzResourceGroup -Name $resourceGroup1Name -Location $location1
New-AzResourceGroup -Name $resourceGroup2Name -Location $location2

$templateUri = "https://raw.githubusercontent.com/kawo123/azure-nosql-cosmosdb/master/arm/azuredeploy.json"

$outputs = New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroup1Name `
    -TemplateUri $templateUri `
    -baseName $baseName `
    -location1 $location1
    -location2 $location2

$sqlserverName = $outputs.Outputs["sqlserverName"].value
$databaseName = $outputs.Outputs["databaseName"].value
$sqlAdministratorLogin = $outputs.Outputs["sqlAdministratorLogin"].value
$sqlAdministratorLoginPassword = $outputs.Outputs["sqlAdministratorLoginPassword"].value

$importRequest = New-AzSqlDatabaseImport -ResourceGroupName $resourceGroup1Name `
    -ServerName $sqlserverName -DatabaseName $databaseName `
    -DatabaseMaxSizeBytes "5000000" `
    -StorageKeyType "SharedAccessKey" `
    -StorageKey "?sp=rl&st=2019-11-26T21:16:46Z&se=2025-11-27T21:36:00Z&sv=2019-02-02&sr=b&sig=P15nBXR2bD2jBnHX92%2BwWRxMnvTeUl3EdBNhLXnZ95s%3D" `
    -StorageUri "https://databricksdemostore.blob.core.windows.net/data/nosql-openhack/movies.bacpac" `
    -Edition "Basic" -ServiceObjectiveName "Basic" `
    -AdministratorLogin $sqlAdministratorLogin `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $sqlAdministratorLoginPassword -AsPlainText -Force)

$importStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink

[Console]::Write("Importing database")
while ($importStatus.Status -eq "InProgress") {
    $importStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink
    [Console]::Write(".")
    Start-Sleep -s 10
}

[Console]::WriteLine("")
$importStatus