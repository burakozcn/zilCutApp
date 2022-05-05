import UIKit
import Combine

extension UITextField {
  var textFieldPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification,
                                            object: self)
      .compactMap { ($0.object as? UITextField)?.text }
      .eraseToAnyPublisher()
  }
}
