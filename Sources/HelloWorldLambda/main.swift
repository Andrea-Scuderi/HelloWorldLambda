import AWSLambdaRuntime

// Request, uses Codable for transparent JSON encoding
private struct Request: Codable {
    let name: String
}

// Response, uses Codable for transparent JSON encoding
private struct Response: Codable {
    let message: String
}

// In this example we are receiving and responding with `Codable`.
Lambda.run { (context, request: Request, callback: @escaping (Result<Response, Error>) -> Void) in
    
    // Business Logic
    let response = Response(message: "Hello!: \(request.name)")
    
    // Callback
    callback(.success(response))
}
