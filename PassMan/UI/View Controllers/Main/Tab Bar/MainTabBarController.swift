////
////  MainTabBarViewController.swift
////  PassMan
////
////  Created by Arthur Avagyan on 28.02.21.
////
//
//import UIKit
//
//class MainTabBarController: UITabBarController {
//	
//	// MARK: - Private variables
//	#if CUSTOMER
//	private let types: [NavigationType] = [.newOrder, .orders, .notifications, .profile]
//	#elseif CAPTAIN
//	private let types: [NavigationType] = [.availableOrders, .orders, .notifications, .profile]
//	#endif
//}
//
//// MARK: - Lifecycle
//extension MainTabBarController {
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		configureViewControllers()
//		configureTabBarAppearance()
//	}
//}
//
//// MARK: - Configuration
//private extension MainTabBarController {
//	
//	func configureViewControllers() {
//		var vcs: [UIViewController] = []
//		types.forEach { vcs.append(MainNavigationController($0)) }
//		viewControllers = vcs
//	}
//	
//	func configureTabBarAppearance() {
//		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.weblySleek(.semiBold, size: 9)],
//														 for: .normal)
//		UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.weblySleek(.semiBold, size: 9)],
//														 for: .selected)
//		
//		tabBar.unselectedItemTintColor = .of(.appInactiveGray)
//		tabBar.tintColor = .of(.appGreen)
//		
//		tabBar.barTintColor = .white
//		tabBar.isTranslucent = false
//		
//		for (index, type) in types.enumerated() {
//			tabBar.items?[index].image = UIImage(named: "\(type.rawValue)")
//			tabBar.items?[index].selectedImage = UIImage(named: "\(type.rawValue)")
//			tabBar.items?[index].title = type.localizedName.capitalized
//		}
//	}
//}
