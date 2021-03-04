//
//  NewPasswordViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import UIKit

class NewPasswordViewController: BaseViewController {
	
	init(onNewPassword: @escaping (() -> Void)) {
		self.onNewPassword = onNewPassword
		super.init(nibName: "NewPasswordViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet var usernameTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var passwordLengthLabel: UILabel!
	@IBOutlet var passwordLengthSlider: UISlider!
	@IBOutlet var uppercaseSwitch: UISwitch!
	@IBOutlet var numbersSwitch: UISwitch!
	@IBOutlet var symbolsSwitch: UISwitch!
	@IBOutlet var addPasswordButton: UIButton!
	
	@IBOutlet var uppercasesStackView: UIStackView!
	@IBOutlet var uppercasesCountLabel: UILabel!
	@IBOutlet var uppercasesStepper: UIStepper!
	
	@IBOutlet var numbersStackView: UIStackView!
	@IBOutlet var numbersCountLabel: UILabel!
	@IBOutlet var numbersStepper: UIStepper!
	
	@IBOutlet var symbolsStackView: UIStackView!
	@IBOutlet var symbolsCountLabel: UILabel!
	@IBOutlet var symbolsStepper: UIStepper!
	
	let onNewPassword: (() -> Void)
}

extension NewPasswordViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureUI()
    }
}

extension NewPasswordViewController {
	
	func configureUI() {
		
		passwordLengthLabel.text = "Password length: \(Int(passwordLengthSlider.value))"
	}
}

extension NewPasswordViewController {
	
	@IBAction func passwordLengthSliderAction(_ sender: UISlider) {
		passwordLengthLabel.text = "Password length: \(Int(sender.value))"
	}
	
	@IBAction func uppercasesSwitchAction(_ sender: UISwitch) {
		UIView.animate(withDuration: 0.3) {
			self.uppercasesStackView.isHidden = !sender.isOn
		}
	}
	
	@IBAction func uppercasesStepperAction(_ sender: UIStepper) {
		uppercasesCountLabel.text = "\(Int(sender.value))"
	}
	
	@IBAction func numbersSwitchAction(_ sender: UISwitch) {
		UIView.animate(withDuration: 0.3) {
			self.numbersStackView.isHidden = !sender.isOn
		}
	}
	
	@IBAction func numbersStepperAction(_ sender: UIStepper) {
		numbersCountLabel.text = "\(Int(sender.value))"
	}
	
	@IBAction func symbolsSwitchAction(_ sender: UISwitch) {
		UIView.animate(withDuration: 0.3) {
			self.symbolsStackView.isHidden = !sender.isOn
		}
	}
	
	@IBAction func symbolsStepperAction(_ sender: UIStepper) {
		symbolsCountLabel.text = "\(Int(sender.value))"
	}
	
	@IBAction func addPasswordButtonAction(_ sender: Any) {
		onNewPassword()
	}
}
