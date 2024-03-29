import UIKit
import Combine

class MaterialViewCoordinator: BaseCoordinator<Void> {
  private var materialViewModel: MaterialViewModel!
  private var kesimCoordinator: KesimViewCoordinator!
  private var pdfCoordinator: PDFViewCoordinator!
  private var createCoordinator: CreateViewCoordinator!
  private var startCoordinator: StartViewCoordinator!
  
  let rootVC: UINavigationController
  let basicData: BasicData
  let temp: Bool
  
  init(rootVC: UINavigationController, basicData: BasicData, temp: Bool) {
    self.rootVC = rootVC
    self.basicData = basicData
    self.temp = temp
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    materialViewModel = MaterialViewModel(basicData: basicData, temp: temp)
    materialViewModel.startView(rootVC: rootVC)
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
  
  @discardableResult
  func goToKesim(kesimYon: KesimYon, cutArray: [Cut]) -> AnyPublisher<Void, Never> {
    kesimCoordinator = KesimViewCoordinator(rootVC: rootVC, kesimYon: kesimYon, cutArray: cutArray, basicData: basicData)
    return coordinate(coordinator: kesimCoordinator)
  }
  
  @discardableResult
  func goToPDF(cutArray: [Cut]) -> AnyPublisher<Void, Never> {
    pdfCoordinator = PDFViewCoordinator(rootVC: rootVC, cutArray: cutArray, basicData: basicData)
    return coordinate(coordinator: pdfCoordinator)
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

