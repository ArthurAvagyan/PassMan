//
//  Utility.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

// MARK: - UIColor
extension UIColor {
	
	static func of(_ type: ColorType) -> UIColor {
		UIColor(named: type.rawValue)!
	}
}

// MARK: - CGColor
extension CGColor {
	
	static func of(_ type: ColorType) -> CGColor {
		UIColor.of(type).cgColor
	}
}

extension UIImage {
	
	static func named(_ type: ImageType) -> UIImage {
		UIImage(named: type.rawValue)!
	}
}

// MARK: - UIFont
extension UIFont {
	
	static func printAllNames() {
		UIFont.familyNames.forEach {
			print($0)
			UIFont.fontNames(forFamilyName: $0).forEach {
				print("== \($0)")
			}
		}
	}
}

// MARK: - NSAttributedString
extension NSAttributedString {
	
	var mutableAttributed: NSMutableAttributedString {
		NSMutableAttributedString(attributedString: self)
	}
}

extension Int {
	
	var formattedDuration: String {
		let secondsString = String(format: "%02d", self % 60)
		let minutesString = String(format: "%02d", (self / 60) % 60)
		let hoursString = String(self / 3600)
		return "\(hoursString != "0" ? hoursString + ":" : "")\(minutesString):\(secondsString)"
	}
}

// MARK: - String
extension String {
	
	var utf8: Data {
		self.data(using: .utf8)!
	}
	
	static var uniqueFileName: String {
		"\(Date().formateString(as: .api)) \(UUID().uuidString)"
	}
	
//	func attributed(_ weight: UIFont.WeblySleekWeight, size: CGFloat, color: UIColor = .of(.appBlue), isUnderline: Bool = false) -> NSAttributedString {
//		var attributes: [NSAttributedString.Key: Any] = [
//			NSAttributedString.Key.font: UIFont.weblySleek(weight, size: size),
//			NSAttributedString.Key.foregroundColor: color
//		]
//		
//		if isUnderline {
//			attributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
//		}
//		
//		return NSAttributedString(string: self, attributes: attributes)
//	}
//	
//	var underlined: NSAttributedString {
//		attributed(.semiLight, size: 16, isUnderline: true)
//	}
//	
//	var attributedTitle: NSAttributedString {
//		attributed(.semiBold, size: 17)
//	}
//	
//	var attributedPlaceholder: NSAttributedString {
//		attributed(.semiLight, size: 17)
//	}
//	
//	var attributedBold: NSAttributedString {
//		attributed(.semiBold, size: 18)
//	}
//	
//	var attributedLight: NSAttributedString {
//		attributed(.semiLight, size: 18)
//	}
	
	var isValidEmail: Bool {
		let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
			"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
			"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
			"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
			"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
			"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
			"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
		return isMatchingRegex(emailRegEx)
	}
	
	var isValidPassword: PasswordValidation {
		if count < 8 {
			return .short
		} else if !isMatchingRegex("[0-9]") {
			return .noNumber
		} else if !isMatchingRegex("[a-z]") {
			return .noLowercase
		} else if !isMatchingRegex("[A-Z]") {
			return .noUppercase
		} else if !isMatchingRegex("[\\[\\]\\{\\}\\s#%^*+=_\\\\|~<>…€£¥•.,?!'-/:;`()$&@\"]") {
			return .noSpecial
		}
		return .valid
	}
	
	enum PhoneValidation {
		
		case notPhone
		case short
		case long
		case valid
	}
	
	// I hate Regex
	var isValidDouble: Bool {
		isMatchingRegex("^(?:|0|[1-9]\\d*)(?:\\.\\d{0,2})?$") || isMatchingRegex("^(?:|0|[1-9]\\d*)(?:\\,\\d{0,2})?$")
	}
	
	var isValidNumber: Bool {
		isMatchingRegex("^[0-9]*$")
	}
	
	var isValidZipCode: Bool {
		isMatchingRegex("^[0-9a-zA-Z]*$")
	}
	
	var isValidPhoneNumber: PhoneValidation {
		if !isValidNumber {
			return .notPhone
		} else {
			if count < 6 {
				return .short
			} else if count > 15 {
				return .long
			}
		}
		return .valid
	}
	
	func isMatchingRegex(_ pattern: String) -> Bool {
		let range = NSRange(location: 0, length: self.utf16.count)
		let regex = NSRegularExpression(pattern)
		return regex.firstMatch(in: self, range: range) != nil
	}
}

// MARK: - StringProtocol
extension StringProtocol {

	subscript(offset: Int) -> Character? {
		guard offset < count else { return nil }
		return self[index(startIndex, offsetBy: offset)]
	}

	subscript(range: Range<Int>) -> SubSequence {
		let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
		return self[startIndex..<index(startIndex, offsetBy: range.count)]
	}

	subscript(range: ClosedRange<Int>) -> SubSequence {
		let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
		return self[startIndex..<index(startIndex, offsetBy: range.count)]
	}

	subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }

	subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }

	subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}

// MARK: - NSRegularExpression
extension NSRegularExpression {
	
	convenience init(_ pattern: String) {
		do {
			try self.init(pattern: pattern)
		} catch {
			preconditionFailure("Illegal regular expression: \(pattern).")
		}
	}
}

// MARK: - NSLayoutConstraint
extension NSLayoutConstraint {

	static func changeMultiplier(of constraint: inout NSLayoutConstraint, to multiplier: CGFloat) {
		NSLayoutConstraint.deactivate([constraint])

		let newConstraint = NSLayoutConstraint(item: constraint.firstItem as Any,
											   attribute: constraint.firstAttribute,
											   relatedBy: constraint.relation,
											   toItem: constraint.secondItem,
											   attribute: constraint.secondAttribute,
											   multiplier: multiplier,
											   constant: constraint.constant)

		newConstraint.priority = constraint.priority
		newConstraint.shouldBeArchived = constraint.shouldBeArchived
		newConstraint.identifier = constraint.identifier

		NSLayoutConstraint.activate([newConstraint])
		constraint = newConstraint
	}

	static func changeRelation(of constraint: inout NSLayoutConstraint, to relation: NSLayoutConstraint.Relation) {
		NSLayoutConstraint.deactivate([constraint])

		let newConstraint = NSLayoutConstraint(item: constraint.firstItem as Any,
											   attribute: constraint.firstAttribute,
											   relatedBy: relation,
											   toItem: constraint.secondItem,
											   attribute: constraint.secondAttribute,
											   multiplier: constraint.multiplier,
											   constant: constraint.constant)

		newConstraint.priority = constraint.priority
		newConstraint.shouldBeArchived = constraint.shouldBeArchived
		newConstraint.identifier = constraint.identifier

		NSLayoutConstraint.activate([newConstraint])
		constraint = newConstraint
	}
}

// MARK: - Data
extension Data {
	
	var prettyPrintedJSONString: String? {
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			  let prettyPrintedString = String(data: data, encoding: String.Encoding.utf8) else { return nil }

		return prettyPrintedString
	}
}

// MARK: - NSError
extension NSError {
	
	// swiftlint:disable:next cyclomatic_complexity
	static func error(_ errorType: ValidationErrorType) -> NSError {
		var message = ""
		
		switch errorType {
		case .invalidEmail: 			message = "Invalid email"
		case .invalidPassword: 			message = "Massword must match all restrictions"
		case .passwordsNotMatching: 	message = "Passwords do not match"
		case .wrongPassword:			message = "Wrong password"
		case .noName:					message = "Name must not be empty"
		case .noUsername:				message = "Username must not be empty"
				
		}
		
		return NSError(domain: "", code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
	}
}
