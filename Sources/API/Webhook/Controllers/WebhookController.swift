import Fluent
import Vapor

struct WebhookController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    let webhooks = routes.grouped("webhooks")
    webhooks.get(use: index)
    webhooks.post(use: store)
    webhooks.group(":webhookID") { webhook in
      webhook.get(use: show)
      webhook.put(use: update)
      webhook.delete(use: delete)
    }
  }

  func index(req: Request) async throws -> [WebhookDetail] {
    let webhooks = try await Webhook.query(on: req.db).all()

    return WebhookDetail.collection(from: webhooks)
  }

  func store(req: Request) async throws -> WebhookDetail {
    let webhook = try req.content.decode(Webhook.self)
    try await webhook.save(on: req.db)

    return WebhookDetail(from: webhook)
  }

  func show(req: Request) async throws -> WebhookDetail {
    guard let webhook = try await Webhook.find(req.parameters.get("webhookID"), on: req.db) else {
      throw Abort(.notFound)
    }

    return WebhookDetail(from: webhook)
  }

  func update(req: Request) async throws -> WebhookDetail {
    guard let webhook = try await Webhook.find(req.parameters.get("webhookID"), on: req.db) else {
      throw Abort(.notFound)
    }

    try UpdateWebhook.validate(content: req)
    let input = try req.content.decode(UpdateWebhook.self)

    webhook.name = input.name
    webhook.startAt = input.startAt
    webhook.stopAt = input.stopAt
    webhook.isActive = input.isActive
    webhook.requestType = input.requestType
    webhook.contentType = input.contentType
    webhook.url = input.url
    webhook.data = input.data
    webhook.authenticationMode = input.authenticationMode
    webhook.username = input.username
    webhook.password = input.password

    try await webhook.update(on: req.db)

    return WebhookDetail(from: webhook)
  }

  func delete(req: Request) async throws -> HTTPStatus {
    guard let webhook = try await Webhook.find(req.parameters.get("webhookID"), on: req.db) else {
      throw Abort(.notFound)
    }
    try await webhook.delete(on: req.db)

    return .noContent
  }
}
