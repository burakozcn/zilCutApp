import UIKit
import Combine
import CoreData

class KesimViewModel {
  private var kesimVC: KesimViewController!
  var pickerDataSource: [String] = []
  var pickerMap: [Int] = []
  let kesimYon: KesimYon
  let cutArray: [Cut]
  var kesimCoordinator: KesimViewCoordinator!
  let basicData: BasicData
  
  var xStart: CGFloat = 0
  var yStart: CGFloat = 0
  
  init(kesimYon: KesimYon, cutArray: [Cut], basicData: BasicData) {
    self.kesimYon = kesimYon
    self.cutArray = cutArray
    self.basicData = basicData
  }
  
  func startView(rootVC: UINavigationController) {
    checkMore()
    
    kesimVC = KesimViewController(kesim: kesimYon, cutArray: cutArray, basicData: basicData)
    rootVC.pushViewController(kesimVC, animated: true)
  }
  
  func saveCut(xFrom: String, yFrom: String) {
    guard let n1 = NumberFormatter().number(from: xFrom), let n2 = NumberFormatter().number(from: yFrom) else {
      return
    }
    let f1 = CGFloat(truncating: n1)
    let f2 = CGFloat(truncating: n2)
    let cut = Cut(xStart: xStart, yStart: yStart, xEnd: (xStart + f1), yEnd: (yStart + f2), kesimYon: kesimYon)
    tempSave(cut: cut)
    goToMaterial(cut: cut)
  }
  
  private func goToMaterial(cut: Cut) {
    let rootVC = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first?.rootViewController as! UINavigationController
    kesimCoordinator = KesimViewCoordinator(rootVC: rootVC, kesimYon: kesimYon, cutArray: cutArray, basicData: basicData)
    kesimCoordinator.goToMaterial()
  }
  
  private func tempSave(cut: Cut) {
    let context = persistence.persistentContainer.viewContext
    let cutRecord = NSEntityDescription.insertNewObject(forEntityName: "CutRecord", into: context) as! CutRecord
    cutRecord.partyNumber = basicData.partyNumber
    cutRecord.xStart = Float(cut.xStart)
    cutRecord.xEnd = Float(cut.xEnd)
    cutRecord.yStart = Float(cut.yStart)
    cutRecord.yEnd = Float(cut.yEnd)
    switch kesimYon {
    case .solyukari:
      cutRecord.horizontal = false
      cutRecord.vertical = false
      cutRecord.left = true
      cutRecord.up = true
    case .solasagi:
      cutRecord.horizontal = false
      cutRecord.vertical = false
      cutRecord.left = true
      cutRecord.up = false
    case .sagyukari:
      cutRecord.horizontal = false
      cutRecord.vertical = false
      cutRecord.left = false
      cutRecord.up = true
    case .sagasagi:
      cutRecord.horizontal = false
      cutRecord.vertical = false
      cutRecord.left = false
      cutRecord.up = false
    case .dikey:
      cutRecord.horizontal = false
      cutRecord.vertical = true
      cutRecord.left = false
      cutRecord.up = false
    case .yatay:
      cutRecord.horizontal = true
      cutRecord.vertical = false
      cutRecord.left = false
      cutRecord.up = false
    case .start:
      cutRecord.horizontal = false
      cutRecord.vertical = false
      cutRecord.left = false
      cutRecord.up = false
    }
    persistence.saveContext()
  }
  
  func checkMore() -> Bool {
    var bool = false
    if cutArray.count > 1 {
      for cut in cutArray {
        if cut.kesimYon == kesimYon {
          bool = true
        }
      }
    }
    return bool
  }
  
  func pickerViewNum(_ number: Int) {
    for i in 0..<number {
      pickerDataSource.append("\(i + 1)" + " - Yan")
      pickerDataSource.append("\(i + 1)" + " - Alt")
      pickerMap.append(i + 1)
      pickerMap.append((i + 1) * 10)
    }
  }
  
  func calcStarts(_ text: String?) {
    var num: Int = 0
    var pos: String = ""
    
    if let str = text {
      num = Int(str.prefix(1))!
      pos = String(str.suffix(3))
    }
    
    if pos == "Yan" {
      xStart = cutArray[num].xEnd
    } else if pos == "Alt" {
      yStart = cutArray[num].yEnd
    }
  }
}
