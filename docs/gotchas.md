# Gotchas

- Azure Cosmos DB does not support `decimal` type value. When migrating data from Azure SQL DB to Azure Cosmos DB, `decimal` type values need to be converted to other data types supported by Azure Cosmos DB. To date, Azure Cosmos DB supports `string`, `number (float & double)`, `boolean`, `null`, `array`, and `object`.

- There are 3 options today to execute mapping data flow in pipeline: [parallel](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-overview#execute-data-flows-in-parallel), [overload](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-overview#overload-single-data-flow), [serial](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-overview#execute-data-flows-serially) executions. Each strategy have advantages and disadvantages which you should consider before choosing.

- When using mapping data flow to [recreate the destination Cosmos DB collection](https://docs.microsoft.com/bs-latn-ba/azure/data-factory/connector-azure-cosmos-db#sink-transformation) prior to writing, it is not possible to recreate the collection with shared throughput today. Each recreated collection have dedicated throughput per collection level.

- When creating new document using [Azure Cosmos DB aata explorer](https://docs.microsoft.com/en-us/azure/cosmos-db/data-explorer), it does not show consumed RUs for creating the document. Currently, one has to use Cosmos DB SDK or REST API to obtain details of consumed RUs when creating a document in Cosmos DB.

- Secondary Event Hub namespace **has** to be empty when setting up geo-disaster-recovery for Event Hub. Follow the documented [setup and failover flow](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-geo-dr#setup-and-failover-flow) closely when implementing Geo-DR for Event Hub.
  - As noted in documented, **only fail forward semantics are supported. In this scenario, you fail over and then re-pair with a new namespace. Failing back is not supported**. Please plan accordingly and run DR drill before actual need for failover.
  - Failover of Event Hub includes a DNS switch of the alias entry, which will cause a short disruption to service. Ensure your applications using Event Hub implement appropriate retry policy to deal with such short disruption. For guidance of retry mechanics in Azure services, see [Retry guidance for Azure services](https://docs.microsoft.com/en-us/azure/architecture/best-practices/retry-service-specific#event-hubs)
