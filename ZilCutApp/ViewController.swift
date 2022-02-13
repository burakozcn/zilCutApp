import UIKit

class ViewController: UIViewController {
  
  let cutArray: [Cut]
  var initialCenter: CGPoint = .zero
  var lastCenter: CGPoint = .zero
  var kesimVC: KesimViewController!
  
  var solUstX: CGFloat = 0
  var solUstY: CGFloat = 0
  var sagUstX: CGFloat = 0
  var sagUstY: CGFloat = 0
  var solAltX: CGFloat = 0
  var solAltY: CGFloat = 0
  var sagAltX: CGFloat = 0
  var sagAltY: CGFloat = 0
  
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
  
  init(cutArray: [Cut]) {
    self.cutArray = cutArray
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
    
    if cutArray.count > 1 {
      var imageViewArray = [UIImageView]()
      for i in 1..<cutArray.count {
        imageViewArray.append(anotherImageView())
        view.addSubview(imageViewArray[i-1])
        switch cutArray[i].kesimYon {
        case .sagyukari:
          imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -cutArray[i].xStart).isActive = true
          imageViewArray[i-1].topAnchor.constraint(equalTo: imageView.topAnchor, constant: cutArray[i].yStart).isActive = true
          sagUstX = cutArray[i].xEnd
          sagUstY = cutArray[i].yEnd
        case .solyukari:
          imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: cutArray[i].xStart).isActive = true
          imageViewArray[i-1].topAnchor.constraint(equalTo: imageView.topAnchor, constant: cutArray[i].yStart).isActive = true
          solUstX = cutArray[i].xEnd
          solUstY = cutArray[i].yEnd
        case .solasagi:
          imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: cutArray[i].xStart).isActive = true
          imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -cutArray[i].yStart).isActive = true
          solAltX = cutArray[i].xEnd
          solAltY = cutArray[i].yEnd
        case .sagasagi:
          imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -cutArray[i].xStart).isActive = true
          imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -cutArray[i].yStart).isActive = true
          sagAltX = cutArray[i].xEnd
          sagAltY = cutArray[i].yEnd
        default:
          break
        }
        imageViewArray[i-1].widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: (cutArray[i].xEnd - cutArray[i].xStart)  / cutArray[0].xEnd).isActive = true
        imageViewArray[i-1].heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: (cutArray[i].yEnd - cutArray[i].yStart) / cutArray[0].yEnd).isActive = true
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
    if fx < imageView.bounds.size.width / 12 {
      if ly > 0 {
        print("Sol aşağıdan kesim")
        goToKesimVC(kesimYon: .solasagi)
      } else {
        print("Sol yukarıdan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fy < imageView.bounds.size.height / 16 {
      if lx > 0 {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      } else {
        print("Sol yukaridan kesim")
        goToKesimVC(kesimYon: .solyukari)
      }
    } else if fx > imageView.bounds.size.width * 0.9 {
      if ly > 0 {
        print("Sag asagidan kesim")
        goToKesimVC(kesimYon: .sagasagi)
      } else {
        print("Sag yukaridan kesim")
        goToKesimVC(kesimYon: .sagyukari)
      }
    } else if fy > imageView.bounds.size.height * 0.92 {
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
    if (fx < imageView.bounds.size.width / 12 && fy < imageView.bounds.size.height / 16) || (fx > imageView.bounds.size.width * 0.9 && fy > imageView.bounds.size.height * 0.92) {
      print("First Error, FX = \(fx), FY = \(fy)")
      error = true
    } else if (fx < imageView.bounds.size.width / 12 && lx < imageView.bounds.size.width / 12) || (fy < imageView.bounds.size.height / 16 && ly < 0) || (fy > imageView.bounds.size.width * 0.9 && ly > 0) {
      print("Second Error FX = \(fx), FY = \(fy), LX = \(lx), LY = \(ly) ")
      error = true
    }
    return error
  }
  
  private func goToKesimVC(kesimYon: KesimYon) {
    kesimVC = KesimViewController(kesim: kesimYon, cutArray: cutArray)
    self.navigationController?.pushViewController(kesimVC, animated: true)
  }
}

