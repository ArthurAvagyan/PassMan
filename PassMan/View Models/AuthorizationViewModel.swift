//
//  AuthorizationViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 18.03.21.
//

import Foundation

class AuthorizationViewModel {
	
	var email: String = ""
	
	var onNewUser: ((String) -> Void)?
	var onExistingUser: ((String) -> Void)?
	var onError: ((Error) -> Void)?
	
	private let coreDataManager = UsersCoreDataManager()
	
	func proceed() {
		guard email.isValidEmail else {
			onError?(NSError())
			return
		}
		
		coreDataManager.userExists(by: email) ? onExistingUser?(email) : onNewUser?(email)
	}
}
