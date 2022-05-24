import UIKit
import Combine

class PDFViewModel {
  private var pdfVC: PDFViewController!
  private var pdfCoordinator: PDFViewCoordinator!
  
  func startView(rootVC: UINavigationController, cutArray: [Cut], basicData: BasicData) {
    let name = "Burak"
    pdfVC = PDFViewController(cutArray: cutArray, name: name, basicData: basicData)
    rootVC.pushViewController(pdfVC, animated: true)
  }
  
  func areaCalc(cut: [Cut]) -> CGFloat {
    var total = cut[0].xEnd * cut[0].yEnd / 1000000
    
    for i in 1..<cut.count {
      let n1 = cut[i].xEnd - cut[i].xStart
      let n2 = cut[i].yEnd - cut[i].yStart
      let cutArea = (n1 * n2) / 1000000
      total -= cutArea
    }
    return total
  }
}
