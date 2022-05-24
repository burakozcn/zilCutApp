import UIKit
import Combine
import CoreData

class MaterialViewModel {
  private var materialVC: MaterialViewController!
  private var networkManagement: NetworkManagement!
  private var cutArray: [Cut]!
  private var materialCoordinator: MaterialViewCoordinator!
  let basicData: BasicData
  var temp: Bool
  @Published var networkCheck = false
  var disposeBag = Set<AnyCancellable>()
  
  init(basicData: BasicData, temp: Bool) {
    self.basicData = basicData
    self.temp = temp
  }
  
  func startView(rootVC: UINavigationController) {
    cutArray = [Cut]()
    setupCutArray(partyNum: basicData.partyNumber)
    
    $networkCheck.sink { bool in
      if bool == true {
        self.cutArray += self.tempCut()
        DispatchQueue.main.async {
          self.materialVC = MaterialViewController(cutArray: self.cutArray, basicData: self.basicData, temp: self.temp)
          rootVC.pushViewController(self.materialVC, animated: true)
        }
      }
    }.store(in: &disposeBag)
    
    networkCheck = false
  }
  
  private func setupCutArray(partyNum: String) {
    networkManagement = NetworkManagement()
    networkManagement.getMaterialRecord(partyNum: partyNum) { array in
      let dict = array[0]
      let xEnd = dict["width"] as! CGFloat
      let yEnd = dict["height"] as! CGFloat
      let cut = Cut(xStart: 0, yStart: 0, xEnd: xEnd, yEnd: yEnd, kesimYon: .start)
      self.cutArray.append(cut)
      self.cuts()
    }
  }
  
  private func cuts() {
    DispatchQueue.main.async {
      self.networkManagement = NetworkManagement()
      self.networkManagement.getCutRecord(partyNum: self.basicData.partyNumber) { arrays in
        for array in arrays {
          let dict = array
          let cut = Cut(xStart: CGFloat(dict["xStart"] as! Float), yStart: CGFloat(dict["yStart"] as! Float), xEnd: CGFloat(dict["xEnd"] as! Float), yEnd: CGFloat(dict["yEnd"] as! Float), kesimYon: self.recordToEnum(left: dict["left"] as! Bool, up: dict["up"] as! Bool, vertical: dict["vertical"] as! Bool, horizontal: dict["horizontal"] as! Bool))
          self.cutArray.append(cut)
        }
      } closure: {
        self.networkCheck = true
      }
    }
  }
  
  private func tempCut() -> [Cut] {
    var arr = [Cut]()
    if temp {
      let context = persistence.persistentContainer.viewContext
      
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CutRecord")
      
      do {
        let cutRecords = try context.fetch(fetchRequest) as! [CutRecord]
        
        for cutRecord in cutRecords {
          let cut = Cut(xStart: CGFloat(cutRecord.xStart), yStart: CGFloat(cutRecord.yStart), xEnd: CGFloat(cutRecord.xEnd), yEnd: CGFloat(cutRecord.yEnd), kesimYon: recordToEnum(left: cutRecord.left, up: cutRecord.up, vertical: cutRecord.vertical, horizontal: cutRecord.horizontal))
          arr.append(cut)
        }
      } catch {
        print("Names Loading Error")
      }
    }
    return arr
  }
  
  func cutSetup(width: CGFloat, height: CGFloat, initialCenter: CGPoint, lastCenter: CGPoint, cutArr: [Cut]) {
    cutArray = cutArr
    if !errorCheck(width: width, height: height, fx: initialCenter.x, fy: initialCenter.y, lx: lastCenter.x, ly: lastCenter.y) {
      goToPages(width: width, height: height, fx: initialCenter.x, fy: initialCenter.y, lx: lastCenter.x, ly: lastCenter.y)
    }
  }
  
  private func goToPages(width: CGFloat, height: CGFloat, fx: CGFloat, fy: CGFloat, lx: CGFloat, ly: CGFloat) {
    if fx < width / 12 {
      if ly > 0 {
        print("Sol aşağıdan kesim")
        goToKesimVC(kesimYon: .solasagi)
      } else {
        print("Sol yukarıdan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fy < height / 16 {
      if lx > 0 {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      } else {
        print("Sol yukaridan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fx > width * 0.9 {
      if ly > 0 {
        print("Sag asagidan kesim")
        goToKesimVC(kesimYon: .sagasagi)
      } else {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      }
    } else if fy > height * 0.92 {
      if lx > 0 {
        print("Sag asagidan kesim")
        goToKesimVC(kesimYon: .sagasagi)
      } else {
        print("Sol asagidan kesim")
        goToKesimVC(kesimYon: .solasagi)
      }
    } else {
      print("Error")
    }
  }
  
  private func errorCheck(width: CGFloat, height: CGFloat, fx: Double, fy: Double, lx: Double, ly: Double) -> Bool {
    var error = false
    if (fx < width / 12 && fy < height / 16) || (fx > width * 0.9 && fy > height * 0.92) {
      print("First Error, FX = \(fx), FY = \(fy)")
      error = true
    } else if (fx < width / 12 && lx < width / 12) || (fy < height / 16 && ly < 0) || (fy > width * 0.9 && ly > 0) {
      print("Second Error FX = \(fx), FY = \(fy), LX = \(lx), LY = \(ly) ")
      error = true
    }
    return error
  }
  
  private func goToKesimVC(kesimYon: KesimYon) {
    let rootVC = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first?.rootViewController as! UINavigationController
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, basicData: basicData, temp: temp)
    materialCoordinator.goToKesim(kesimYon: kesimYon, cutArray: cutArray)
  }
  
  private func recordToEnum(left: Bool, up: Bool, vertical: Bool, horizontal: Bool) -> KesimYon {
    var kesimYon = KesimYon.start
    if vertical {
      kesimYon = KesimYon.dikey
    } else if horizontal {
      kesimYon = KesimYon.yatay
    } else if left && up {
      kesimYon = KesimYon.solyukari
    } else if !left && up {
      kesimYon = KesimYon.sagyukari
    } else if left && !up {
      kesimYon = KesimYon.solasagi
    } else if !left && !up {
      kesimYon = KesimYon.sagasagi
    }
    return kesimYon
  }
  
  func sendToDB(count: Int) {
    let context = persistence.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CutRecord")
    do {
      let cutRecords = try context.fetch(fetchRequest) as! [CutRecord]
      let cutRecord = cutRecords.last!
      networkManagement = NetworkManagement()
      guard cutRecords.count > 0 else { return }
      DispatchQueue.main.async {
        self.networkManagement.insertCut(cutRecord, count: count, partyNumber: self.basicData.partyNumber) { arr, response in }
      closure: {
        self.deleteCut()
      }
      }
    } catch {
      print("Names Loading Error")
    }
    persistence.saveContext()
    self.restart()
  }
  
  private func deleteCut() {
    let context = persistence.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CutRecord")
    
    do {
      let records = try context.fetch(fetchRequest) as! [CutRecord]
      for record in records {
        context.delete(record)
      }
    } catch {
      print("ERROR 3002 - User Fetch Error")
    }
    persistence.saveContext()
  }
  
  private func restart() {
    temp = false
    
    let rootVC = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first?.rootViewController as! UINavigationController
    
    startView(rootVC: rootVC)
  }
  
  func PDF(cut: [Cut]) {
    let rootVC = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first?.rootViewController as! UINavigationController
    
    materialCoordinator = MaterialViewCoordinator(rootVC: rootVC, basicData: basicData, temp: temp)
    materialCoordinator.goToPDF(cutArray: cut)
  }
}
