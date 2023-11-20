//
//  AppWindowManager.swift
//  KyuGenericExtensions-Client
//

import Foundation
import UIKit

class AppWindowManager {
	class RootViewController: UIViewController {}
	
	var windows: [UIWindow] = []
	var presentingWindow: UIWindow? {
		windows.last
	}
	
	func configureRootWindow(window: UIWindow) {
		window.makeKeyAndVisible()
		windows = [window]
	}
	
	func pushWindow() {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.windowScene = windows.first?.windowScene
		window.rootViewController = RootViewController()
		window.makeKeyAndVisible()
		windows.append(window)
	}
	
	func popWindow() {
		windows.last?.resignKey()
		if windows.count > 1 {
			windows.removeLast()
		}
	}
}
