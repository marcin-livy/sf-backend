global class ServiceException extends Exception {

    public Integer statusCode { get; private set; }
    public String errorCode { get; private set; }

    global ServiceException(Integer statusCode, String message) {
        this.setMessage(message);
        this.statusCode = statusCode;
    }

    global ServiceException(Integer statusCode, String message, String errorCode) {
        this.setMessage(message);
        this.statusCode = statusCode;
        this.errorCode = errorCode;
    }
}
