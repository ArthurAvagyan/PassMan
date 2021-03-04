//
//  UIStackView.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UIStackView {
	
	func removeAllArrangedSubviews() {
		for arrangedSubview in arrangedSubviews {
			arrangedSubview.removeFromSuperview()
			removeArrangedSubview(arrangedSubview)
		}
	}
}
