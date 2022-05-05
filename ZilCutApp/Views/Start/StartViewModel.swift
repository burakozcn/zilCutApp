import UIKit
import Combine
import CoreData

class StartViewModel: ObservableObject {
  private var startVC: StartViewController!
  private var networkManagement: NetworkManagement!
  @Published var resultArray = [String]()
  var disposeBag = Set<AnyCancellable>()
  
  func startView(window: UIWindow) {
    startVC = StartViewController()
    
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
      print("ERROR 5003 - Power Transmission Belt Names Loading Error")
    }
  }
  
  func tableView(startVC: StartViewController) {
    $resultArray.sink(receiveValue: startVC.items { tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: "StartProductTableViewCell", for: indexPath) as! StartProductTableViewCell
      cell.label?.text = item
      return cell
    }).store(in: &disposeBag)
  }
}
