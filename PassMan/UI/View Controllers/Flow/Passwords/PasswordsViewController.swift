//
//  PasswordsViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import UIKit

class PasswordsViewController: BaseViewController {
	
	init(user: UserModel) {
		viewModel = PasswordsViewModel(user: user)
		super.init(nibName: "PasswordsViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet var addPasswordButton: CustomButton!
	@IBOutlet var tableView: UITableView!
	
	private let viewModel: PasswordsViewModel
}

extension PasswordsViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
		bindViewModel()
		viewModel.getPasswords()
    }
}

extension PasswordsViewController {
	
	func configureUI() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerCell(of: PasswordTableViewCell.self)
		tableView.tableFooterView = UIView()
		
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Passwords"
	}
	
	func bindViewModel() {
		viewModel.passwords.bind { [weak self] _ in
			self?.tableView.reloadData()
		}
	}
}

extension PasswordsViewController {
	
	@IBAction func addPasswordButtonAction(_ sender: UIButton) {
		let vc = NewPasswordViewController { [weak self] model in
			guard let self = self else { return }
			
			self.viewModel.addPassword(model)
		}
		
		present(vc, animated: true)
	}
}

extension PasswordsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.passwords.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(of: PasswordTableViewCell.self, for: indexPath)
		let model = viewModel.passwords.value[indexPath.row]
		cell.update(with: model)
		cell.onCopy = {
			UIPasteboard.general.string = model.password
		}
		return cell
	}
}

extension PasswordsViewController: UITableViewDelegate {
	
}
