import UIKit

class LoginViewController: UIViewController {
  private var viewModel: LoginViewModel!
  
  let ziligenImage: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.image = UIImage(named: "ziligenlogokucuk")
    return imageView
  }()
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 32)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Ziligen Kesim"
    return label
  }()
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .systemFont(ofSize: 22)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Kullanıcı Adı"
    return label
  }()
  
  let usernameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    textField.isUserInteractionEnabled = true
    textField.autocapitalizationType = .none
    textField.keyboardType = .emailAddress
    return textField
  }()
  
  let passwordLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .systemFont(ofSize: 22)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Şifre"
    return label
  }()
  
  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    textField.isUserInteractionEnabled = true
    textField.keyboardType = .default
    textField.isSecureTextEntry = true
    return textField
  }()
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9)
    button.setTitle("Giriş", for: .normal)
    button.addTarget(self, action: #selector(login), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
  }
  
  private func setupView() {
    view.addSubview(ziligenImage)
    view.addSubview(headerLabel)
    view.addSubview(usernameLabel)
    view.addSubview(usernameTextField)
    view.addSubview(passwordLabel)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
    
    let height = UIScreen.main.bounds.height
    
    let safeGuide = view.safeAreaLayoutGuide
    let readGuide = view.readableContentGuide
    
    ziligenImage.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.15).isActive = true
    ziligenImage.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    ziligenImage.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.2).isActive = true
    ziligenImage.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    
    headerLabel.topAnchor.constraint(equalTo: ziligenImage.bottomAnchor, constant: height * 0.05).isActive = true
    headerLabel.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.5).isActive = true
    
    usernameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.025).isActive = true
    usernameLabel.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    usernameLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    usernameLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    
    usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: height * 0.015).isActive = true
    usernameTextField.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    usernameTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    usernameTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    
    passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: height * 0.025).isActive = true
    passwordLabel.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    passwordLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    passwordLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    
    passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: height * 0.015).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    passwordTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    passwordTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: height * 0.035).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    loginButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    loginButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.3).isActive = true
  }
  
  @objc private func login() {
    viewModel = LoginViewModel()
    if viewModel.login(user: usernameTextField.text!, pass: passwordTextField.text!) == false {
      showAlert()
    }
  }
  
  private func showAlert() {
    let alert = UIAlertController(title: "Uyarı", message: "Kullanıcı Adı veya şifre yanlış.", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
    
    alert.popoverPresentationController?.sourceView = self.view
    let popoverRect = CGRect(x: (self.view.bounds.width / 2) - 40, y: (self.view.bounds.height / 2) - 50,
                             width: 100, height: 100)
    alert.popoverPresentationController?.sourceRect = popoverRect
    alert.popoverPresentationController?.permittedArrowDirections = .up
    
    self.present(alert, animated: true, completion: nil)
  }
}
