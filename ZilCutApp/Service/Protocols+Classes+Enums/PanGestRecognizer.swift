import UIKit
import UIKit.UIGestureRecognizerSubclass

class PanGestRecognizer: UIPanGestureRecognizer {
  var initialTouchLocation : CGPoint!
  var lastPoint: CGPoint!
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesBegan(touches, with: event)
    initialTouchLocation = touches.first!.location(in: view)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesEnded(touches, with: event)
  }
}
