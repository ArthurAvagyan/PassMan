//
//  EnterPasswordViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 18.03.21.
//

import CryptoSwift
import Foundation

class EnterPasswordViewModel {
	
	private let email: String
	var password: String = ""
	private let coreDataManager = UsersCoreDataManager()
	
	var onSuccess: ((UserModel) -> Void)?
	var onError: ((Error) -> Void)?
	
	init(email: String) {
		self.email = email
	}
	
	func proceed() {
		guard password.isValidPassword.isValid else {
			onError?(NSError.error(.wrongPassword))
			return
		}
		
		guard let user = coreDataManager.user(by: email) else {
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
				DispatchQueue.main.async { [self] in
					user.hashedMasterPassword == hashedMasterPassword ? onSuccess?(UserModel(model: user)) : onError?(NSError())
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
