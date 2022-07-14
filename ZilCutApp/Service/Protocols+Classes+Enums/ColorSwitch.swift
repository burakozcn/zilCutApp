import UIKit

enum ColorSwitch: String {
  case beyaz
  case siyah
  case yeşil
  case açikyeşil
  case petrolyeşili
  case petrolyeşil
  case şeffaf
  case gri
  case mavi
  case açikmavi
  case koyumavi
  case elmayeşili
  case elmayeşil
  case koyugri
  case sari
  case turuncu
  case hardal
  
  var bandColor: UIColor {
    switch self {
    case .beyaz:
      return UIColor.white
    case .siyah:
      return UIColor.black
    case .yeşil:
      return UIColor.systemGreen
    case .açikyeşil:
      return UIColor.init(displayP3Red: 144 / 255, green: 238 / 255, blue: 144 / 255, alpha: 1)
    case .elmayeşili:
      return UIColor.init(displayP3Red: 144 / 255, green: 238 / 255, blue: 144 / 255, alpha: 1)
    case .elmayeşil:
      return UIColor.init(displayP3Red: 144 / 255, green: 238 / 255, blue: 144 / 255, alpha: 1)
    case .petrolyeşil:
      return UIColor.init(displayP3Red: 1 / 255, green: 50 / 255, blue: 32 / 255, alpha: 0.9)
    case .petrolyeşili:
      return UIColor.init(displayP3Red: 1 / 255, green: 50 / 255, blue: 32 / 255, alpha: 0.9)
    case .şeffaf:
      return UIColor.white
    case .gri:
      return UIColor.gray
    case .mavi:
      return UIColor.blue
    case .açikmavi:
      return UIColor.init(displayP3Red: 186 / 255, green: 219 / 255, blue: 1, alpha: 0.9)
    case .koyumavi:
      return UIColor.init(displayP3Red: 0, green: 0, blue: 200 / 255, alpha: 0.95)
    case .koyugri:
      return UIColor.darkGray
    case .sari:
      return UIColor.yellow
    case .turuncu:
      return UIColor.orange
    case .hardal:
      return UIColor.init(displayP3Red: 225 / 255, green: 173 / 255, blue: 1 / 255, alpha: 0.93)
    }
  }
  
  var backgroundColor: UIColor {
    switch self {
    case .beyaz:
      return UIColor.darkGray
    case .siyah:
      return UIColor.white
    case .yeşil:
      return UIColor.gray
    case .açikyeşil:
      return UIColor.gray
    case .elmayeşili:
      return UIColor.gray
    case .elmayeşil:
      return UIColor.gray
    case .petrolyeşil:
      return UIColor.gray
    case .petrolyeşili:
      return UIColor.gray
    case .şeffaf:
      return UIColor.darkGray
    case .gri:
      return UIColor.white
    case .mavi:
      return UIColor.gray
    case .açikmavi:
      return UIColor.gray
    case .koyumavi:
      return UIColor.gray
    case .koyugri:
      return UIColor.white
    case .sari:
      return UIColor.gray
    case .turuncu:
      return UIColor.gray
    case .hardal:
      return UIColor.gray
    }
  }
  
  var cutColor: UIColor {
    switch self {
    case .beyaz:
      return UIColor.darkGray
    case .siyah:
      return UIColor.white
    case .yeşil:
      return UIColor.systemBlue
    case .açikyeşil:
      return UIColor.systemBlue
    case .elmayeşili:
      return UIColor.systemBlue
    case .elmayeşil:
      return UIColor.systemBlue
    case .petrolyeşil:
      return UIColor.systemBlue
    case .petrolyeşili:
      return UIColor.systemBlue
    case .şeffaf:
      return UIColor.systemBlue
    case .gri:
      return UIColor.systemBlue
    case .mavi:
      return UIColor.white
    case .açikmavi:
      return UIColor.white
    case .koyumavi:
      return UIColor.white
    case .koyugri:
      return UIColor.systemBlue
    case .sari:
      return UIColor.systemBlue
    case .turuncu:
      return UIColor.systemBlue
    case .hardal:
      return UIColor.systemBlue
    }
  }
}
