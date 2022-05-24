import UIKit

class MaterialViewController: UIViewController {
 
 let cutArray: [Cut]
 let basicData: BasicData
 let temp: Bool
 var initialCenter: CGPoint = .zero
 var lastCenter: CGPoint = .zero
 var kesimVC: KesimViewController!
 var viewModel: MaterialViewModel!
 
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
 
 func anotherImageView(color: UIColor) -> UIImageView {
  let imageView = UIImageView()
  imageView.isUserInteractionEnabled = true
  imageView.backgroundColor = .white
  imageView.translatesAutoresizingMaskIntoConstraints = false
  imageView.contentMode = .scaleToFill
  imageView.image = color.image()
  return imageView
 }
 
 init(cutArray: [Cut], basicData: BasicData, temp: Bool) {
  self.cutArray = cutArray
  self.basicData = basicData
  self.temp = temp
  super.init(nibName: nil, bundle: .main)
 }
 
 required init?(coder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }
 
 override func viewDidLoad() {
  super.viewDidLoad()
  self.view.backgroundColor = .lightGray
  if temp {
   self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Kaydet", style: .plain, target: self, action: #selector(save))
  } else {
   self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PDF Oluştur", style: .plain, target: self, action: #selector(createPDF))
  }
  setupView()
 }
 
 private func setupView() {
  view.addSubview(imageView)
  panGestureRecognizer.addTarget(self, action: #selector(panned))
  imageView.addGestureRecognizer(panGestureRecognizer)
  
  let height = UIScreen.main.bounds.height
  let width = UIScreen.main.bounds.width
  
  imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
  imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
  
  if cutArray.count > 1 {
   var imageViewArray = [UIImageView]()
   for i in 1..<cutArray.count {
    if temp && (i == cutArray.count - 1) {
     imageViewArray.append(anotherImageView(color: UIColor.red))
    } else {
     imageViewArray.append(anotherImageView(color: UIColor.blue))
    }
    view.addSubview(imageViewArray[i-1])

    switch cutArray[i].kesimYon {
    case .sagyukari:
     imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: (-cutArray[i].xStart / cutArray[0].xEnd) * width * 0.8).isActive = true
     imageViewArray[i-1].topAnchor.constraint(equalTo: imageView.topAnchor, constant: (cutArray[i].yStart / cutArray[0].yEnd) * height * 0.8).isActive = true
    case .solyukari:
     imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: (cutArray[i].xStart / cutArray[0].xEnd) * width * 0.8).isActive = true
     imageViewArray[i-1].topAnchor.constraint(equalTo: imageView.topAnchor, constant: (cutArray[i].yStart / cutArray[0].yEnd) * height * 0.8).isActive = true
    case .solasagi:
     imageViewArray[i-1].leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: (cutArray[i].xStart / cutArray[0].xEnd) * width * 0.8).isActive = true
     imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: (-cutArray[i].yStart / cutArray[0].yEnd) * height * 0.8).isActive = true
    case .sagasagi:
     imageViewArray[i-1].trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: (-cutArray[i].xStart / cutArray[0].xEnd) * width * 0.8).isActive = true
     imageViewArray[i-1].bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: (-cutArray[i].yStart / cutArray[0].yEnd) * height * 0.8).isActive = true
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
   viewModel = MaterialViewModel(basicData: basicData, temp: temp)
   viewModel.cutSetup(width: imageView.bounds.width, height: imageView.bounds.height, initialCenter: initialCenter, lastCenter: lastCenter, cutArr: cutArray)
  default:
   break
  }
 }
 
 @objc private func save() {
  viewModel = MaterialViewModel(basicData: basicData, temp: true)
  viewModel.sendToDB(count: cutArray.count - 1)
 }
 
 @objc private func createPDF() {
  viewModel = MaterialViewModel(basicData: basicData, temp: temp)
  viewModel.PDF(cut: cutArray)
 }
}

