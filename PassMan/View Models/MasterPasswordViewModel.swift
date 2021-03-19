//
//  MasterPasswordViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 04.03.21.
//

import CryptoSwift
import Foundation
//import SwiftKeychainWrapper

class MasterPasswordViewModel {
	
	private let email: String
	
	private let coreDataManager = UsersCoreDataManager()
	
	var onSuccess: ((UserModel) -> Void)?
	var onError: ((Error) -> Void)?
	
	init(email: String) {
		self.email = email
	}
	
	var password: String = ""
	var repeatPassword: String = ""
}

extension MasterPasswordViewModel {
	
	func proceed() {
		guard password.isValidPassword.isValid else {
			onError?(NSError())
			return
		}
		
		guard password == repeatPassword else {
			onError?(NSError())
			return
		}
		
		DispatchQueue.global().async { [self] in
			do {
				let hashedMasterPassword = try PKCS5.PBKDF2(password: password.bytes,
															salt: email.bytes,
															iterations: 4096,
															keyLength: 32,
															variant: .sha256).calculate()
				let user = UserModel(email: email, hashedMasterPassword: hashedMasterPassword)
				DispatchQueue.main.async { [self] in
					coreDataManager.add(model: user)
					onSuccess?(user)
				}
			} catch {
				print(error)
				DispatchQueue.main.async { [self] in
					onError?(NSError())
				}
			}
		}
	}
}
