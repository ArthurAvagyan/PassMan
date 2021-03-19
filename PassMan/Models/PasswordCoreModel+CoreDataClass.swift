//
//  PasswordCoreModel+CoreDataClass.swift
//  
//
//  Created by Arthur Avagyan on 05.03.21.
//
//

import CoreData
import CryptoSwift
import Foundation

@objc(PasswordCoreModel)
public class PasswordCoreModel: NSManagedObject {
	
	func initialize(from model: PasswordModel, email: String) {
		name = model.name
		username = model.username
		password = model.password
		userEmail = email
	}
}

extension PasswordCoreModel {
	
	var decryptedPassword: String? {
		CryptoManager.shared?.decrypt(password)
	}
}
