import UIKit
import Combine

class StartViewModel {
  private var startVC: StartViewController!
  private var networkManagement: NetworkManagement!
  @Published var networkCheck = false
  var disposeBag = Set<AnyCancellable>()
  var startCoordinator: StartViewCoordinator!
  
  @Published var basicDataArray = [BasicData]()
  
  init() {
    dataLoad()
  }
  
  func startView(rootVC: UINavigationController) {
    $networkCheck.sink { bool in
      if bool == true {
        self.startVC = StartViewController()
        rootVC.pushViewController(self.startVC, animated: true)
      }
    }.store(in: &disposeBag)
    networkCheck = false
  }
  
  private func dataLoad() {
    networkManagement = NetworkManagement()
    networkManagement.getAllMaterial { arrays in
      for array in arrays {
        self.basicDataArray.append(BasicData(name: array["name"] as! String, partyNumber: array["partyNumber"] as! String, userID: array["userID"] as! Int, createDate: array["issueDate"] as! String, width: array["width"] as! Float, length: array["height"] as! Float))
      }
    }
  closure: {
    self.networkCheck = true
  }
  }
  
  func tableView(startVC: StartViewController) {
    $basicDataArray.sink(receiveValue: startVC.items { tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: "StartTableViewCell", for: indexPath) as! StartTableViewCell
      cell.nameLabel.text = item.name
      cell.partyNumLabel.text = item.partyNumber
      cell.widthLabel.text = String(item.width)
      cell.lengthLabel.text = String(item.length)
      return cell
    }).store(in: &disposeBag)
  }
  
  func goToMaterial(indexPath: IndexPath) {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    let basicData = basicDataArray[indexPath.row]
    let rootVC = keyWindow?.rootViewController as! UINavigationController
    startCoordinator = StartViewCoordinator(rootVC: rootVC)
    startCoordinator.goToMaterial(basicData: basicData)
  }
}
