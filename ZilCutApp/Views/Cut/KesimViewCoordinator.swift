import UIKit
import Combine

class KesimViewCoordinator: BaseCoordinator<Void> {
  private var kesimViewModel: KesimViewModel!
  let rootVC: UINavigationController
  let kesimYon: KesimYon
  let cutArray: [Cut]
  let basicData: BasicData
  private var materialCoordinator: MaterialViewCoordinator!
  
  init(rootVC: UINavigationController, kesimYon: KesimYon, cutArray: [Cut], basicData: BasicData) {
    self.rootVC = rootVC
    self.kesimYon = kesimYon
    self.cutArray = cutArray
    self.basicData = basicData
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    kesimViewModel = KesimViewModel(kesimYon: kesimYon, cutArray: cutArray, basicData: basicData)
    kesimViewModel.startView(rootVC: rootVC)
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToMaterial() -> AnyPublisher<Void, Never> {
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, basicData: basicData, temp: true)
    return coordinate(coordinator: materialCoordinator)
  }
}
