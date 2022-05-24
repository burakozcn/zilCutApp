import UIKit
import Combine

class PDFViewCoordinator: BaseCoordinator<Void> {
  let rootVC: UINavigationController
  let cutArray: [Cut]
  let basicData: BasicData
  private var pdfViewModel: PDFViewModel!
  
  init(rootVC: UINavigationController, cutArray: [Cut], basicData: BasicData) {
    self.rootVC = rootVC
    self.cutArray = cutArray
    self.basicData = basicData
  }
  
  override func start() -> AnyPublisher<Void, Never> {
    pdfViewModel = PDFViewModel()
    pdfViewModel.startView(rootVC: rootVC, cutArray: cutArray, basicData: basicData)
    
    return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
  }
}
