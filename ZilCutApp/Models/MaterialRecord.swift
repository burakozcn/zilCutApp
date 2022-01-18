import Foundation

struct MaterialRecord {
  let id: Int
  let name: String
  let description: String
  let issueDate: Date
  let partyNumber: String
  let userID: Int
  let active: Bool
  let width: Double
  let height: Double
  
  init(id: Int, name: String, description: String, issueDate: Date, partyNumber: String, userID: Int, active: Bool, width: Double, height: Double) {
    self.id = id
    self.name = name
    self.description = description
    self.issueDate = issueDate
    self.partyNumber = partyNumber
    self.userID = userID
    self.active = active
    self.width = width
    self.height = height
  }
}
