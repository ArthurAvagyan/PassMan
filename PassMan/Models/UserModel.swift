//
//  UserModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 17.03.21.
//

import Foundation

struct UserModel {
	
	let email: String
	let hashedMasterPassword: [UInt8]
	
	internal init(email: String, hashedMasterPassword: [UInt8]) {
		self.email = email
		self.hashedMasterPassword = hashedMasterPassword
	}
	
	internal init(model: UserCoreModel) {
		email = model.email
		hashedMasterPassword = model.hashedMasterPassword
	}
}
