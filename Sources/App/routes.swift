import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.commands.use(HelloCommand(), as: "hello")
}

struct HelloCommand: Command {
  func run(using context: ConsoleKitCommands.CommandContext, signature: Signature) throws {
    context.console.print("Hello, World!")
  }
  
  struct Signature: CommandSignature { }
  
  let help = "hello"
  
}
