//
//  PasswordModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 04.03.21.
//

import Foundation

struct PasswordModel {
	
	let name: String
	let username: String
	var password: String
	
	internal init(name: String, username: String, password: String) {
		self.name = name
		self.username = username
		self.password = password
	}
	
	init?(model: PasswordCoreModel) {
		name = model.name
		username = model.username
		guard let decryptedPassword = model.decryptedPassword else { return nil }
		password = decryptedPassword
	}
}
