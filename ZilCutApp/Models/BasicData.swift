import Foundation

struct BasicData {
  var name: String
  var partyNumber: String
  var userID: Int
  var createDate: String
  var width: Float
  var length: Float
  
  init(name: String, partyNumber: String, userID: Int, createDate: String, width: Float, length: Float) {
    self.name = name
    self.partyNumber = partyNumber
    self.userID = userID
    self.createDate = createDate
    self.width = width
    self.length = length
  }
}
