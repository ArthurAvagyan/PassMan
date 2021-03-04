//
//  UIView.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UIView {
	
	var firstResponder: UIView? {
		guard !isFirstResponder else { return self }
		
		for subview in subviews {
			if let firstResponder = subview.firstResponder {
				return firstResponder
			}
		}
		
		return nil
	}
	
	func loadViewFromNib<T: UIView>(owner: T) -> UIView {
		let bundle = Bundle(for: type(of: owner))
		let nib = UINib(nibName: String(describing: type(of: owner)), bundle: bundle)
		// swiftlint:disable:next force_cast
		let view = nib.instantiate(withOwner: owner, options: nil)[0] as! UIView
		return view
	}
	
	func dropShadow(shadowColor: UIColor = .black, shadowRadius: CGFloat = 10, shadowOffset: CGSize = .init(width: 0, height: -3), shadowOpacity: Float = 0.1) {
		layer.shadowColor = shadowColor.cgColor
		layer.shadowRadius = shadowRadius
		layer.shadowOffset = shadowOffset
		layer.shadowOpacity = shadowOpacity
	}
	
	func autoRemoveDimension(_ attribute: NSLayoutConstraint.Attribute ) {
		for constraint in constraints {
			if constraint.firstAttribute.rawValue == attribute.rawValue &&
				constraint.secondAttribute == .notAnAttribute {
				self.removeConstraint(constraint)
			}
		}
	}
	
	func animate(hidden: Bool) {
		if !hidden {
			isHidden = false
		}
		UIView.animate(withDuration: 0.3, animations: {
			self.alpha = hidden ? 0 : 1
		}) { (_) in
			if hidden {
				self.isHidden = true
			}
		}
	}
}
