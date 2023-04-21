import Fluent
import Vapor

final class Webhook: Model, Content {
  static let schema = "webhooks"

  @ID(key: .id)
  var id: UUID?

  @Field(key: "name")
  var name: String?

  @Timestamp(key: "created_at", on: .create)
  var createdAt: Date?

  @Timestamp(key: "updated_at", on: .update)
  var updatedAt: Date?

  @Field(key: "start_at")
  var startAt: Date?

  @Field(key: "stop_at")
  var stopAt: Date?

  @Field(key: "is_active")
  var isActive: Bool

  @Field(key: "request_type")
  var requestType: RequestType

  @Field(key: "content_type")
  var contentType: ContentType

  @Field(key: "url")
  var url: String?

  @Field(key: "data")
  var data: String?

  @Field(key: "authentication_mode")
  var authenticationMode: AuthenticationMode

  @Field(key: "username")
  var username: String?

  @Field(key: "password")
  var password: String?

  enum AuthenticationMode: String, Codable {
    case none
    case basic
    case bearer
  }

  enum ContentType: String, Codable, CaseIterable {
    case text
    case json
    case xml
  }

  enum RequestType: String, Codable, CaseIterable {
    case get
    case post
    case put
    case patch
    case delete
  }

  init() {}

  init(
    id: UUID? = nil,
    name: String? = nil,
    createdAt: Date? = nil,
    updatedAt: Date? = nil,
    startAt: Date? = nil,
    stopAt: Date? = nil,
    isActive: Bool,
    requestType: RequestType,
    contentType: ContentType,
    url: String? = nil,
    data: String? = nil,
    authenticationMode: AuthenticationMode,
    username: String? = nil,
    password: String? = nil
  ) {
    self.id = id
    self.name = name
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.startAt = startAt
    self.stopAt = stopAt
    self.isActive = isActive
    self.requestType = requestType
    self.contentType = contentType
    self.url = url
    self.data = data
    self.authenticationMode = authenticationMode
    self.username = username
    self.password = password
  }
}
