//
//  PasswordCoreModel+CoreDataProperties.swift
//  
//
//  Created by Arthur Avagyan on 05.03.21.
//
//

import CoreData
import Foundation

extension PasswordCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordCoreModel> {
        return NSFetchRequest<PasswordCoreModel>(entityName: "PasswordCoreModel")
    }

    @NSManaged public var name: String
    @NSManaged public var username: String
    @NSManaged public var password: String
	@NSManaged public var userEmail: String
}
