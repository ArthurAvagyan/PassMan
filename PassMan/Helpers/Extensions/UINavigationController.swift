//
//  UINavigationController.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UINavigationController {
	
	/// Pushes view controller safely, so prevents pushing twice
	///
	///		navigationController?.pushSafely(vc, from: self, animated: true)
	///
	/// - Parameters:
	///   - viewController: A view controller to be pushed safely
	///   - from: The view controller pushing, !!! always pass self !!!
	///   - animated: Boolean that indicates if push should be animated
	///
	func pushSafely(_ viewController: UIViewController, from fromVC: UIViewController, animated: Bool = true) {
		guard topViewController == fromVC else { return }
		pushViewController(viewController, animated: animated)
	}
}
