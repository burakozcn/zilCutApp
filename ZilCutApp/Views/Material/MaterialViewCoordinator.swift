import UIKit
import Combine

class MaterialViewCoordinator: BaseCoordinator<Void> {
  private var materialViewModel: MaterialViewModel!
  private var kesimCoordinator: KesimViewCoordinator!
  let rootVC: UINavigationController
  let partyNum: String
  let temp: Bool
  
  init(rootVC: UINavigationController, partyNum: String, temp: Bool) {
    self.rootVC = rootVC
    self.partyNum = partyNum
    self.temp = temp
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    materialViewModel = MaterialViewModel(partyNum: partyNum, temp: temp)
    materialViewModel.startView(rootVC: rootVC)
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToKesim(kesimYon: KesimYon, cutArray: [Cut]) -> AnyPublisher<Void, Never> {
    kesimCoordinator = KesimViewCoordinator(rootVC: rootVC, kesimYon: kesimYon, cutArray: cutArray, partyNumber: partyNum)
    return coordinate(coordinator: kesimCoordinator)
  }
}

