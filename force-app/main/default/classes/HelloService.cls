/**
 * Contract for the /api/v1/hello resource.
 *
 * Customer orgs extend this class and register the implementation
 * via the ServiceConfig__mdt Custom Metadata Type (ResourceName__c = 'hello').
 *
 * Example:
 *   public class MyHelloService extends livymobile.HelloService {
 *       public override livymobile.HelloGetResponse get(livymobile.HelloGetRequest req) {
 *           return new livymobile.HelloGetResponse('Hello, ' + req.name + '!');
 *       }
 *   }
 */
global class HelloService extends ResourceHandler {

    protected override Response handleGet(Request req) {
        return Response.ok(get((HelloGetRequest) fromQueryParams(req, HelloGetRequest.class)));
    }

    protected override Response handlePost(Request req) {
        return Response.ok(post((HelloPostRequest) fromBody(req, HelloPostRequest.class)));
    }

    global virtual HelloGetResponse get(HelloGetRequest request) {
        String name = String.isNotBlank(request.name) ? request.name : 'World';
        return new HelloGetResponse('Hello, ' + name + '!');
    }

    global virtual HelloPostResponse post(HelloPostRequest request) {
        String name = String.isNotBlank(request.name) ? request.name : 'World';
        return new HelloPostResponse('Hello, ' + name + '!');
    }
}