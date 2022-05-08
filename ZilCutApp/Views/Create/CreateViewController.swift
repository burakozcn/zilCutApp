import UIKit
import Combine

class CreateViewController: UIViewController {
  var disposeBag = Set<AnyCancellable>()
  var viewModel: CreateViewModel!
  var datePicker: UIDatePicker!
  
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
    label.font = .boldSystemFont(ofSize: 28)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Ziligen Kesim Ürün Oluşturma"
    return label
  }()
  
  let productNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 18)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Ürün Adı"
    return label
  }()
  
  let productNameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    textField.isUserInteractionEnabled = true
    textField.autocapitalizationType = .allCharacters
    return textField
  }()
  
  let partyNumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 18)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Parti Numarası"
    return label
  }()
  
  let partyNumDateTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    return textField
  }()
  
  let partyNumSerialTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    return textField
  }()
  
  let createButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9)
    button.setTitle("Parti Num", for: .normal)
    button.addTarget(self, action: #selector(createPartyNumber), for: .touchUpInside)
    return button
  }()
  
  let partyNumTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.placeholder = "Parti Numarası"
    textField.font = .boldSystemFont(ofSize: 18)
    textField.adjustsFontSizeToFitWidth = true
    textField.textAlignment = .center
    return textField
  }()
  
  let widthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 18)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "En"
    return label
  }()
  
  let widthTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.placeholder = "En giriniz."
    return textField
  }()
  
  let lengthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 18)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    label.text = "Boy"
    return label
  }()
  
  let lengthTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .black
    textField.placeholder = "Boy giriniz."
    return textField
  }()
  
  let confirmButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9)
    button.setTitle("Oluştur", for: .normal)
    button.addTarget(self, action: #selector(createMaterial), for: .touchUpInside)
    return button
  }()
  
  var productTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .white
    tableView.isHidden = true
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupView()
    showDatePicker()
    
    viewModel = CreateViewModel()
    setupTableView()
    productTableView.delegate = self
    
    productTableView.register(UINib(nibName: "CreateProductTableViewCell", bundle: .main), forCellReuseIdentifier: "CreateProductTableViewCell")
    
    viewModel.tableView(startVC: self)
  }
  
  private func setupView() {
    view.addSubview(ziligenImage)
    view.addSubview(headerLabel)
    view.addSubview(productNameLabel)
    view.addSubview(productNameTextField)
    view.addSubview(partyNumLabel)
    view.addSubview(partyNumTextField)
    view.addSubview(widthLabel)
    view.addSubview(widthTextField)
    view.addSubview(lengthLabel)
    view.addSubview(lengthTextField)
    view.addSubview(confirmButton)
    view.addSubview(productTableView)
    view.addSubview(partyNumDateTextField)
    view.addSubview(partyNumSerialTextField)
    view.addSubview(createButton)
    
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    let safeGuide = view.safeAreaLayoutGuide
    let readGuide = view.readableContentGuide
    
    ziligenImage.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: height * 0.05).isActive = true
    ziligenImage.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.15).isActive = true
    ziligenImage.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.7).isActive
    = true
    ziligenImage.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    headerLabel.topAnchor.constraint(equalTo: ziligenImage.bottomAnchor, constant: height * 0.05).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.04).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    headerLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    productNameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.05).isActive = true
    productNameLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    productNameLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    productNameLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    productNameTextField.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: height * 0.025).isActive = true
    productNameTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    productNameTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    productNameTextField.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    partyNumLabel.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor, constant: height * 0.05).isActive = true
    partyNumLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.05).isActive = true
    partyNumLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    partyNumLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    partyNumDateTextField.topAnchor.constraint(equalTo: partyNumLabel.bottomAnchor, constant: height * 0.015).isActive = true
    partyNumDateTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    partyNumDateTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    partyNumDateTextField.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor).isActive = true
    
    partyNumSerialTextField.topAnchor.constraint(equalTo: partyNumLabel.bottomAnchor, constant: height * 0.015).isActive = true
    partyNumSerialTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    partyNumSerialTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.15).isActive = true
    partyNumSerialTextField.leadingAnchor.constraint(equalTo: partyNumDateTextField.trailingAnchor, constant: (width * 0.1)).isActive = true
    
    createButton.topAnchor.constraint(equalTo: partyNumLabel.bottomAnchor, constant: height * 0.015).isActive = true
    createButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    createButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.15).isActive = true
    createButton.leadingAnchor.constraint(equalTo: partyNumSerialTextField.trailingAnchor, constant: (width * 0.1)).isActive = true
    
    partyNumTextField.topAnchor.constraint(equalTo: partyNumDateTextField.bottomAnchor, constant: height * 0.015).isActive = true
    partyNumTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    partyNumTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    partyNumTextField.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    widthLabel.topAnchor.constraint(equalTo: partyNumTextField.bottomAnchor, constant: height * 0.05).isActive = true
    widthLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    widthLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    widthLabel.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor, constant: width * 0.25).isActive = true
    
    widthTextField.topAnchor.constraint(equalTo: partyNumTextField.bottomAnchor, constant: height * 0.05).isActive = true
    widthTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    widthTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    widthTextField.trailingAnchor.constraint(equalTo: readGuide.trailingAnchor, constant: -(width * 0.25)).isActive = true
    
    lengthLabel.topAnchor.constraint(equalTo: widthLabel.bottomAnchor, constant: height * 0.05).isActive = true
    lengthLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    lengthLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    lengthLabel.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor, constant: width * 0.25).isActive = true
    
    lengthTextField.topAnchor.constraint(equalTo: widthTextField.bottomAnchor, constant: height * 0.05).isActive = true
    lengthTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.025).isActive = true
    lengthTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    lengthTextField.trailingAnchor.constraint(equalTo: readGuide.trailingAnchor, constant: -(width * 0.25)).isActive = true
    
    confirmButton.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: height * 0.05).isActive = true
    confirmButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    confirmButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.45).isActive = true
    confirmButton.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    productTableView.topAnchor.constraint(equalTo: productNameTextField.bottomAnchor).isActive = true
    productTableView.leadingAnchor.constraint(equalTo: productNameTextField.leadingAnchor).isActive = true
    productTableView.trailingAnchor.constraint(equalTo: productNameTextField.trailingAnchor).isActive = true
    productTableView.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.3).isActive = true
  }
  
  private func setupTableView() {
    productNameTextField.textFieldPublisher
      .sink (receiveValue: { text in
        if text != "" {
          self.productTableView.isHidden = false
        } else {
          self.productTableView.isHidden = true
        }
        self.viewModel.tableSearch(text: text) { arr in
          self.viewModel.resultArray = arr
        }
      }).store(in: &disposeBag)
  }
  
  private func showDatePicker() {
    datePicker = UIDatePicker()
    datePicker.preferredDatePickerStyle = .compact
    datePicker.datePickerMode = .date
    datePicker.maximumDate = Date()
    
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6))
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: NSLocalizedString("done", comment: "Done"), style: .plain, target: self, action: #selector(donedatePicker))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: "Cancel"), style: .plain, target: self, action: #selector(cancelDatePicker))
    
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    
    partyNumDateTextField.inputAccessoryView = toolbar
    partyNumDateTextField.inputView = datePicker
  }
  
  @objc func donedatePicker() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    partyNumDateTextField.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }
  
  @objc func cancelDatePicker() {
    self.view.endEditing(true)
  }
  
  @objc func createPartyNumber() {
    let date = partyNumDateTextField.text ?? " "
    let serial = partyNumSerialTextField.text ?? " "
    
    partyNumTextField.text = date + serial
  }
  
  @objc func createMaterial() {
    if check() {
      viewModel.createMaterial(name: productNameTextField.text!, partyNumber: partyNumTextField.text!, width: Float(widthTextField.text!) ?? 0.0, height: Float(lengthTextField.text!) ?? 0.0)
    }
  }
  
  private func check() -> Bool {
    var bool = true
    let array = [productNameTextField.text, partyNumTextField.text, lengthTextField.text, widthTextField.text]
    for i in 0..<4 {
      if array[i] == "" {
        bool = false
        showAlert(i)
      }
      break
    }
    return bool
  }
  
  private func showAlert(_ number: Int) {
    var message = ""
    
    if let alert = AlertStyle(rawValue: number) {
      switch alert {
      case .product:
        message = "Ürün adını giriniz."
      case .partyNum:
        message = "Parti numarası giriniz."
      case .width:
        message = "En giriniz."
      case .length:
        message = "Boy giriniz."
      }
    }
  
    let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
    
    alert.popoverPresentationController?.sourceView = self.view
    let popoverRect = CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2,
                             width: 100, height: 100)
    alert.popoverPresentationController?.sourceRect = popoverRect
    alert.popoverPresentationController?.permittedArrowDirections = .up
    
    self.present(alert, animated: true, completion: nil)
  }
}
