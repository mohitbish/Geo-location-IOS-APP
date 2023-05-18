//
//  Location+CoreDataProperties.swift
//  A2M1
//
//  Created by Mohit Bishnoi on 12/5/2022.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageURL: URL?
    @NSManaged public var detail: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Location : Identifiable {
    
}
