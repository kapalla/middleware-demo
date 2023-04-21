import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  app.middleware.use(ConvertEmptyStringsToNull())

  let encoder = JSONEncoder()
  encoder.keyEncodingStrategy = .convertToSnakeCase
  encoder.dateEncodingStrategy = .iso8601
  ContentConfiguration.global.use(encoder: encoder, for: .json)

  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  decoder.dateDecodingStrategy = .iso8601
  ContentConfiguration.global.use(decoder: decoder, for: .json)

  app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

  app.migrations.add(CreateWebhooksTable())

  // register routes
  try routes(app)
}
