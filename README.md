# NoSQL on Azure: Azure Cosmos DB

This project demostrates the capabilities of Azure Cosmos DB

## Prerequisite

- TODO

## Getting Started

- Clone the repository

- Follow [deployment instructions](./docs/deployment_instructions.md) to deploy Azure resources

- In Azure Data Factory portal, trigger pipeline `PL_Migrate_AzureSql_To_CosmosDb` to migrate data from Azure SQL database to Azure Cosmos database
  - After migration, consider scaling down Azure Cosmos DB RUs for cost saving

- In Azure Cosmos DB Data Explorer:
  - Click button `Enable Notebooks (preview)` to create Python notebook workspace for this Cosmos DB account
  - Click the down arrow next to button `New Notebook` and select `Upload to Notebook Server`
  - Upload notebook `./code/request_unit_estimator_cosmosdb.ipynb` to notebook server
  - Open notebook `request_unit_estimator_cosmosdb.ipynb` and run all cells to estimate total RUs for required queries

- To configure GitHub Actions to continuous integrate & deploy to Azure Functions, take the below steps
  - In `.github/workflows/az_func_node_wf.yaml`, replace value of `AZURE_FUNCTIONAPP_NAME` (line 16) with the name of your deployed Function
  - Follow the steps under the section "[Using Publish Profile as Deployment Credential](https://github.com/marketplace/actions/azure-functions-action#using-publish-profile-as-deployment-credential-recommended)"

- Follow [data generator instructions](./docs/data_generator_instructions.md) to generate dummy events

- Start stream analytics job to generate views for aggregated metrics

## References

- [Azure Cosmos DB Overview](https://docs.microsoft.com/en-us/azure/cosmos-db/distribute-data-globally)
- [Contoso Video SQL Server Schema](https://github.com/kawo123/nosql-openhack/blob/master/database-schema/README.md)

## Next Steps

- [] IaC: Azure Stream Analytics
- [] IaC: Azure Functions
- [] DB Schema Before & After + requirements
- [] DR

---

### PLEASE NOTE FOR THE ENTIRETY OF THIS REPOSITORY AND ALL ASSETS

1. No warranties or guarantees are made or implied.
2. All assets here are provided by me "as is". Use at your own risk. Validate before use.
3. I am not representing my employer with these assets, and my employer assumes no liability whatsoever, and will not provide support, for any use of these assets.
4. Use of the assets in this repo in your Azure environment may or will incur Azure usage and charges. You are completely responsible for monitoring and managing your Azure usage.

---

Unless otherwise noted, all assets here are authored by me. Feel free to examine, learn from, comment, and re-use (subject to the above) as needed and without intellectual property restrictions.

If anything here helps you, attribution and/or a quick note is much appreciated.
