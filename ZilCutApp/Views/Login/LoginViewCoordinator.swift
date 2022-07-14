import UIKit
import Combine

class LoginViewCoordinator: BaseCoordinator<Void> {
  private var viewModel: LoginViewModel!
  private let window: UIWindow
  private var choiceCoordinator: ChoiceViewCoordinator!
  
  init(window: UIWindow) {
    self.window = window
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    viewModel = LoginViewModel()
    viewModel.startView(window: window)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToChoice() -> AnyPublisher<Void, Never> {
    let rootVC = window.rootViewController as! UINavigationController
    choiceCoordinator = ChoiceViewCoordinator(rootVC: rootVC)
    return coordinate(coordinator: choiceCoordinator)
  }
}
