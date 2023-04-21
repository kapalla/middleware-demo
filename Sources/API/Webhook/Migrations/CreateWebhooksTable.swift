import Fluent

struct CreateWebhooksTable: AsyncMigration {
  func prepare(on database: Database) async throws {
    try await database.schema("webhooks")
      .id()
      .field("created_at", .int)
      .field("updated_at", .int)
      .field("start_at", .int)
      .field("stop_at", .int)
      .field("is_active", .bool, .required, .sql(.default(true)))
      .field("name", .string)
      .field("request_type", .int, .required, .sql(.default(0)))
      .field("content_type", .int, .required, .sql(.default(0)))
      .field("url", .string)
      .field("data", .string)
      .field("authentication_mode", .int, .required, .sql(.default(0)))
      .field("username", .string)
      .field("password", .string)
      .create()
  }

  func revert(on database: Database) async throws {
    try await database.schema("webhooks").delete()
  }
}
