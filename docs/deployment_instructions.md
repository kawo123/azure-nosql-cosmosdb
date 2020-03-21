# Deployment instructions

## PowerShell instructions

1. Open a **PowerShell ISE** window, run the following command, if prompted, click **Yes to All**:

   ```PowerShell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```

2. Make sure you have the latest PowerShell Azure module installed by executing the following command:

    ```PowerShell
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
    ```

3. If you installed an update, **close** the PowerShell ISE window, then **re-open** it. This ensures that the latest version of the Az module is used.

4. Execute the following to sign in to the Azure account:

    ```PowerShell
    Connect-AzAccount
    ```

5. Open the `deploy.ps1` PowerShell script in the PowerShell ISE window and update the following variables:

    > **Note**: The hosted Azure subscriptions do not support deploying SQL Server to all locations. You can use the Create Resource form in the portal while signed in as a class user, select SQL Database, select new SQL Server, then select locations in the dropdown list until you've identified the ones that don't cause a "this location is not supported" alert.

    ```PowerShell
    # Enter the base name for Azure resources (i.e. nosql)
    $baseName = "nosql"
    # Enter the location for the first resource group (i.e. eastus)
    $location1 = "eastus"
    # Enter the location for the second resource group (i.e. westus)
    $location2 = "westus"
    ```

6. Press **F5** to run the script, this will do the following:

   - Deploy the ARM template
   - Restore the Azure SQL database from a `.bacpac` file
   - Deploy the sample web app

## Deployment artifacts

After deployment has completed, you should see the following resources:

- Resource group ("nosql-rg")

  - Event Hubs Namespace with an event hub named `telemetry`
  - SQL Server with firewall settings set to allow all Azure services and IP addresses from 0.0.0.0 - 255.255.255.255
  - Azure SQL Database named `Movies`
  - App Service containing the deployed web app with a SQL connection string added to the Configuration settings

> [Download the zip file](https://databricksdemostore.blob.core.windows.net/data/nosql-openhack/DataGenerator.zip) for the data generator used in the OpenHack.