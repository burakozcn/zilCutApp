import UIKit
import Combine
import CoreData

class CreateViewModel: ObservableObject {
  private var startVC: CreateViewController!
  private var networkManagement: NetworkManagement!
  @Published var resultArray = [String]()
  var disposeBag = Set<AnyCancellable>()
  private var coordinator: CreateViewCoordinator!
  
  func startView(window: UIWindow) {
    startVC = CreateViewController()
    
    window.rootViewController = UINavigationController(rootViewController: startVC)
    window.makeKeyAndVisible()
    saveNames()
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
  
  func createMaterial(name: String, partyNumber: String, width: Float, height: Float) {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    coordinator = CreateViewCoordinator(window: keyWindow!)
    networkManagement = NetworkManagement()
    networkManagement.insertMaterial(name: name, color: getColor(name), issueDate: Date(), partyNumber: partyNumber, userID: 320, active: true, width: width, height: height) { arr, response in

    }
    coordinator.goToMaterial(partyNum: partyNumber)
  }
  
  private func getColor(_ name: String) -> String {
    var color = ""
    let delimeter = " "
    let token = name.components(separatedBy: delimeter)
    if token.last?.last?.isNumber != nil {
      color = "Doğal"
    }
    color = String(token.last!.prefix(1) + token.last!.lowercased().dropFirst())
    return color
  }
}
