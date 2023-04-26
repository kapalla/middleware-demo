import Vapor
import IkigaJSON

struct ConvertEmptyStringsToNull: AsyncMiddleware {
  func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
    if let data = request.body.data {
      var body = try JSONObject(buffer: data)

      for (key, value) in body {
        if let stringValue = value.string, stringValue.isEmpty {
          body[key] = NSNull()
        }
      }

      let newRequest = Request(
        application: request.application,
        method: request.method,
        url: request.url,
        version: request.version,
        headers: request.headers,
        collectedBody: body.jsonBuffer,
        remoteAddress: request.remoteAddress,
        logger: request.logger,
        byteBufferAllocator: request.byteBufferAllocator,
        on: request.eventLoop)

      newRequest.parameters = request.parameters

      return try await next.respond(to: newRequest)
    }

    return try await next.respond(to: request)
  }
}
