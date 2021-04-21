//
//  AuthorizationViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 17.03.21.
//

import UIKit

class AuthorizationViewController: BaseViewController {

	@IBOutlet var emailTextField: CustomTextField!
	@IBOutlet var nextButton: CustomButton!
	
	private var viewModel = AuthorizationViewModel()
}

extension AuthorizationViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindViewModel()
		emailTextField.delegate = self
		emailTextField.addDeleteButton()
		
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Authorization"
    }
}

extension AuthorizationViewController {
	
	func bindViewModel() {
		
		viewModel.onNewUser = { [weak self] (email) in
			guard let self = self else { return }
			
			self.activityIndicator.stopAnimating()
			let vc = MasterPasswordViewController(email: email)
			self.navigationController?.pushSafely(vc, from: self)
		}
		
		viewModel.onExistingUser = { [weak self] (email) in
			guard let self = self else { return }
			
			self.activityIndicator.stopAnimating()
			let vc = EnterPasswordViewController(email: email)
			self.navigationController?.pushSafely(vc, from: self)
		}
		
		viewModel.onError = { [weak self] (error) in
			guard let self = self else { return }
			
			self.activityIndicator.stopAnimating()
			// show alert with error
			self.showAlert(with: error)
		}
	}
}

extension AuthorizationViewController {
	
	@IBAction func nextButtonAction(_ sender: Any) {
		activityIndicator.startAnimating()
		viewModel.email = emailTextField.text ?? ""
		viewModel.proceed()
	}
}
