//
//  CustomButton.swift
//  PassMan
//
//  Created by Arthur Avagyan on 19.03.21.
//

import UIKit

class CustomButton: UIButton {

	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .of(.appColor)
		setTitleColor(.white, for: .normal)
		layer.cornerRadius = frame.height / 2
		layer.masksToBounds = true
	}
}
