import Foundation
import UIKit

struct BasicData {
  var name: String
  var partyNumber: String
  var userID: Int
  var createDate: String
  var width: Float
  var length: Float
  var bandColor: UIColor
  var backgroundColor: UIColor
  var cutColor: UIColor
  
  init(name: String, partyNumber: String, userID: Int, createDate: String, width: Float, length: Float, bandColor: UIColor, backgroundColor: UIColor, cutColor: UIColor) {
    self.name = name
    self.partyNumber = partyNumber
    self.userID = userID
    self.createDate = createDate
    self.width = width
    self.length = length
    self.bandColor = bandColor
    self.backgroundColor = backgroundColor
    self.cutColor = cutColor
  }
}
