//
//  MainNavigationViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 28.02.21.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationBar.isTranslucent = true
		navigationBar.tintColor = UIColor.of(.appColor)
		navigationBar.barTintColor = UIColor.of(.appColor)
		navigationBar.largeTitleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.of(.appColor)
		]
		navigationBar.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.of(.appColor)
		]
	}
}
