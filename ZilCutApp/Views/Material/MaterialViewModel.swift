import UIKit
import Combine
import CoreData

class MaterialViewModel {
  private var materialVC: MaterialViewController!
  private var networkManagement: NetworkManagement!
  
  func startView(rootVC: UINavigationController, partyNum: String) {
    materialVC = MaterialViewController(cutArray: setupCutArray(partyNum: partyNum))
    rootVC.pushViewController(materialVC, animated: true)
  }
  
  private func setupCutArray(partyNum: String) -> [Cut] {
    var arr = [Cut]()
    
    networkManagement = NetworkManagement()
    networkManagement.getMaterialRecord(partyNum: partyNum) { array in
      let dict = array[0]
      let xEnd = dict["width"] as! CGFloat
      let yEnd = dict["height"] as! CGFloat
      let cut = Cut(xStart: 0, yStart: 0, xEnd: xEnd, yEnd: yEnd, kesimYon: .start)
      arr.append(cut)
    }
    return arr
  }
  
  private func cuts(_ arr: [Cut]) -> [Cut] {
    return arr
  }
}
