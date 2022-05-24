import UIKit

class PDFViewController: UIViewController {
  private var viewModel: PDFViewModel!
  let cutArray: [Cut]
  let name: String
  let basicData: BasicData
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 28)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  
  let partyNumLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 28)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.isUserInteractionEnabled = true
    imageView.backgroundColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    imageView.image = UIColor(displayP3Red: 83/255, green: 165/255, blue: 154/255, alpha: 0.9).image()
    return imageView
  }()
  
  let widthLengthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 32)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
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
  
  func label(color: UIColor) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = color
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }
  
  init(cutArray: [Cut], name: String, basicData: BasicData) {
    self.cutArray = cutArray
    self.name = name
    self.basicData = basicData
    super.init(nibName: nil, bundle: .main)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    print(cutArray)
    viewModel = PDFViewModel()
    
    headerLabel.text = basicData.name
    partyNumLabel.text = basicData.partyNumber
    widthLengthLabel.text = "En = \(cutArray[0].xEnd) Boy = \(cutArray[0].yEnd) Toplam m2 = \(viewModel.areaCalc(cut: cutArray))"
    
    setupView()
    createPDF(from: self.view)
  }
  
  private func setupView() {
    view.addSubview(imageView)
    view.addSubview(widthLengthLabel)
    view.addSubview(headerLabel)
    view.addSubview(partyNumLabel)
    
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
    let readGuide = view.readableContentGuide
    let safeGuide = view.safeAreaLayoutGuide
    
    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
    
    headerLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    headerLabel.leadingAnchor.constraint(equalTo: readGuide.leadingAnchor).isActive = true
    headerLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    headerLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.6).isActive = true
    
    partyNumLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    partyNumLabel.trailingAnchor.constraint(equalTo: readGuide.trailingAnchor).isActive = true
    partyNumLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.075).isActive = true
    partyNumLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.4).isActive = true
    
    widthLengthLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    widthLengthLabel.centerXAnchor.constraint(equalTo: readGuide.centerXAnchor).isActive = true
    widthLengthLabel.heightAnchor.constraint(equalTo: safeGuide.heightAnchor, multiplier: 0.1).isActive = true
    widthLengthLabel.widthAnchor.constraint(equalTo: readGuide.widthAnchor, multiplier: 0.8).isActive = true
    
    if cutArray.count > 1 {
      var imageViewArray = [UIImageView]()
      var labelArrayWidth = [UILabel]()
      var labelArrayLength = [UILabel]()
      
      for i in 1..<cutArray.count {
        imageViewArray.append(anotherImageView(color: UIColor.clear))
        labelArrayWidth.append(label(color: .black))
        labelArrayLength.append(label(color: .black))
        
        view.addSubview(imageViewArray[i-1])
        imageViewArray[i-1].addSubview(labelArrayWidth[i-1])
        imageViewArray[i-1].addSubview(labelArrayLength[i-1])
        
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
        
        labelArrayWidth[i-1].bottomAnchor.constraint(equalTo: imageViewArray[i-1].bottomAnchor).isActive = true
        labelArrayWidth[i-1].widthAnchor.constraint(equalTo: imageViewArray[i-1].widthAnchor).isActive = true
        labelArrayWidth[i-1].centerXAnchor.constraint(equalTo: imageViewArray[i-1].centerXAnchor).isActive = true
        labelArrayWidth[i-1].heightAnchor.constraint(equalTo: imageViewArray[i-1].heightAnchor, multiplier: 0.3).isActive = true
        labelArrayWidth[i-1].text = String(cutArray[i].xEnd - cutArray[i].xStart)
        
        labelArrayLength[i-1].trailingAnchor.constraint(equalTo: imageViewArray[i-1].trailingAnchor).isActive = true
        labelArrayLength[i-1].widthAnchor.constraint(equalTo: imageViewArray[i-1].widthAnchor, multiplier: 0.25).isActive = true
        labelArrayLength[i-1].centerYAnchor.constraint(equalTo: imageViewArray[i-1].centerYAnchor).isActive = true
        labelArrayLength[i-1].heightAnchor.constraint(equalTo: imageViewArray[i-1].heightAnchor).isActive = true
        labelArrayLength[i-1].transform = CGAffineTransform(rotationAngle: .pi/2)
        labelArrayLength[i-1].text = String(cutArray[i].yEnd - cutArray[i].yStart)
      }
    }
  }
  
  private func createPDF(from view: UIView) {
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputFileURL = documentDirectory.appendingPathComponent("\(basicData.partyNumber).pdf")
    print("URL:", outputFileURL) // When running on simulator, use the given path to retrieve the PDF file
    
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: view.bounds)
    
    do {
      try pdfRenderer.writePDF(to: outputFileURL, withActions: { context in
        context.beginPage()
        view.layer.render(in: context.cgContext)
      })
    } catch {
      print("Could not create PDF file: \(error)")
    }
  }
}
