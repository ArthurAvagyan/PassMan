//
//  UIViewController.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UIViewController {

	static func changeRoot() {
		let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
		let sceneDelegate = windowScene?.delegate as? SceneDelegate
		sceneDelegate?.setRoot()
	}
	
	func showToast(message: String, font: UIFont = UIFont.systemFont(ofSize: 15)) {
		let toastLabel = UILabel(frame: CGRect(x: 75,
											   y: view.frame.size.height - 100,
											   width: view.frame.size.width - 150,
											   height: 40))
		toastLabel.backgroundColor = UIColor.systemGray
		toastLabel.textColor = UIColor.white
		toastLabel.font = font
		toastLabel.textAlignment = .center
		toastLabel.text = message
		toastLabel.minimumScaleFactor = 0.5
		
		toastLabel.layer.cornerRadius = 20
		toastLabel.layer.masksToBounds = true
		
		view.addSubview(toastLabel)
		
		UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseOut, animations: {
			 toastLabel.alpha = 0.0
		}, completion: { (_) in
			toastLabel.removeFromSuperview()
		})
	}
	
//	func showAlert(title: String,
//				   message: String,
//				   actions: [UIAlertAction] = [],
//				   completion: (() -> Void)? = nil) {
//		let alertController = UIAlertController(title: title,
//												message: message,
//												preferredStyle: .alert)
//		alertController.view.tintColor = .systemBlue
//		
//		if actions.isEmpty {
//			alertController.addAction(UIAlertAction(title: .localized(.ok),
//													style: .cancel))
//		} else {
//			for action in actions {
//				alertController.addAction(action)
//			}
//		}
//		
//		present(alertController, animated: true, completion: completion)
//	}

//	func showAlert(with error: Error,
//				   repeatAction selector: Selector? = nil,
//				   _ object: Any? = nil) {
//		let alertController = UIAlertController(title: .localized(.error),
//												message: error.localizedDescription,
//												preferredStyle: .alert)
//		alertController.view.tintColor = .systemBlue
////		alertController.configureUI(title: .localized(.error),
////									message: error.localizedDescription)
//
//		alertController.addAction(UIAlertAction(title: .localized(.ok),
//												style: .default))
//		if let selector = selector {
//			alertController.addAction(UIAlertAction(title: .localized(.repeatAction),
//													style: .default,
//													handler: { [self] _ in
//				if responds(to: selector) {
//					perform(selector, with: object)
//				}
//			}))
//		}
//
//		present(alertController, animated: true, completion: nil)
//	}
	
	func popTo<T: UIViewController>(_ type: T.Type) {
		for controller in navigationController?.viewControllers ?? [] {
			if controller.isKind(of: type) {
				navigationController?.popToViewController(controller, animated: true)
				break
			}
		}
	}
	
	/// Deselects selected row of given tableview interactively
	/// - Parameters:
	///   - tableView: The view controller that you want to animate selection
	///   - animated: Set this value to true to animate the transition
	func deselect(_ tableView: UITableView, animated: Bool) {
		if let selectedIndexPath = tableView.indexPathForSelectedRow {
			if let coordinator = transitionCoordinator {
				coordinator.animate(alongsideTransition: { context in
					tableView.deselectRow(at: selectedIndexPath, animated: true)
				}) { context in
					if context.isCancelled {
						tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
					}
				}
			} else {
				tableView.deselectRow(at: selectedIndexPath, animated: animated)
			}
		}
	}
	
//	func askToOpenSettingsFor(_ permission: PermissionType) {
//		let message = "aaber doesn't have permission to use the \(permission.rawValue), please change privacy settings"
//		var actions: [UIAlertAction] = []
//		actions.append(UIAlertAction(title: .localized(.cancel), style: .cancel))
//		actions.append(UIAlertAction(title: .localized(.settings), style: .default, handler: { _ in
//			UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//		}))
//
//		showAlert(title: "Allow access to \(permission.rawValue)", message: message, actions: actions)
//	}
}
