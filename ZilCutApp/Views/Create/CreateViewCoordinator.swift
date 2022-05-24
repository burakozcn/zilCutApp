import UIKit
import Combine

class CreateViewCoordinator: BaseCoordinator<Void> {
  private var viewModel: CreateViewModel!
  private let rootVC: UINavigationController
  private var materialCoordinator: MaterialViewCoordinator!
  
  init(rootVC: UINavigationController) {
    self.rootVC = rootVC
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    viewModel = CreateViewModel()
    viewModel.startView(rootVC: rootVC)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToMaterial(basicData: BasicData) -> AnyPublisher<Void, Never> {
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, basicData: basicData, temp: false)
    return coordinate(coordinator: materialCoordinator)
  }
}
