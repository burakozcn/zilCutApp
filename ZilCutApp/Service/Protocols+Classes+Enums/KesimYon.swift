import Foundation
import UIKit

public enum KesimYon: Int16 {
  case solyukari = 0
  case solasagi
  case sagyukari
  case sagasagi
  case dikey
  case yatay
  case start
}

extension UIColor {
  func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { rendererContext in
      self.setFill()
      rendererContext.fill(CGRect(origin: .zero, size: size))
    }
  }
}
