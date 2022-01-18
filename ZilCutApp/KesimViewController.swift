import UIKit
import Combine

class KesimViewController: UIViewController {
  let kesim: KesimYon
  var vc: ViewController!
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .black
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  let xLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "X:"
    return label
  }()
  
  let xTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Genişlik Değeri"
    textField.textAlignment = .center
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.textContentType = UITextContentType.shipmentTrackingNumber
    textField.autocapitalizationType = UITextAutocapitalizationType.none
    return textField
  }()
  
  let yLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Y:"
    return label
  }()
  
  let yTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Uzunluk Değeri"
    textField.textAlignment = .center
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.textContentType = UITextContentType.creditCardNumber
    textField.autocapitalizationType = UITextAutocapitalizationType.none
    return textField
  }()
  
  let kaydetButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 2/255, green: 122/255, blue: 106/255, alpha: 0.9)
    button.setTitle("Kaydet", for: .normal)
    return button
  }()
  
  init(kesim: KesimYon) {
    self.kesim = kesim
    super.init(nibName: nil, bundle: .main)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView(kesim)
    kaydetButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
  }
  
  private func setupView(_ kesimYon: KesimYon) {
    view.addSubview(headerLabel)
    view.addSubview(imageView)
    view.addSubview(xLabel)
    view.addSubview(xTextField)
    view.addSubview(yLabel)
    view.addSubview(yTextField)
    view.addSubview(kaydetButton)
    
    let readGuide = view.readableContentGuide
    let safeGuide = view.safeAreaLayoutGuide
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    headerLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.05).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.1).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    headerLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    imageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.05).isActive = true
    imageView.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    imageView.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.6).isActive = true
    
    kaydetButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: height * 0.05).isActive = true
    kaydetButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.1).isActive = true
    kaydetButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    kaydetButton.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    xLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.3).isActive = true
    xLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    xLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: width * 0.05).isActive = true
    xLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.1).isActive = true
    
    xTextField.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.3).isActive = true
    xTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    xTextField.leadingAnchor.constraint(equalTo: xLabel.trailingAnchor, constant: width * 0.05).isActive = true
    xTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    
    yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor, constant: height * 0.1).isActive = true
    yLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    yLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: width * 0.05).isActive = true
    yLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.1).isActive = true
    
    yTextField.topAnchor.constraint(equalTo: xTextField.bottomAnchor, constant: height * 0.1).isActive = true
    yTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    yTextField.leadingAnchor.constraint(equalTo: yLabel.trailingAnchor, constant: width * 0.05).isActive = true
    yTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    
    switch kesim {
    case .solyukari:
      headerLabel.text = "Sol Üst Kısımdan Kesim"
      imageView.image = UIImage(named: "Sol Ust")
    case .solasagi:
      headerLabel.text = "Sol Aşağı Kısımdan Kesim"
      imageView.image = UIImage(named: "Sol Alt")
    case .sagyukari:
      headerLabel.text = "Sağ Yukarı Kısımdan Kesim"
      imageView.image = UIImage(named: "Sag Ust")
    case .sagasagi:
      headerLabel.text = "Sağ Aşağı Kısımdan Kesim"
      imageView.image = UIImage(named: "Sag Alt")
    default:
      print("Error")
    }
  }
  
  @objc private func tapped() {
    if let n1 = NumberFormatter().number(from: xTextField.text!) {
      let f = CGFloat(truncating: n1)
      xArrayPublic.append(f)
    }
    
    if let n2 = NumberFormatter().number(from: yTextField.text!) {
      let f = CGFloat(truncating: n2)
      yArrayPublic.append(f)
    }
    kesimYonPublic.append(kesim)
    
    print("X = \(xArrayPublic), Y = \(yArrayPublic), Kesim = \(kesimYonPublic)")
    vc = ViewController(xArray: xArrayPublic, yArray: yArrayPublic, kesimYonArray: kesimYonPublic)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
