import UIKit

class ChoiceViewController: UIViewController {
  private var choiceViewModel: ChoiceViewModel!
  
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
  
  let createButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9)
    button.setTitle("Oluşturma Sayfası", for: .normal)
    button.addTarget(self, action: #selector(create), for: .touchUpInside)
    return button
  }()
  
  let chooseListButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9)
    button.setTitle("Listeden Seç", for: .normal)
    button.addTarget(self, action: #selector(list), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .plain, target: self, action: #selector(logout))
    self.navigationItem.hidesBackButton = true
    
    setupView()
  }
  
  private func setupView() {
    view.addSubview(ziligenImage)
    view.addSubview(headerLabel)
    view.addSubview(createButton)
    view.addSubview(chooseListButton)
    
    let height = UIScreen.main.bounds.height
    
    let safeGuide = view.safeAreaLayoutGuide
    let readGuide = view.readableContentGuide
    
    ziligenImage.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.15).isActive = true
    ziligenImage.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    ziligenImage.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.2).isActive = true
    ziligenImage.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    
    headerLabel.topAnchor.constraint(equalTo: ziligenImage.bottomAnchor, constant: height * 0.1).isActive = true
    headerLabel.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    
    createButton.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.1).isActive = true
    createButton.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    createButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    createButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.35).isActive = true
    
    chooseListButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: height * 0.05).isActive = true
    chooseListButton.centerXAnchor.constraint(equalTo: safeGuide.centerXAnchor).isActive = true
    chooseListButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    chooseListButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.35).isActive = true
  }
  
  @objc private func create() {
    choiceViewModel = ChoiceViewModel()
    choiceViewModel.goToCreate()
  }
  
  @objc private func list() {
    choiceViewModel = ChoiceViewModel()
    choiceViewModel.goToStart()
  }
  
  @objc private func logout() {
    choiceViewModel = ChoiceViewModel()
    choiceViewModel.logout()
  }
}
