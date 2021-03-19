//
//  UserCoreModel+CoreDataClass.swift
//  
//
//  Created by Arthur Avagyan on 17.03.21.
//
//

import Foundation
import CoreData

@objc(UserCoreModel)
public class UserCoreModel: NSManagedObject {
	
	func initialize(from model: UserModel) {
		email = model.email
		hashedMasterPassword = model.hashedMasterPassword
	}
}
