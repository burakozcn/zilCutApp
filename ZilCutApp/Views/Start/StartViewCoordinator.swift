import UIKit
import Combine

class StartViewCoordinator: BaseCoordinator<Void> {
  let rootVC: UINavigationController
  private var startViewModel: StartViewModel!
  private var materialCoordinator: MaterialViewCoordinator!

  init(rootVC: UINavigationController) {
    self.rootVC = rootVC
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    startViewModel = StartViewModel()
    startViewModel.startView(rootVC: rootVC)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  func goToMaterial(basicData: BasicData) -> AnyPublisher<Void, Never> {
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, basicData: basicData, temp: false)
    return coordinate(coordinator: materialCoordinator)
  }
}
