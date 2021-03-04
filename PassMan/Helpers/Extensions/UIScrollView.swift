//
//  UIScrollView.swift
//  aaber
//
//  Created by Arthur Avagyan on 11/6/20.
//  Copyright © 2020 Digitec. All rights reserved.
//

import UIKit

extension UITableView {
	
	func registerCell<T: UITableViewCell>(of type: T.Type) {
		register(UINib(nibName: String(describing: T.self),
					   bundle: nil),
				forCellReuseIdentifier: String(describing: T.self))
	}
    
    func registerHeaderFooler<T: UITableViewHeaderFooterView>(of type: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
	func dequeueCell<T: UITableViewCell>(of type: T.Type, for indexPath: IndexPath) -> T {
		// swiftlint:disable:next force_cast
		dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
	}
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(of type: T.Type) -> T {
		// swiftlint:disable:next force_cast
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
    	
	func scrollToFirstRow(animated: Bool) {
		scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
	}
	
	func scrollToLastRow(forRows count: Int, animated: Bool) {
		scrollToRow(at: IndexPath(row: count - 1, section: 0), at: .bottom, animated: animated)
	}
	
	func scrollTo(indexPath: IndexPath, animated: Bool) {
		let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
		scrollToRow(at: nextIndexPath, at: .top, animated: animated)
	}
	
	func scrollToSelectedRow(animated: Bool) {
		let selectedRows = self.indexPathsForSelectedRows
		guard let selectedRow = selectedRows?[0] else {
			return
		}
		scrollToRow(at: selectedRow, at: .middle, animated: animated)
	}
}

extension UICollectionView {
	
	func registerCell<T: UICollectionViewCell>(of type: T.Type) {
		register(UINib(nibName: String(describing: T.self),
					   bundle: nil),
				 forCellWithReuseIdentifier: String(describing: T.self))
	}
	
	func dequeueCell<T: UICollectionViewCell>(of type: T.Type, for indexPath: IndexPath) -> T {
		// swiftlint:disable:next force_cast
		dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
	}
}

extension UIScrollView {
	
	func scrollToTop(animated: Bool) {
		setContentOffset(.zero, animated: animated)
	}
	
	func scrollToBottom(animated: Bool) {
		let offset = contentSize.height - visibleSize.height
		if offset > contentOffset.y {
			setContentOffset(CGPoint(x: 0, y: offset), animated: animated)
		}
	}
}
