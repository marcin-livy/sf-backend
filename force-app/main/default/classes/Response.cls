public class Response {

    public Integer statusCode { get; private set; }

    /** Any JSON-serialisable object: Map, List, or a custom class instance */
    public Object body { get; private set; }

    public Map<String, String> headers { get; private set; }

    public Response(Integer statusCode, Object body) {
        this.statusCode = statusCode;
        this.body = body;
        this.headers = new Map<String, String>();
    }

    /** Fluent header addition */
    public Response withHeader(String name, String value) {
        this.headers.put(name, value);
        return this;
    }

    public static Response ok(Object body) {
        return new Response(200, body);
    }

    public static Response created(Object body) {
        return new Response(201, body);
    }

    public static Response noContent() {
        return new Response(204, null);
    }
}
