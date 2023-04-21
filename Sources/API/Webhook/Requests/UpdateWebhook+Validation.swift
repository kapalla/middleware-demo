import Vapor

extension UpdateWebhook: Validatable {
  static func validations(_ validations: inout Validations) {
    validations.add("name", as: String.self, is: !.empty && .count(...100), required: false)
    validations.add("contentType", as: String.self, is: .in(Webhook.ContentType.allCases.map { item in item.rawValue}), required: false)
    validations.add("requestType", as: String.self, is: .in(Webhook.RequestType.allCases.map { item in item.rawValue}))
  }
}
