import Foundation
import UIKit

public struct Cut {
  let xStart: CGFloat
  let yStart: CGFloat
  let xEnd: CGFloat
  let yEnd: CGFloat
  let kesimYon: KesimYon
  
  init(xStart: CGFloat, yStart: CGFloat, xEnd: CGFloat, yEnd: CGFloat, kesimYon: KesimYon) {
    self.xStart = xStart
    self.xEnd = xEnd
    self.yStart = yStart
    self.yEnd = yEnd
    self.kesimYon = kesimYon
  }
}

public var publicCutArray = [Cut(xStart: 0, yStart: 0, xEnd: 3000, yEnd: 200000, kesimYon: .start)]
