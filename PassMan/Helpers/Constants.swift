//
//  Constants.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

// MARK: - Constants
struct Constants {
	
	static let baseURL = URL(string: "tempUrl")!
}

// MARK: - ValidationErrorType
enum ValidationErrorType: Int {
	
	case invalidEmail
	case invalidPassword
	case passwordsNotMatching
	case wrongPassword
	case noName
	case noUsername
}

enum PasswordValidation {
	
	case noNumber
	case noLowercase
	case noUppercase
	case noSpecial
	case short
	case valid
	
	var isValid: Bool {
		self == .valid
	}
}

// MARK: - ColorType
enum ColorType: String {
	
	case appColor
	case blueTop = "blue_1"
	case blueTopMid = "blue_2"
	case blueMid = "blue_3"
	case blueMidBottom = "blue_4"
	case blueBottom = "blue_5"
}

// MARK: - UIImage
enum ImageType: String {
	
	case eyeActive = "eye_active"
	case eyeInactive = "eye_inactive"
	case close = "close_icon"
}

// MARK: - SizeConstants
struct SizeConstants {
	
	static let cornerRadius: CGFloat = 10
}

// MARK: - FontConstants
extension UIFont {
	
	enum WeblySleekWeight: String {
		
		case semiBold = "Semibold"
		case semiBoldItalic = "Semibold-Italic"
		case semiLight = "Semilight"
		case semiLightItalic = "Semilight-Italic"
		case light = "Light"
		case lightItalic = "Light-Italic"
	}
	
	static func weblySleek(_ weight: WeblySleekWeight, size: CGFloat) -> UIFont {
		UIFont(name: "WeblySleekUI\(weight.rawValue)", size: size)!
	}
}

// MARK: - PermissionType
enum PermissionType: String {
	
	case location
	case microphone
}

// MARK: - KeychainConstants
struct KeychainConstants {
	
   static let temp =  "temp"
}
