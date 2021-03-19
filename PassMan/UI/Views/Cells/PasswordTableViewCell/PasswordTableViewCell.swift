//
//  PasswordTableViewCell.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var usernameLabel: UILabel!
	@IBOutlet var passwordLabel: UILabel!
	@IBOutlet var copyButton: UIButton!
	@IBOutlet var eyeButton: UIButton!
	
	var onCopy: (() -> Void)?
	var onEyeAction: (() -> Void)?
	
	private var model: PasswordModel!
	var isSecure = true
}

extension PasswordTableViewCell {
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension PasswordTableViewCell {
	
	func update(with model: PasswordModel) {
		self.model = model
		nameLabel.text = model.name
		usernameLabel.text = model.username
		passwordLabel.text = "••••••••"
	}
}

extension PasswordTableViewCell {
	
	@IBAction func copyButtonAction(_ sender: Any) {
		onCopy?()
	}
	
	@IBAction func eyeButtonAction(_ sender: Any) {
		onEyeAction?()
		passwordLabel.text = passwordLabel.text == "••••••••" ? model.password : "••••••••"
	}
}
