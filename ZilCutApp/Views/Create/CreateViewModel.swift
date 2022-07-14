import UIKit
import Combine
import CoreData

class CreateViewModel: ObservableObject {
  private var createVC: CreateViewController!
  private var networkManagement: NetworkManagement!
  @Published var resultArray = [String]()
  var disposeBag = Set<AnyCancellable>()
  private var coordinator: CreateViewCoordinator!
  
  func startView(rootVC: UINavigationController) {
    createVC = CreateViewController()
    rootVC.pushViewController(createVC, animated: true)
  }
  
  private func saveNames() {
    networkManagement = NetworkManagement()
    //    networkManagement.getNames { arr in
    //      self.dictToModel(arr)
    //    }
  }
  
  private func dictToModel(_ array: Array<Dictionary<String, Any>>) {
    let context = persistence.persistentContainer.viewContext
    
    do {
      for i in 0..<array.count {
        let dict = array[i]
        let beltNames = NSEntityDescription.insertNewObject(forEntityName: "BeltNames", into: context) as! BeltNames
        beltNames.code = dict["code"] as? String
        beltNames.material = dict["material"] as? String
      }
    } catch {
      print("Error")
    }
    persistence.saveContext()
  }
  
  func tableSearch(text: String, completion: (Array<String>) -> ()) {
    var result = [String]()
    let context = persistence.persistentContainer.viewContext
    let predicate = NSPredicate(format: "material CONTAINS[cd] %@", text)
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BeltNames")
    fetchRequest.predicate = predicate
    
    do {
      let beltNames = try context.fetch(fetchRequest) as! [BeltNames]
      
      for beltName in beltNames {
        result.append(beltName.material!)
      }
      completion(result)
      
    } catch {
      print("Names Loading Error")
    }
  }
  
  func tableView(startVC: CreateViewController) {
    $resultArray.sink(receiveValue: startVC.items { tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: "CreateProductTableViewCell", for: indexPath) as! CreateProductTableViewCell
      cell.label?.text = item
      return cell
    }).store(in: &disposeBag)
  }
  
  func createMaterial(basicData: BasicData) {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    let rootVC = keyWindow?.rootViewController as! UINavigationController
    coordinator = CreateViewCoordinator(rootVC: rootVC)
    networkManagement = NetworkManagement()
    networkManagement.insertMaterial(name: basicData.name, color: getColorName(basicData.name), issueDate: basicData.createDate, partyNumber: basicData.partyNumber, userID: basicData.userID, active: true, width: basicData.width, height: basicData.length) { arr, response in
      
    }
    coordinator.goToMaterial(basicData: basicData)
  }
  
  private func getColorName(_ name: String) -> String {
    let arrayColors = ["BEYAZ", "SİYAH", "YEŞİL", "AÇIK YEŞİL", "PETROL YEŞİLİ", "PETROL YEŞİL", "ŞEFFAF", "GRİ", "MAVİ", "AÇIK MAVİ", "KOYU MAVİ", "ELMA YEŞİLİ", "ELMA YEŞİL", "KOYU GRİ", "SARI", "TURUNCU", "HARDAL"]
    
    var colorName = ""
    
    for arrayColor in arrayColors {
      if name.contains(arrayColor) {
        colorName = String(arrayColor.first!) + arrayColor.dropFirst().lowercased()
      }
    }
    
    if colorName == "" {
      colorName = "Yeşil"
    }
    return colorName
  }
  
  func getColor(_ name: String) -> (UIColor, UIColor, UIColor) {
    let colorName = getColorName(name)
    
    guard let color = ColorSwitch(rawValue: colorName.replacingOccurrences(of: " ", with: "").lowercased().replacingOccurrences(of: "i̇", with: "i")) else { return (UIColor.systemBlue, UIColor.white, UIColor.clear) }
    
    let bandColor = color.bandColor
    let backColor = color.backgroundColor
    let cutColor = color.cutColor
    
    return (bandColor, backColor, cutColor)
  }
}
