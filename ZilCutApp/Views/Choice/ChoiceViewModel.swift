import UIKit
import Combine
import CoreData

class ChoiceViewModel {
  private var choiceVC: ChoiceViewController!
  private var choiceCoordinator: ChoiceViewCoordinator!
  private var networkManagement: NetworkManagement!
  
  func startView(rootVC: UINavigationController) {
    choiceVC = ChoiceViewController()
    rootVC.pushViewController(choiceVC, animated: true)
  }
  
  func goToCreate() {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    let rootVC = keyWindow?.rootViewController as! UINavigationController
    choiceCoordinator = ChoiceViewCoordinator(rootVC: rootVC)
    choiceCoordinator.goToCreate()
  }
  
  func goToStart() {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    let rootVC = keyWindow?.rootViewController as! UINavigationController
    choiceCoordinator = ChoiceViewCoordinator(rootVC: rootVC)
    choiceCoordinator.goToStart()
  }
  
  func logout() {
    networkManagement = NetworkManagement()
    networkManagement.logout { response in
      if response.statusCode == 200 {
        self.goToLogin()
      }
    }
  }
  
  private func goToLogin() {
    DispatchQueue.main.async {
      let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
      
      let rootVC = keyWindow?.rootViewController as! UINavigationController
      self.choiceCoordinator = ChoiceViewCoordinator(rootVC: rootVC)
      self.choiceCoordinator.goToLogin(window: keyWindow!)
    }
  }
}
