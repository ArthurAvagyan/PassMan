//
//  BaseViewController.swift
//  PassMan
//
//  Created by Arthur Avagyan on 28.02.21.
//

import Pastel
import UIKit

class BaseViewController: UIViewController {
	
	var activityIndicator: UIActivityIndicatorView!
	
	var needsGradient = true
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
		addActivityIndicator()
		addGradient()
	}
	
	@objc func closeKeyboard() {
		view.endEditing(true)
	}
	
	private func addActivityIndicator() {
		activityIndicator = UIActivityIndicatorView(style: .large)
		
		activityIndicator.color = .of(.appColor)
		activityIndicator.stopAnimating()
		
		view.addSubview(activityIndicator)
		activityIndicator.edgesToSuperview()
	}
	
	private func addGradient() {
		guard needsGradient else { return }
		let pastelView = PastelView()

		// Custom Direction
		pastelView.startPastelPoint = .bottomLeft
		pastelView.endPastelPoint = .topRight

		// Custom Duration
		pastelView.animationDuration = 3.0

		// Custom Color
		pastelView.setColors([
			UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
			UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
			UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
			UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
			UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
			UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
			UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)
		].shuffled())

		pastelView.startAnimation()
		view.insertSubview(pastelView, at: 0)
		pastelView.edgesToSuperview()
	}
}
