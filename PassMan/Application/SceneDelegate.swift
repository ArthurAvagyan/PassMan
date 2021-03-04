//
//  SceneDelegate.swift
//  PassMan
//
//  Created by Arthur Avagyan on 27.02.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		setRoot()
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
}

// MARK: - UI Configuration
extension SceneDelegate {
	
	/// Sets root view controller
	/// - Parameter completion: Transition animation completion
	func setRoot(_ completion: ((_ completed: Bool) -> Void)? = nil) {
//		if AuthorizationManager.shared.user != nil {
//			(UIApplication.shared.delegate as? AppDelegate)?.registerForPushNotifications()
//			animateRootChange(to: MainTabBarController(), completion)
//		} else {
			animateRootChange(to: PasswordsViewController(), completion)
//		DispatchQueue.main.asyncAfter(deadline: .now() + 7) { [self] in
//			animateRootChange(to: BaseViewController(), completion)
//		}
//		}
	}
	
//	private func setLoginViewController(_ completion: ((_ completed: Bool) -> Void)? = nil) {
//		(UIApplication.shared.delegate as? AppDelegate)?.unregisterForPushNotifications()
//		let navigationVC = MainNavigationController(rootViewController: LoginViewController())
//		navigationVC.isNavigationBarHidden = true
//		animateRootChange(to: navigationVC, completion)
//	}
	
	private func animateRootChange(to viewController: UIViewController, _ completion: ((_ completed: Bool) -> Void)? = nil) {
		guard let window = window else { return }
		
		// Set the new rootViewController of the window.
		// Calling "UIView.transition" below will animate the swap.
		window.rootViewController = viewController
		
		// Creates a transition animation.
		UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil) { (completed) in
			completion?(completed)
		}
	}
}
