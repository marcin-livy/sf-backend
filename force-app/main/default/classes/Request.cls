public class Request {

    /** HTTP verb: GET, POST, PUT, PATCH, DELETE */
    public String httpMethod { get; private set; }

    /** Path after /api/v1/, e.g. 'hello/abc123' */
    public String pathSuffix { get; private set; }

    /** URL query parameters */
    public Map<String, String> queryParams { get; private set; }

    /** Parsed JSON body. Null for GET/DELETE or non-JSON payloads. */
    public Map<String, Object> body { get; private set; }

    /** Raw request body bytes, available for all content types */
    public Blob rawBody { get; private set; }

    Request() {
    }

    // Package-internal factory — only Router instantiates Request objects
    public static Request fromRestRequest(RestRequest req, String httpMethod, String pathSuffix) {
        Request r = new Request();
        r.httpMethod = httpMethod;
        r.pathSuffix = pathSuffix;
        r.queryParams = req.params != null ? req.params : new Map<String, String>();
        r.rawBody = req.requestBody;

        if (req.requestBody != null && req.requestBody.size() > 0) {
            try {
                r.body = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
            } catch (JSONException e) {
                r.body = null;
            }
        }

        return r;
    }
}
