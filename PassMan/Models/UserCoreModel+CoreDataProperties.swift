//
//  UserCoreModel+CoreDataProperties.swift
//  
//
//  Created by Arthur Avagyan on 17.03.21.
//
//

import Foundation
import CoreData


extension UserCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreModel> {
        return NSFetchRequest<UserCoreModel>(entityName: "UserCoreModel")
    }

    @NSManaged public var email: String
    @NSManaged public var hashedMasterPassword: [UInt8]

}
