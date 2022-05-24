import UIKit
import Combine

class LoginViewModel {
  private var loginVC: LoginViewController!
  private var viewCoordinator: LoginViewCoordinator!
  
  func startView(window: UIWindow) {
    loginVC = LoginViewController()
    window.rootViewController = UINavigationController(rootViewController: loginVC)
    window.makeKeyAndVisible()
  }
  
  func login(user: String, pass: String) {
    if user == "bozcan@ziligen.com" && pass == "burak" {
      goToChoice()
    }
  }
  
  private func goToChoice() {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .compactMap({$0 as? UIWindowScene})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    viewCoordinator = LoginViewCoordinator(window: keyWindow!)
    viewCoordinator.goToChoice()
  }
}
