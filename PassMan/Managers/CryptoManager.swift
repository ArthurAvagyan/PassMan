//
//  CryptoManager.swift
//  PassMan
//
//  Created by Arthur Avagyan on 05.03.21.
//

import CryptoSwift
import Foundation
import SwiftKeychainWrapper

class CryptoManager {
	
	// MARK: - Shared
	static let shared = CryptoManager()
	
	let aes: AES
	
	init?() {
		
		guard let keyData = KeychainWrapper.standard.data(forKey: "MasterPassword") else { return nil }

		let key = keyData.bytes
		
		let iv = "_Wh@11AbiWha11a_".bytes
		do {
			aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
		} catch {
			return nil
		}
	}
}

// MARK: - Encryption and dectiption
extension CryptoManager {
	
	func encrypt(_ plainText: String?) -> String? {
		guard let plainText = plainText else { return nil }
		do {
			let cipherText = try plainText.encryptToBase64(cipher: aes)
			return cipherText
		} catch {
			print(error)
		}
		
		return nil
	}
	
	func decrypt(_ cipherText: String?) -> String? {
		guard let cipherText = cipherText else { return nil }
		do {
			let plainText = try cipherText.decryptBase64ToString(cipher: aes)
			return plainText
		} catch {
			print(error)
		}
		return nil
	}
}
