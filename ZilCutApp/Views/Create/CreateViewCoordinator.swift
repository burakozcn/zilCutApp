import UIKit
import Combine

class CreateViewCoordinator: BaseCoordinator<Void> {
  private var startViewModel: CreateViewModel!
  private let window: UIWindow
  private var materialCoordinator: MaterialViewCoordinator!
  
  init(window: UIWindow) {
    self.window = window
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    startViewModel = CreateViewModel()
    startViewModel.startView(window: window)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToMaterial(partyNum: String) -> AnyPublisher<Void, Never> {
    let rootVC = window.rootViewController as! UINavigationController
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, partyNum: partyNum)
    return coordinate(coordinator: materialCoordinator)
  }
}
