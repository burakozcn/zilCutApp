import UIKit
import Combine

class MaterialViewCoordinator: BaseCoordinator<Void> {
  private var materialViewModel: MaterialViewModel!
  let rootVC: UINavigationController
  let partyNum: String
  
  init(rootVC: UINavigationController, partyNum: String) {
    self.rootVC = rootVC
    self.partyNum = partyNum
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    materialViewModel = MaterialViewModel()
    materialViewModel.startView(rootVC: rootVC, partyNum: partyNum)
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
}

