//
//  UITextField.swift
//  aaber
//
//  Created by Arthur Avagyan on 20.11.20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UITextField {
	
	func addDeleteButton() {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
		button.width(44)
		button.setImage(.named(.close), for: .normal)
		button.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
		button.tintColor = .of(.appColor)
		
		rightViewMode = .always
		rightView = button
	}
	
    func addEyeButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.width(44)
        button.setImage(.named(.eyeActive), for: .normal)
        button.addTarget(self, action: #selector(eyeAction(_:)), for: .touchUpInside)
		button.tintColor = .of(.appColor)
        
        rightViewMode = .always
        rightView = button
    }
}

// MARK: - Actions
extension UITextField {

	@objc func deleteAction(_ sender: UIButton) {
		if let text = text,
		   let range = text.range(of: text) {
			let nsRange = NSRange(range, in: text)
			_ = delegate?.textField?(self, shouldChangeCharactersIn: nsRange, replacementString: "")
		}
		text = ""
	}
	
    @objc func eyeAction(_ sender: UIButton) {
        isSecureTextEntry = !isSecureTextEntry
		// swiftlint:disable:next force_cast
        (rightView as! UIButton).setImage(isSecureTextEntry ? .named(.eyeActive) : .named(.eyeInactive), for: .normal)
    }
}
