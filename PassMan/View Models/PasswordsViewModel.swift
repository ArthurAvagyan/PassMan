//
//  PasswordsViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import CryptoSwift
import Foundation
import SwiftKeychainWrapper

class PasswordsViewModel {
	
	private let user: UserModel
	
	init(user: UserModel) {
		self.user = user
	}
	
	private (set)var passwords: Observable<[PasswordModel]> = Observable([])
	
	private let coreDataManager = PasswordCoreDataManager()
	
	func addPassword(_ model: PasswordModel) {
		var encryptedModel = model
		
		guard let cipherText = CryptoManager.shared?.encrypt(encryptedModel.password) else { return }
		
		encryptedModel.password = cipherText
		
		coreDataManager.add(model: encryptedModel, email: user.email)

		passwords.value.append(model)
	}
	
	func deletePassowrd(at indexPath: IndexPath) {
		coreDataManager.delete(at: indexPath.row, for: user)
		passwords.value.remove(at: indexPath.row)
	}
	
	func getPasswords() {
		let cachedPasswords = coreDataManager.getAllPasswords(for: user)
		
		var passwordModels: [PasswordModel] = []
		
		cachedPasswords?.forEach({ (password) in
			if let model = PasswordModel(model: password) {
				passwordModels.append(model)
			}
		})
		
		self.passwords.value.append(contentsOf: passwordModels)
	}
}
