import Foundation

struct UpdateWebhook: Decodable {
  var name: String
  var startAt: Date?
  var stopAt: Date?
  var isActive: Bool
  var requestType: Webhook.RequestType
  var contentType: Webhook.ContentType
  var url: String?
  var data: String?
  var authenticationMode: Webhook.AuthenticationMode
  var username: String?
  var password: String?
}
