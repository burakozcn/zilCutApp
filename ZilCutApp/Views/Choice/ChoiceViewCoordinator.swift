import UIKit
import Combine

class ChoiceViewCoordinator: BaseCoordinator<Void> {
  let rootVC: UINavigationController
  private var choiceViewModel: ChoiceViewModel!
  private var createCoordinator: CreateViewCoordinator!
  private var startCoordinator: StartViewCoordinator!

  init(rootVC: UINavigationController) {
    self.rootVC = rootVC
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    choiceViewModel = ChoiceViewModel()
    choiceViewModel.startView(rootVC: rootVC)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToCreate() -> AnyPublisher<Void, Never> {
    createCoordinator = CreateViewCoordinator(rootVC: rootVC)
    return coordinate(coordinator: createCoordinator)
  }
  
  @discardableResult
  func goToStart() -> AnyPublisher<Void, Never> {
    startCoordinator = StartViewCoordinator(rootVC: rootVC)
    return coordinate(coordinator: startCoordinator)
  }
}
