//
//  MasterPasswordViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 04.03.21.
//

import UIKit

class MasterPasswordViewController: BaseViewController {

	init(email: String) {
		viewModel = MasterPasswordViewModel(email: email)
		super.init(nibName: "MasterPasswordViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet var passwordTextField: CustomTextField!
	@IBOutlet var repeatPasswordTextField: CustomTextField!
	
	@IBOutlet var lowercaseLabel: UILabel!
	@IBOutlet var uppercaseLabel: UILabel!
	@IBOutlet var numberLabel: UILabel!
	@IBOutlet var symbolLabel: UILabel!
	@IBOutlet var lengthLabel: UILabel!
	@IBOutlet var esiminchButton: CustomButton!
	
	private let viewModel: MasterPasswordViewModel
}

extension MasterPasswordViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
		bindViewModel()
    }
}

extension MasterPasswordViewController {
	
	func configureUI() {
		passwordTextField.delegate = self
		repeatPasswordTextField.delegate = self
		passwordTextField.addEyeButton()
		repeatPasswordTextField.addEyeButton()
		passwordTextField.isSecureTextEntry = true
		repeatPasswordTextField.isSecureTextEntry = true
	}
	
	func bindViewModel() {
		
		viewModel.onUpdateValidation = { [weak self] (pendingValidations) in
			guard let self = self else { return }
			self.lowercaseLabel.textColor = .systemGreen
			self.uppercaseLabel.textColor = .systemGreen
			self.numberLabel.textColor = .systemGreen
			self.symbolLabel.textColor = .systemGreen
			self.lengthLabel.textColor = .systemGreen
			
			pendingValidations.forEach {
				switch $0 {
				case .noNumber:
					self.numberLabel.textColor = .label
				case .noLowercase:
					self.lowercaseLabel.textColor = .label
				case .noUppercase:
					self.uppercaseLabel.textColor = .label
				case .noSpecial:
					self.symbolLabel.textColor = .label
				case .short:
					self.lengthLabel.textColor = .label
				case .valid:
					break
				}
			}
			
		}
		viewModel.onSuccess = { [weak self] (user) in
			guard let self = self else { return }
			self.activityIndicator.stopAnimating()
			
			let vc = PasswordsViewController(user: user)
			self.navigationController?.setViewControllers([vc], animated: true)
		}
		
		viewModel.onError = { [weak self] (error) in
			guard let self = self else { return }
			self.activityIndicator.stopAnimating()
			
			self.showAlert(with: error)
		}
	}
}

extension MasterPasswordViewController {
	
	@IBAction func esiminchButtonAction(_ sender: UIButton) {
		activityIndicator.startAnimating()
		viewModel.proceed()
	}
}

extension MasterPasswordViewController {
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		
		switch textField {
		case passwordTextField:
			viewModel.password = newString
		case repeatPasswordTextField:
			viewModel.repeatPassword = newString
		default:
			break
		}
		
		return true
	}
	
	override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case passwordTextField:
			repeatPasswordTextField.becomeFirstResponder()
		case repeatPasswordTextField:
			view.endEditing(true)
		default:
			break
		}
		
		return true
	}
}

extension MasterPasswordViewController {
	
}
