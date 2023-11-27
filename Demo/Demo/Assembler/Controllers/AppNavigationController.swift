//
//  AppNavigationController.swift
//  KyuGenericExtensions-Client
//

import Foundation
import UIKit

class AppNavigationController: UINavigationController, UIGestureRecognizerDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.prefersLargeTitles = false
		interactivePopGestureRecognizer?.delegate = self
	}
	
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		viewControllers.count > 1
	}
}
