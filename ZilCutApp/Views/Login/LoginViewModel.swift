import UIKit
import Combine

class LoginViewModel {
  private var loginVC: LoginViewController!
  private var viewCoordinator: LoginViewCoordinator!
  private var networkManagement: NetworkManagement!
  
  func startView(window: UIWindow) {
    if loginCheck() == true {
      goToChoice(window: window)
    }
    loginVC = LoginViewController()
    window.rootViewController = UINavigationController(rootViewController: loginVC)
    window.makeKeyAndVisible()
  }
  
  private func loginCheck() -> Bool {
    var bool = false
    networkManagement = NetworkManagement()
    
    networkManagement.check { response in
      if response.statusCode == 200 {
        bool = true
      }
    }
    return bool
  }
  
  func login(user: String, pass: String) -> Bool {
    var bool = false
    networkManagement = NetworkManagement()
    
    networkManagement.login(mail: user, password: pass) { response in
      if response.statusCode == 200 {
        self.goToChoice(window: nil)
        bool = true
      }
    }
    return bool
  }
  
  private func goToChoice(window: UIWindow?) {
    DispatchQueue.main.async {
      let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
      
      self.viewCoordinator = LoginViewCoordinator(window: window ?? keyWindow!)
      self.viewCoordinator.goToChoice()
    }
  }
}
