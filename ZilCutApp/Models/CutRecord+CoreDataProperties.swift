import Foundation
import CoreData


extension CutRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CutRecord> {
        return NSFetchRequest<CutRecord>(entityName: "CutRecord")
    }

    @NSManaged public var partyNumber: String?
    @NSManaged public var cutNumber: String?
    @NSManaged public var xStart: Float
    @NSManaged public var xEnd: Float
    @NSManaged public var yStart: Float
    @NSManaged public var left: Bool
    @NSManaged public var yEnd: Float
    @NSManaged public var up: Bool
    @NSManaged public var horizontal: Bool
    @NSManaged public var vertical: Bool
    @NSManaged public var userID: Int16

}

extension CutRecord : Identifiable {

}
