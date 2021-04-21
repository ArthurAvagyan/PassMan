//
//  NewPasswordViewModel.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import Foundation

class NewPasswordViewModel {
	
	var name = ""
	var username = ""
	var password: Observable<String> = Observable("")
	
	var passwordLength: Observable<Int> = Observable(16)
	var hasUppercases: Observable<Bool> = Observable(true)
	var hasNumbers: Observable<Bool> = Observable(true)
	var hasSymbols: Observable<Bool> = Observable(true)
	
	var uppercasesCount: Observable<Int> = Observable(1)
	var numbersCount: Observable<Int> = Observable(1)
	var symbolsCount: Observable<Int> = Observable(1)
	
	var onSuccess: ((PasswordModel) -> Void)?
	var onError: ((Error) -> Void)?
	
	func generatePassword() {
		let additionalCount = numbersCount.value + symbolsCount.value + uppercasesCount.value
		guard additionalCount <= passwordLength.value - 1 else {
			passwordLength.value = additionalCount
			return
		}
		let lowercases = "abcdefghijklmnopqrstuvwxyz"
		let uppercases = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		let numbers = "0123456789"
		let symbols = "[]{}#%^*+=_\\|~<>€£¥.,?!'-/\\:;`()$&@\""
		
		var password = String(( 0 ..< passwordLength.value - additionalCount).map { _ in lowercases.randomElement()! })
		
		var insertedNumbersCount = 0
		var insertedUppercasesCount = 0
		var insertedSymbolsCount = 0
		
		for _ in 0 ..< additionalCount {
			let randomPositon = Int.random(in: 0 ..< password.count)
			
			if insertedNumbersCount < numbersCount.value {
				insertedNumbersCount += 1
				password.insert(numbers.randomElement()!, at: password.index(password.startIndex, offsetBy: randomPositon))
			} else if insertedUppercasesCount < uppercasesCount.value {
				insertedUppercasesCount += 1
				password.insert(uppercases.randomElement()!, at: password.index(password.startIndex, offsetBy: randomPositon))
			} else if insertedSymbolsCount < symbolsCount.value {
				insertedSymbolsCount += 1
				password.insert(symbols.randomElement()!, at: password.index(password.startIndex, offsetBy: randomPositon))
			}
		}
		
		self.password.value = password
	}
	
	func proceed() {
		guard !name.isEmpty else {
			onError?(NSError.error(.noName))
			return
		}
		
		guard !username.isEmpty else {
			onError?(NSError.error(.noUsername))
			return
		}
		
		onSuccess?(PasswordModel(name: name, username: username, password: password.value))
	}
}
