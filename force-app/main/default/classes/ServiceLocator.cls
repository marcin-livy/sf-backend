public with sharing class ServiceLocator {

    /**
     * Resolve a URL resource segment to a ResourceHandler implementation.
     *
     * Reads ServiceConfig__mdt for an active record matching the resource name,
     * then instantiates the registered Apex class via Type.forName.
     *
     * @param resource  Lowercase URL segment, e.g. 'hello'
     * @return          An instantiated ResourceHandler ready to handle the request
     * @throws ServiceException 404 if no active config found for the resource
     * @throws ServiceException 500 if the registered class cannot be instantiated
     */
    public static ResourceHandler resolve(String resource) {
        ServiceConfig__mdt config = fetchConfig(resource);

        if (config == null) {
            throw new ServiceException(404, 'No service registered for resource: ' + resource, 'RESOURCE_NOT_FOUND');
        }

        Type serviceType = String.isBlank(config.Namespace__c)
            ? Type.forName(config.ClassName__c)
            : Type.forName(config.Namespace__c, config.ClassName__c);

        if (serviceType == null) {
            throw new ServiceException(500, 'Service class not found: ' + config.ClassName__c, 'SERVICE_CLASS_MISSING');
        }

        try {
            return (ResourceHandler) serviceType.newInstance();
        } catch (Exception e) {
            throw new ServiceException(500, 'Could not instantiate service: ' + config.ClassName__c, 'SERVICE_INSTANTIATION_FAILED');
        }
    }

    private static ServiceConfig__mdt fetchConfig(String resource) {
        List<ServiceConfig__mdt> configs = [
            SELECT ClassName__c, Namespace__c
            FROM ServiceConfig__mdt
            WHERE ResourceName__c = :resource
                AND IsActive__c = TRUE
            LIMIT 1
        ];
        return configs.isEmpty() ? null : configs[0];
    }
}
