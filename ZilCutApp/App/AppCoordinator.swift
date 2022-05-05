import UIKit
import Combine

class AppCoordinator: BaseCoordinator<Void> {
  private var startCoordinator: StartViewCoordinator!
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  @discardableResult
  override func start() -> AnyPublisher<Void, Never> {
    startCoordinator = StartViewCoordinator(window: window)
    return coordinate(coordinator: startCoordinator)
  }
}
