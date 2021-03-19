//
//  NewPasswordViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import UIKit

class NewPasswordViewController: BaseViewController {
	
	init(onNewPassword: @escaping ((PasswordModel) -> Void)) {
		self.onNewPassword = onNewPassword
		super.init(nibName: "NewPasswordViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet var nameTextField: CustomTextField!
	@IBOutlet var usernameTextField: CustomTextField!
	@IBOutlet var passwordTextField: CustomTextField!
	@IBOutlet var regenerateButton: UIButton!
	@IBOutlet var passwordLengthLabel: UILabel!
	@IBOutlet var passwordLengthSlider: UISlider!
	@IBOutlet var uppercaseSwitch: UISwitch!
	@IBOutlet var numbersSwitch: UISwitch!
	@IBOutlet var symbolsSwitch: UISwitch!
	@IBOutlet var addPasswordButton: CustomButton!
	
	@IBOutlet var uppercasesStackView: UIStackView!
	@IBOutlet var uppercasesCountLabel: UILabel!
	@IBOutlet var uppercasesStepper: UIStepper!
	
	@IBOutlet var numbersStackView: UIStackView!
	@IBOutlet var numbersCountLabel: UILabel!
	@IBOutlet var numbersStepper: UIStepper!
	
	@IBOutlet var symbolsStackView: UIStackView!
	@IBOutlet var symbolsCountLabel: UILabel!
	@IBOutlet var symbolsStepper: UIStepper!
	
	private let onNewPassword: ((PasswordModel) -> Void)
	
	private let viewModel = NewPasswordViewModel()
}

extension NewPasswordViewController {
	
    override func viewDidLoad() {
		needsGradient = false
        super.viewDidLoad()
		
		configureUI()
		bindViewModel()
    }
}

extension NewPasswordViewController {
	
	func configureUI() {
		
		passwordLengthLabel.text = "Password length: \(Int(passwordLengthSlider.value))"
		nameTextField.delegate = self
		usernameTextField.delegate = self
		passwordTextField.delegate = self
		passwordTextField.rightView = regenerateButton
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
	}
	
	func bindViewModel() {
		viewModel.onSuccess = { [weak self] (model) in
			guard let self = self else { return }
			
			self.activityIndicator.stopAnimating()
			self.onNewPassword(model)
			self.dismiss(animated: true)
		}
		
		viewModel.onError = { [weak self] (error) in
			guard let self = self else { return }
			
			self.activityIndicator.stopAnimating()
		}
		
		viewModel.password.bind { [weak self] (password) in
			guard let self = self else { return }
			self.passwordTextField.text = password
		}
		
		viewModel.passwordLength.bindAndNotify { [self] (passwordLength) in
			passwordLengthLabel.text = "Password length: \(passwordLength)"
			passwordLengthSlider.value = Float(passwordLength)
			viewModel.generatePassword()
		}
		
		viewModel.hasUppercases.bindAndNotify { [self] (hasUppercases) in
			UIView.animate(withDuration: 0.3) {
				self.uppercasesStackView.isHidden = !hasUppercases
			}
			
			if !hasUppercases {
				viewModel.uppercasesCount.value = 0
			}
			viewModel.generatePassword()
		}
		
		viewModel.hasNumbers.bindAndNotify { [self] (hasNumbers) in
			UIView.animate(withDuration: 0.3) {
				self.numbersStackView.isHidden = !hasNumbers
			}
			if !hasNumbers {
				viewModel.numbersCount.value = 0
			}
			viewModel.generatePassword()
		}
		
		viewModel.hasSymbols.bindAndNotify { [self] (hasSymbols) in
			UIView.animate(withDuration: 0.3) {
				self.symbolsStackView.isHidden = !hasSymbols
			}
			if !hasSymbols {
				viewModel.symbolsCount.value = 0
			}
			viewModel.generatePassword()
		}
		
		viewModel.uppercasesCount.bindAndNotify { [self] (uppercasesCount) in
			uppercasesCountLabel.text = "\(uppercasesCount)"
			uppercasesStepper.value = Double(uppercasesCount)
			viewModel.generatePassword()
		}
		
		viewModel.numbersCount.bindAndNotify { [self] (numbersCount) in
			numbersCountLabel.text = "\(numbersCount)"
			numbersStepper.value = Double(numbersCount)
			viewModel.generatePassword()
		}
		
		viewModel.symbolsCount.bindAndNotify { [self] (symbolsCount) in
			symbolsCountLabel.text = "\(symbolsCount)"
			symbolsStepper.value = Double(symbolsCount)
			viewModel.generatePassword()
		}
	}
}

extension NewPasswordViewController {
	
	@IBAction func passwordLengthSliderAction(_ sender: UISlider) {
		viewModel.passwordLength.value = Int(sender.value)
	}
	
	@IBAction func uppercasesSwitchAction(_ sender: UISwitch) {
		viewModel.hasUppercases.value = sender.isOn
	}
	
	@IBAction func uppercasesStepperAction(_ sender: UIStepper) {
		viewModel.uppercasesCount.value = Int(sender.value)
		if sender.value == 0 {
			viewModel.hasUppercases.value = false
		}
	}
	
	@IBAction func numbersSwitchAction(_ sender: UISwitch) {
		viewModel.hasNumbers.value = sender.isOn
	}
	
	@IBAction func numbersStepperAction(_ sender: UIStepper) {
		viewModel.numbersCount.value = Int(sender.value)
		if sender.value == 0 {
			viewModel.hasNumbers.value = false
		}
	}
	
	@IBAction func symbolsSwitchAction(_ sender: UISwitch) {
		viewModel.hasSymbols.value = sender.isOn
	}
	
	@IBAction func symbolsStepperAction(_ sender: UIStepper) {
		viewModel.symbolsCount.value = Int(sender.value)
		if sender.value == 0 {
			viewModel.hasSymbols.value = false
		}
	}
	
	@IBAction func addPasswordButtonAction(_ sender: Any) {
		viewModel.proceed()
	}
	
	@IBAction func regenerateButtonAction(_ sender: UIButton) {
		activityIndicator.startAnimating()
		viewModel.generatePassword()
	}
}

extension NewPasswordViewController: UITextFieldDelegate {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		
		switch textField {
		case nameTextField:
			viewModel.name = newString
		case usernameTextField:
			viewModel.username = newString
		case passwordTextField:
			return false
		default:
			break
		}
		
		return true
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case nameTextField:
			usernameTextField.becomeFirstResponder()
		case usernameTextField:
			view.endEditing(true)
		default:
			break
		}
		
		return true
	}
}
