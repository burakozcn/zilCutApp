import UIKit
import Combine

class AppCoordinator: BaseCoordinator<Void> {
  private var loginCoordinator: LoginViewCoordinator!
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  @discardableResult
  override func start() -> AnyPublisher<Void, Never> {
    loginCoordinator = LoginViewCoordinator(window: window)
    return coordinate(coordinator: loginCoordinator)
  }
}
