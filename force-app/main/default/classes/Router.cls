@RestResource(urlMapping='/api/v1/*')
global with sharing class Router {

    @HttpGet
    global static void doGet() {
        handle('GET');
    }

    @HttpPost
    global static void doPost() {
        handle('POST');
    }

    @HttpPut
    global static void doPut() {
        handle('PUT');
    }

    @HttpPatch
    global static void doPatch() {
        handle('PATCH');
    }

    @HttpDelete
    global static void doDelete() {
        handle('DELETE');
    }

    private static void handle(String httpMethod) {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');

        try {
            String resource = parseResource(req.requestURI);
            String pathSuffix = parsePathSuffix(req.requestURI);

            ResourceHandler handler = ServiceLocator.resolve(resource);
            Request livyReq = Request.fromRestRequest(req, httpMethod, pathSuffix);
            Response livyResp = handler.handle(httpMethod, livyReq);

            res.statusCode = livyResp.statusCode;
            for (String header : livyResp.headers.keySet()) {
                res.addHeader(header, livyResp.headers.get(header));
            }
            if (livyResp.body != null) {
                res.responseBody = Blob.valueOf(JSON.serialize(livyResp.body));
            }

        } catch (ServiceException e) {
            writeError(res, e.statusCode, e.getMessage(), e.errorCode);
        } catch (ClientException e) {
            writeError(res, 422, e.getMessage(), 'CLIENT_ERROR');
        } catch (Exception e) {
            writeError(res, 500, 'Internal server error', 'INTERNAL_ERROR');
        }
    }

    private static String parseResource(String uri) {
        // uri example: /services/apexrest/livymobile/api/v1/properties/123
        Pattern p = Pattern.compile('/api/v1/([^/]+)');
        Matcher m = p.matcher(uri);
        if (!m.find()) {
            throw new ServiceException(400, 'Invalid URL: missing resource segment', 'INVALID_URL');
        }
        return m.group(1).toLowerCase();
    }

    private static String parsePathSuffix(String uri) {
        // Returns everything after /api/v1/, e.g. 'properties/abc123'
        Integer idx = uri.indexOf('/api/v1/');
        return (idx >= 0) ? uri.substring(idx + '/api/v1/'.length()) : '';
    }

    private static void writeError(RestResponse res, Integer statusCode, String message, String errorCode) {
        ErrorResponse err = new ErrorResponse(statusCode, message, errorCode);
        res.statusCode = statusCode;
        res.responseBody = Blob.valueOf(JSON.serialize(err));
    }

    private class ErrorResponse {
        private Integer statusCode;
        private String message;
        private String errorCode;

        private ErrorResponse(Integer statusCode, String message, String errorCode) {
            this.statusCode = statusCode;
            this.message = message;
            this.errorCode = errorCode;
        }
    }
}
