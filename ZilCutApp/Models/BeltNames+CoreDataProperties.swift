import Foundation
import CoreData


extension BeltNames {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeltNames> {
        return NSFetchRequest<BeltNames>(entityName: "BeltNames")
    }

    @NSManaged public var code: String?
    @NSManaged public var material: String?

}

extension BeltNames : Identifiable {

}
