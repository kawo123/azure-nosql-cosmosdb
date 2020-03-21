let uuid = require('uuid');

module.exports = async function (context, triggerEvents) {
    context.log(`Ingesting ${triggerEvents.length} orders to MoviesDB.Orders...`);

    // Add id and OrderID to each event
    triggerEvents.forEach((event, index) => {
        event['id'] = uuid.v4();
        event['OrderID'] = uuid.v4();
        event['AzureRegion'] = process.env['AzureRegion'];
    });

    context.log(`For reference, this is an id of an ingested document: ${triggerEvents[0].id}`)

    // Output documents to Cosmos DB
    context.bindings.outputDocuments = triggerEvents;
};