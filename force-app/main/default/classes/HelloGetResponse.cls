global class HelloGetResponse {

    global String message { get; private set; }

    global HelloGetResponse(String message) {
        this.message = message;
    }
}
