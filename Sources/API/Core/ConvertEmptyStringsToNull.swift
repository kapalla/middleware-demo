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

      print(body.string ?? "") // replace it with something like: `request.body = body``
    }

    return try await next.respond(to: request)
  }
}
