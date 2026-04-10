global class HelloPostResponse {

    global String message { get; private set; }

    global HelloPostResponse(String message) {
        this.message = message;
    }
}
