import Foundation

struct MapRecord {
  let id: Int
  let partyNumber: String
  let mapLetter: String
  let description: String
  let issueDate: Date
  let userID: Int
  let aValue: Double
  let bValue: Double
  
  init(id: Int, partyNumber: String, mapLetter: String, description: String, issueDate: Date, userID: Int, aValue: Double, bValue: Double) {
    self.id = id
    self.partyNumber = partyNumber
    self.mapLetter = mapLetter
    self.description = description
    self.issueDate = issueDate
    self.userID = userID
    self.aValue = aValue
    self.bValue = bValue
  }
}
