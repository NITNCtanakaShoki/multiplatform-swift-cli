import Fluent
import FluentSQLiteDriver
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
  let fm = FileManager()
  let homeDirectory = NSHomeDirectory()
  let storageDirectory = homeDirectory + "/multiplatform-swift-cli"
  if !fm.fileExists(atPath: storageDirectory) {
    try fm.createDirectory(atPath: storageDirectory, withIntermediateDirectories: true, attributes: nil)
  }

  app.databases.use(DatabaseConfigurationFactory.sqlite(.file("\(storageDirectory)/storage.sqlite")), as: .sqlite)

  app.migrations.add(CreateTodo())
  
  try await app.autoMigrate()

  // register routes
  try routes(app)
}
