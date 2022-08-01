import Foundation
import CoreData


extension MaterialVersion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaterialVersion> {
        return NSFetchRequest<MaterialVersion>(entityName: "MaterialVersion")
    }

    @NSManaged public var id: Int16
    @NSManaged public var versionName: String?

}

extension MaterialVersion : Identifiable {

}
