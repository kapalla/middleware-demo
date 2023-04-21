import Foundation

struct WebhookDetail: JSONResource {
  typealias Model = Webhook

  var id: String?
  var name: String?
  var createdAt: Date?
  var updatedAt: Date?
  var startAt: Date?
  var stopAt: Date?
  var isActive: Bool
  var requestType: Webhook.RequestType
  var contentType: Webhook.ContentType
  var url: String?
  var data: String?
  var authenticationMode: Webhook.AuthenticationMode
  var username: String?

  // use lowercased UUID
  init(from model: Model) {
    id = model.id?.uuidString.lowercased()
    name = model.name
    createdAt = model.createdAt
    updatedAt = model.updatedAt
    startAt = model.startAt
    stopAt = model.stopAt
    isActive = model.isActive
    requestType = model.requestType
    contentType = model.contentType
    url = model.url
    data = model.data
    authenticationMode = model.authenticationMode
    username = model.username
  }

  // added `CodingKeys` and `func encode` to ensure that nil values are not getting omitted (replace it with IkigaJSON NilStrategy)
  enum CodingKeys: CodingKey {
    case id
    case name
    case createdAt
    case updatedAt
    case startAt
    case stopAt
    case isActive
    case requestType
    case contentType
    case url
    case data
    case authenticationMode
    case username
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(createdAt, forKey: .createdAt)
    try container.encode(updatedAt, forKey: .updatedAt)
    try container.encode(startAt, forKey: .startAt)
    try container.encode(stopAt, forKey: .stopAt)
    try container.encode(isActive, forKey: .isActive)
    try container.encode(requestType, forKey: .requestType)
    try container.encode(contentType, forKey: .contentType)
    try container.encode(url, forKey: .url)
    try container.encode(data, forKey: .data)
    try container.encode(authenticationMode, forKey: .authenticationMode)
    try container.encode(username, forKey: .username)
  }
}
