import Foundation
import CoreData


extension Cut {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cut> {
        return NSFetchRequest<Cut>(entityName: "Cut")
    }

    @NSManaged public var xStart: Float
    @NSManaged public var xEnd: Float
    @NSManaged public var yStart: Float
    @NSManaged public var yEnd: Float
    @NSManaged public var kesimYon: NSObject?

}

extension Cut : Identifiable {

}
