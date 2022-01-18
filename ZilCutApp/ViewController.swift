import UIKit

class ViewController: UIViewController {
  
  let xArray: [CGFloat]
  let yArray: [CGFloat]
  let kesimYonArray: [KesimYon]
  var initialCenter: CGPoint = .zero
  var lastCenter: CGPoint = .zero
  var kesimVC: KesimViewController!
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.image = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9).image()
    return imageView
  }()
  
  let panGestureRecognizer: PanGestRecognizer = {
    let panGestureRecognizer = PanGestRecognizer()
    panGestureRecognizer.view?.translatesAutoresizingMaskIntoConstraints = false
    panGestureRecognizer.view?.backgroundColor = .clear
    return panGestureRecognizer
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
  
  init(xArray: [CGFloat], yArray: [CGFloat], kesimYonArray: [KesimYon]) {
    self.xArray = xArray
    self.yArray = yArray
    self.kesimYonArray = kesimYonArray
    super.init(nibName: nil, bundle: .main)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .lightGray
    setupView()
  }
  
  private func setupView() {
    view.addSubview(imageView)
    panGestureRecognizer.addTarget(self, action: #selector(panned))
    imageView.addGestureRecognizer(panGestureRecognizer)
    
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    
    if xArray.count > 1 && yArray.count > 1 && kesimYonArray.count > 0 {
      var imageViewArray = [UIImageView]()
      for i in 0..<kesimYonArray.count {
        let j = i + 1
        imageViewArray.append(anotherImageView())
        view.addSubview(imageViewArray[i])
        switch kesimYonArray[i] {
        case .sagyukari:
          imageViewArray[i].trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
          imageViewArray[i].topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        case .solyukari:
          imageViewArray[i].leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
          imageViewArray[i].topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        case .solasagi:
          imageViewArray[i].leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
          imageViewArray[i].bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        case .sagasagi:
          imageViewArray[i].trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
          imageViewArray[i].bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        default:
          break
        }
        imageViewArray[i].widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: xArray[j]  / xArray[0]).isActive = true
        imageViewArray[i].heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: yArray[j] / yArray[0]).isActive = true
      }
    }
  }
  
  @objc private func panned(_ sender: UIPanGestureRecognizer) {
    let translation = panGestureRecognizer.translation(in: imageView)
    switch sender.state {
    case .began:
      initialCenter = panGestureRecognizer.initialTouchLocation
    case .ended:
      let newCenter = CGPoint(x: translation.x, y: translation.y)
      lastCenter = newCenter
      if !errorCheck(fx: initialCenter.x, fy: initialCenter.y, lx: lastCenter.x, ly: lastCenter.y) {
        goToPages(fx: initialCenter.x, fy: initialCenter.y, lx: lastCenter.x, ly: lastCenter.y)
      }
    default:
      break
    }
  }
  
  private func goToPages(fx: CGFloat, fy: CGFloat, lx: CGFloat, ly: CGFloat) {
    if fx < 50 {
      if ly > 0 {
        print("Sol aşağıdan kesim")
        goToKesimVC(kesimYon: .solasagi)
      } else {
        print("Sol yukarıdan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fy < 50 {
      if lx > 0 {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      } else {
        print("Sol yukaridan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fx > 600 {
      if ly > 0 {
        print("Sag asagidan kesim")
        goToKesimVC(kesimYon: .sagasagi)
      } else {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      }
    } else if fy > 800 {
      if lx > 0 {
        print("Sag asagidan kesim")
        goToKesimVC(kesimYon: .sagasagi)
      } else {
        print("Sol asagidan kesim")
        goToKesimVC(kesimYon: .solasagi)
      }
    } else {
      print("Error")
    }
  }
  
  private func errorCheck(fx: Double, fy: Double, lx: Double, ly: Double) -> Bool {
    var error = false
    if (fx < 50 && fy < 50) || (fx > 600 && fy > 800) {
      print("First Error, FX = \(fx), FY = \(fy)")
      error = true
    } else if (fx < 50 && lx < 50) || (fy < 50 && ly < 0) || (fy > 800 && ly > 0) {
      print("Second Error FX = \(fx), FY = \(fy), LX = \(lx), LY = \(ly) ")
      error = true
    }
    return error
  }
  
  private func goToKesimVC(kesimYon: KesimYon) {
    kesimVC = KesimViewController(kesim: kesimYon)
    self.navigationController?.pushViewController(kesimVC, animated: true)
  }
}

