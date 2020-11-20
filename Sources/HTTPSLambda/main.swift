import AWSLambdaRuntime
import AsyncHTTPClient
import NIO

struct Event: Codable {
    let url: String
}

struct Response: Codable {
    let content: String
}

struct HTTPSLambda: EventLoopLambdaHandler {
    
    // MARK: - In & Out
    typealias In = Event
    typealias Out = Response
    
    // MARK: - HTTPClient Configuration
    let httpClient: HTTPClient
    
    static let lambdaRuntimeTimeout: TimeAmount = .seconds(30)
    
    static let timeout = HTTPClient.Configuration.Timeout(
        connect: lambdaRuntimeTimeout,
        read: lambdaRuntimeTimeout
    )
    
    static let configuration = HTTPClient.Configuration(timeout: timeout)
    // MARK: - LambdaError
    enum LambdaError: Error {
        case invalidRequest
        case invalidContent
    }
    
    // MARK: - Init
    init(context: Lambda.InitializationContext) {
    
        // Use HTTPClient on the same EventLoop used by AWSLambda
        self.httpClient = HTTPClient(
            eventLoopGroupProvider: .shared(context.eventLoop),
            configuration: HTTPSLambda.configuration
        )
    }
    
    // MARK: - Lambda Handler
    func handle(context: Lambda.Context, event: Event) -> EventLoopFuture<Response> {
        
        guard let request = try? HTTPClient.Request(url: event.url) else {
            return context.eventLoop.makeFailedFuture(LambdaError.invalidRequest)
        }
        
        return httpClient.execute(request: request, deadline: nil)
        .flatMapThrowing { (response) throws -> String in
            guard let body: ByteBuffer = response.body,
                  let value: String = body.getString(at: 0, length: body.readableBytes) else {
                throw LambdaError.invalidContent
            }
            return value
        }.map { content -> Response in
            return Response(content: content)
        }
    }
}

Lambda.run(HTTPSLambda.init)
