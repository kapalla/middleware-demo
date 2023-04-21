import Vapor

protocol JSONResource: Content {
  associatedtype Model

  init(from: Model)
}

extension JSONResource {
  static func collection(from models: [Model]) -> [Self] {
    models.map { model in
      Self.init(from: model)
    }
  }
}
