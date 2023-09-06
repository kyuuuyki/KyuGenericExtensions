//
//  TransitionCoordinator.swift
//  KyuGenericExtensions-Client
//
//  swiftlint:disable sorted_enum_cases

import Foundation
import KyuGenericExtensions
import SwiftUI
import UIKit

public struct TransitionCoordinator: TransitionCoordinatorProtocol {
	public static var moduleName: String = "TransitionCoordinator"
	public var resolver: ResolverProtocol {
		Assembler.assembler().resolver
	}
	
	public func performNavigation(
		_ type: Any,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard let type = type as? NavigationType else { return }
		continueNavigation(type, animated: animated, completion: completion)
	}
	
	public func continueNavigation(
		_ type: NavigationType,
		animated: Bool,
		completion: (() -> Void)?
	) {
		guard var presentingViewController = UIApplication.topViewController() else { return }
		if presentingViewController is UISearchController {
			presentingViewController = presentingViewController.presentingViewController
			?? presentingViewController
		}
		
		switch type {
		case .present(let sceneName, let parameters):
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			
			presentingViewController.present(
				viewController,
				animated: animated,
				completion: completion
			)
			
		case .push(let sceneName, let parameters):
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			viewController.hidesBottomBarWhenPushed = true
			
			presentingViewController.navigationController?.pushViewController(
				viewController,
				animated: animated
			)
			
			completion?()
			
		case .presentAndPush(let sceneName, let parameters):
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			viewController.hidesBottomBarWhenPushed = true
			
			let navigationController = AppNavigationController(rootViewController: viewController)
			presentingViewController.present(
				navigationController,
				animated: animated,
				completion: completion
			)
			
		case .back:
			guard let navigationController = presentingViewController.navigationController else {
				presentingViewController.dismiss(animated: animated, completion: completion)
				return
			}
			
			if navigationController.viewControllers.count > 1 {
				navigationController.popViewController(animated: animated)
				completion?()
			} else {
				navigationController.dismiss(animated: animated, completion: completion)
			}
			
		case .reset:
			Assembler.assembler().reconfigure()
		}
	}
}

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

public enum NavigationType {
	// Base Navigation
	case present(sceneName: String, parameters: [String: Any])
	case push(sceneName: String, parameters: [String: Any])
	case presentAndPush(sceneName: String, parameters: [String: Any])
	case back
	case reset
}
