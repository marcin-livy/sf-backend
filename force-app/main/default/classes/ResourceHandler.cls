global abstract class ResourceHandler {

    public Response handle(String httpMethod, Request req) {
        if (httpMethod == 'GET')    return handleGet(req);
        if (httpMethod == 'POST')   return handlePost(req);
        if (httpMethod == 'PUT')    return handlePut(req);
        if (httpMethod == 'PATCH')  return handlePatch(req);
        if (httpMethod == 'DELETE') return handleDelete(req);
        throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED');
    }

    protected virtual Response handleGet(Request req)    { throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED'); }
    protected virtual Response handlePost(Request req)   { throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED'); }
    protected virtual Response handlePut(Request req)    { throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED'); }
    protected virtual Response handlePatch(Request req)  { throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED'); }
    protected virtual Response handleDelete(Request req) { throw new ServiceException(405, 'Method not allowed', 'METHOD_NOT_ALLOWED'); }

    /**
     * Deserialise JSON request body into an instance of the given type.
     * Returns a default (empty) instance when the body is absent.
     */
    public static Object fromBody(Request req, Type targetType) {
        if (req.rawBody != null && req.rawBody.size() > 0) {
            return JSON.deserialize(req.rawBody.toString(), targetType);
        }
        return targetType.newInstance();
    }

    /**
     * Map URL query parameters into an instance of the given type.
     * All DTO fields must be String — use manual mapping for Integer, Boolean, Date etc.
     */
    public static Object fromQueryParams(Request req, Type targetType) {
        return JSON.deserialize(JSON.serialize(req.queryParams), targetType);
    }
}
