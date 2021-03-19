//
//  CustomTextField.swift
//  PassMan
//
//  Created by Arthur Avagyan on 19.03.21.
//

import UIKit

class CustomTextField: UITextField {

	override func awakeFromNib() {
		super.awakeFromNib()
		
		borderStyle = .roundedRect
		layer.borderColor = .of(.appColor)
		layer.borderWidth = 1
		layer.cornerRadius = 8
		clipsToBounds = true
	}
}
