import UIKit
import Combine

class KesimViewController: UIViewController {
  let kesim: KesimYon
  let cutArray: [Cut]
  var vc: ViewController!
  var checkMoreThanOne = false
  var num = 0
  
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
  
  let imageViewGreen: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.image = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9).image()
    return imageView
  }()
  
  func anotherImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.image = UIColor.blue.image()
    return imageView
  }
  
  init(kesim: KesimYon, cutArray: [Cut]) {
    self.kesim = kesim
    self.cutArray = cutArray
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
    
    if cutArray.count > 1 {
      for cut in cutArray {
        if cut.kesimYon == kesim {
          checkMoreThanOne = true
        }
      }
    }
    
    headerLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: checkMoreThanOne ? height * 0.025 : height * 0.05).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    headerLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    imageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.05).isActive = true
    imageView.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: checkMoreThanOne ? 0.5 : 0.6).isActive = true
    imageView.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: checkMoreThanOne ? 0.65 : 0.6).isActive = true
    
    kaydetButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: height * 0.05).isActive = true
    kaydetButton.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.1).isActive = true
    kaydetButton.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    kaydetButton.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    
    xLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: checkMoreThanOne ? height * 0.575 : height * 0.3).isActive = true
    xLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    xLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: checkMoreThanOne ? width * 0.125 : width * 0.075).isActive = true
    xLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.1).isActive = true
    
    xTextField.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: checkMoreThanOne ? height * 0.575 : height * 0.3).isActive = true
    xTextField.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    xTextField.leadingAnchor.constraint(equalTo: xLabel.trailingAnchor, constant: width * 0.05).isActive = true
    xTextField.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.2).isActive = true
    
    yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor, constant: checkMoreThanOne ? height * 0.05 : height * 0.1).isActive = true
    yLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    yLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: checkMoreThanOne ? width * 0.125 : width * 0.075).isActive = true
    yLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.1).isActive = true
    
    yTextField.topAnchor.constraint(equalTo: xTextField.bottomAnchor, constant: checkMoreThanOne ? height * 0.05 : height * 0.1).isActive = true
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
    if checkMoreThanOne {
      view.addSubview(imageViewGreen)
      
      imageViewGreen.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: height * 0.05).isActive = true
      imageViewGreen.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
      imageViewGreen.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: height * 0.05).isActive = true
      imageViewGreen.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
      
      setupCutViews()
    }
  }
  
  @objc private func tapped() {
    guard let n1 = NumberFormatter().number(from: xTextField.text!), let n2 = NumberFormatter().number(from: yTextField.text!) else {
      return
    }
    let f1 = CGFloat(truncating: n1)
    let f2 = CGFloat(truncating: n2)
    publicCutArray.append(Cut(xStart: 0, yStart: 0, xEnd: f1, yEnd: f2, kesimYon: kesim))
    
    vc = ViewController(cutArray: publicCutArray)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func setupCutViews() {
    var imageViewArray = [UIImageView]()
    var numberViewArray = [UIImageView]()
    for i in 1..<cutArray.count {
      imageViewArray.append(anotherImageView())
      let numberImageview = UIImageView(image: UIImage(named: "\(i)"))
      numberImageview.translatesAutoresizingMaskIntoConstraints = false
      numberViewArray.append(numberImageview)
      if cutArray[i].kesimYon == kesim {
        view.addSubview(imageViewArray[i-1])
        view.addSubview(numberViewArray[i-1])
        num += 1
        switch kesim {
        case .sagyukari:
          imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageViewGreen.trailingAnchor, constant: -cutArray[i].xStart).isActive = true
          imageViewArray[i-1].topAnchor.constraint(equalTo: imageViewGreen.topAnchor, constant: cutArray[i].yStart).isActive = true
        case .solyukari:
          imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageViewGreen.leadingAnchor, constant: cutArray[i].xStart).isActive = true
          imageViewArray[i-1].topAnchor.constraint(equalTo: imageViewGreen.topAnchor, constant: cutArray[i].yStart).isActive = true
        case .solasagi:
          imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageViewGreen.leadingAnchor, constant: cutArray[i].xStart).isActive = true
          imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageViewGreen.bottomAnchor, constant: -cutArray[i].yStart).isActive = true
        case .sagasagi:
          imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageViewGreen.trailingAnchor, constant: -cutArray[i].xStart).isActive = true
          imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageViewGreen.bottomAnchor, constant: -cutArray[i].yStart).isActive = true
        default:
          break
        }
        imageViewArray[i-1].widthAnchor.constraint(equalTo: imageViewGreen.widthAnchor, multiplier: (cutArray[i].xEnd - cutArray[i].xStart)  / cutArray[0].xEnd).isActive = true
        imageViewArray[i-1].heightAnchor.constraint(equalTo: imageViewGreen.heightAnchor, multiplier: (cutArray[i].yEnd - cutArray[i].yStart) / cutArray[0].yEnd).isActive = true
        
        numberViewArray[i-1].centerXAnchor.constraint(equalTo: imageViewArray[i-1].centerXAnchor).isActive = true
        numberViewArray[i-1].centerYAnchor.constraint(equalTo: imageViewArray[i-1].centerYAnchor).isActive = true
        numberViewArray[i-1].widthAnchor.constraint(equalTo: imageViewArray[i-1].widthAnchor, multiplier: 0.2).isActive = true
        numberViewArray[i-1].heightAnchor.constraint(equalTo: imageViewArray[i-1].heightAnchor, multiplier: 0.8).isActive = true
      }
    }
  }
  
  func setupNumberViews(_ count: Int) {
    
  }
}

