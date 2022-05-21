import UIKit
import Combine

class KesimViewCoordinator: BaseCoordinator<Void> {
  private var kesimViewModel: KesimViewModel!
  let rootVC: UINavigationController
  let kesimYon: KesimYon
  let cutArray: [Cut]
  let partyNumber: String
  private var materialCoordinator: MaterialViewCoordinator!
  
  init(rootVC: UINavigationController, kesimYon: KesimYon, cutArray: [Cut], partyNumber: String) {
    self.rootVC = rootVC
    self.kesimYon = kesimYon
    self.cutArray = cutArray
    self.partyNumber = partyNumber
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    kesimViewModel = KesimViewModel(kesimYon: kesimYon, cutArray: cutArray, partyNumber: partyNumber)
    kesimViewModel.startView(rootVC: rootVC)
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToMaterial(partyNum: String) -> AnyPublisher<Void, Never> {
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, partyNum: partyNum, temp: true)
    return coordinate(coordinator: materialCoordinator)
  }
}
