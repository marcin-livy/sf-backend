/**
 * Contract for the /api/v1/settings resource.
 *
 * Returns theme configuration from the Settings__c hierarchy custom setting.
 *
 * Customer orgs can extend this class and register the implementation
 * via the ServiceConfig__mdt Custom Metadata Type (ResourceName__c = 'settings')
 * to customise the response.
 */
global class SettingsService extends ResourceHandler {

    protected override Response handleGet(Request req) {
        return Response.ok(get((SettingsGetRequest) fromQueryParams(req, SettingsGetRequest.class)));
    }

    global virtual SettingsGetResponse get(SettingsGetRequest request) {
        Settings__c settings = Settings__c.getInstance();
        return new SettingsGetResponse(settings);
    }
}
