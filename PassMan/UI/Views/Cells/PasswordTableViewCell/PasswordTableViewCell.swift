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
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
	
	@IBAction func copyButtonAction(_ sender: Any) {
	}
	
	@IBAction func eyeButtonAction(_ sender: Any) {
	}
}
