//
//  PasswordsViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 03.03.21.
//

import UIKit

class PasswordsViewController: BaseViewController {
	
	@IBOutlet var addPasswordButton: UIButton!
	@IBOutlet var tableView: UITableView!
	
	private let viewModel = PasswordsViewModel()
	
}

extension PasswordsViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

		configureUI()
    }
}

extension PasswordsViewController {
	
	func configureUI() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerCell(of: PasswordTableViewCell.self)
	}
}

extension PasswordsViewController {
	
	@IBAction func addPasswordButtonAction(_ sender: Any) {
		let vc = NewPasswordViewController { [weak self] in
			guard let self = self else { return }
			
		}
		
		present(vc, animated: true)
	}
}

extension PasswordsViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueCell(of: PasswordTableViewCell.self, for: indexPath)
		return cell
	}
}

extension PasswordsViewController: UITableViewDelegate {
	
}
