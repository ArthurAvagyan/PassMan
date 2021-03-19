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
	}
	
	func bindViewModel() {
		
		viewModel.onSuccess = { [weak self] (user) in
			guard let self = self else { return }
			self.activityIndicator.stopAnimating()
			
			let vc = PasswordsViewController(user: user)
			self.navigationController?.setViewControllers([vc], animated: true)
		}
		
		viewModel.onError = { [weak self] (error) in
			guard let self = self else { return }
			self.activityIndicator.stopAnimating()
			
			// show alert with error
		}
	}
}

extension MasterPasswordViewController {
	
	@IBAction func esiminchButtonAction(_ sender: UIButton) {
		activityIndicator.startAnimating()
		viewModel.proceed()
	}
}

extension MasterPasswordViewController: UITextFieldDelegate {
	
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
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
