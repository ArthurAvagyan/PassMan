//
//  UISearchBar.swift
//  aaber
//
//  Created by Arthur Avagyan on 18.11.20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UISearchBar {
	
	public var textField: UITextField? {
		if #available(iOS 13.0, *) {
			return searchTextField
		}
		
		let subViews = subviews.flatMap { $0.subviews }
		return subViews.first(where: { $0 is UITextField }) as? UITextField
	}
}
