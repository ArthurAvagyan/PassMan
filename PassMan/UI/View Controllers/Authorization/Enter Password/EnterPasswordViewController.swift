//
//  EnterPasswordViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 17.03.21.
//

import UIKit

class EnterPasswordViewController: BaseViewController {

	private let viewModel: EnterPasswordViewModel
	
	init(email: String) {
		viewModel = EnterPasswordViewModel(email: email)
		super.init(nibName: "EnterPasswordViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet var passwordTextField: CustomTextField!
	@IBOutlet var enterButton: CustomButton!
}

extension EnterPasswordViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bindViewModel()
    }
}

extension EnterPasswordViewController {
	
	@IBAction func enterButtonAction(_ sender: Any) {
		activityIndicator.startAnimating()
		viewModel.password = passwordTextField.text ?? ""
		viewModel.proceed()
	}
}

extension EnterPasswordViewController {
	
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
		}
	}
}

extension EnterPasswordViewController {}

extension EnterPasswordViewController {}

extension EnterPasswordViewController {}
