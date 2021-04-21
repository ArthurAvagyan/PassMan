//
//  MasterPasswordViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 04.03.21.
//

import CryptoSwift
import Foundation

class MasterPasswordViewModel {
	
	private let email: String
	
	private let coreDataManager = UsersCoreDataManager()
	
	var onUpdateValidation: (([PasswordValidation]) -> Void)?
	var onSuccess: ((UserModel) -> Void)?
	var onError: ((Error) -> Void)?
	
	init(email: String) {
		self.email = email
	}
	
	var password: String = "" {
		didSet {
			validateMatchingRestrictions()
		}
	}
	var repeatPassword: String = ""
}

extension MasterPasswordViewModel {
	
	func proceed() {
		guard password.isValidPassword.isValid else {
			onError?(NSError.error(.invalidPassword))
			return
		}
		
		guard password == repeatPassword else {
			onError?(NSError.error(.passwordsNotMatching))
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
	
	func validateMatchingRestrictions() {
		var pendingValidations: [PasswordValidation] = []
		
		if password.count < 8 {
			pendingValidations.append(.short)
		}
		if !password.isMatchingRegex("[0-9]") {
			pendingValidations.append(.noNumber)
		}
		if !password.isMatchingRegex("[a-z]") {
			pendingValidations.append(.noLowercase)
		}
		if !password.isMatchingRegex("[A-Z]") {
			pendingValidations.append(.noUppercase)
		}
		if !password.isMatchingRegex("[\\[\\]\\{\\}\\s#%^*+=_\\\\|~<>…€£¥•.,?!'-/:;`()$&@\"]") {
			pendingValidations.append(.noSpecial)
		}
		
		onUpdateValidation?(pendingValidations)
	}
}
