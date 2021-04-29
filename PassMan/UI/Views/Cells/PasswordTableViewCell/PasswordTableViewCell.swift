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
	@IBOutlet var copiedButton: UIButton!
	@IBOutlet var copyButton: UIButton!
	@IBOutlet var eyeButton: UIButton!
	
	@IBOutlet var copiedUsername: UIButton!
	@IBOutlet var copyUsername: UIButton!
	
	var onCopy: (() -> Void)?
	var onCopyUsername: (() -> Void)?
	var onEyeAction: (() -> Void)?
	
	private var model: PasswordModel!
}

extension PasswordTableViewCell {
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
		copiedButton.alpha = 0
		copiedUsername.alpha = 0
    }
}

extension PasswordTableViewCell {
	
	func update(with model: PasswordModel) {
		self.model = model
		nameLabel.text = model.name
		usernameLabel.text = model.username
		passwordLabel.text = "••••••••"
		copiedButton.alpha = 0
		copiedUsername.alpha = 0
	}
}

extension PasswordTableViewCell {
	
	@IBAction func copyUsernameButtonAction(_ sender: Any) {
		onCopyUsername?()
		UIView.animate(withDuration: 2) {
			self.copiedUsername.alpha = 1
		} completion: { (_) in
			UIView.animate(withDuration: 2) {
				self.copiedUsername.alpha = 0
			} completion: { (_) in
				self.copiedUsername.alpha = 0
			}
		}
	}
	
	@IBAction func copyButtonAction(_ sender: Any) {
		onCopy?()
		UIView.animate(withDuration: 2) {
			self.copiedButton.alpha = 1
		} completion: { (_) in
			UIView.animate(withDuration: 2) {
				self.copiedButton.alpha = 0
			} completion: { (_) in
				self.copiedButton.alpha = 0
			}
		}
	}
	
	@IBAction func eyeButtonAction(_ sender: Any) {
		onEyeAction?()
		passwordLabel.text = passwordLabel.text == "••••••••" ? model.password : "••••••••"
	}
}
