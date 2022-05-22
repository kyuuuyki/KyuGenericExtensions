//  swiftlint:disable:this file_name
//
//  +UIApplication.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

// MARK: - Application's version info
public extension UIApplication {
	/// Current application.
	static func application() -> UIApplication {
		return UIApplication.shared
	}
	
	/// Version number.
	var versionNumber: String? {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
	}
	
	/// Build number.
	var buildNumber: String? {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
	}
}

// MARK: - Application's rootViewController
public extension UIApplication {
	/// Get the top-most presenting `ViewController`.
	///
	/// - Parameters:
	/// 	- controller: Controller that you need to get it's top-most presenting `ViewController`.
	/// - Returns: A top-most presenting `ViewController`.
	///
	class func topViewController(
		controller: UIViewController? = UIApplication.shared.window?.rootViewController
	) -> UIViewController? {
		if let navigationController = controller as? UINavigationController {
			return topViewController(controller: navigationController.visibleViewController)
		}
		
		if let tabBarController = controller as? UITabBarController,
		   let selectedViewController = tabBarController.selectedViewController {
			return topViewController(controller: selectedViewController)
		}
		
		if let presentedViewController = controller?.presentedViewController {
			return topViewController(controller: presentedViewController)
		}
		
		return controller
	}
}

// MARK: - Application's window
public extension UIApplication {
	/// Current window.
	var window: UIWindow? {
		return UIApplication
			.shared
			.connectedScenes
			.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
			.first { $0.isKeyWindow }
	}
}
