//
//  TransitionCoordinator.swift
//  KyuGenericExtensions-Client
//

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
	
	// swiftlint:disable:next cyclomatic_complexity
	public func continueNavigation(
		_ type: NavigationType,
		animated: Bool,
		completion: (() -> Void)?
	) {
		let presentingWindow = Assembler.shared.windowManager.presentingWindow
		let rootViewController = presentingWindow?.rootViewController
		var presentingViewController = UIApplication.topViewController(
			controller: rootViewController
		)
		
		if presentingViewController is UISearchController {
			presentingViewController = presentingViewController?.presentingViewController
			?? presentingViewController
		}
		
		switch type {
		case .present(let sceneName, let parameters):
			// MARK: PRESENT
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			
			if let presentingViewController {
				presentingViewController.present(
					viewController,
					animated: animated,
					completion: completion
				)
			} else {
				presentingWindow?.rootViewController = viewController
			}
			
		case .push(let sceneName, let parameters):
			// MARK: PUSH
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			viewController.hidesBottomBarWhenPushed = true
			
			if let presentingViewController {
				presentingViewController.navigationController?.pushViewController(
					viewController,
					animated: animated
				)
			} else {
				presentingWindow?.rootViewController = viewController
			}
			
			completion?()
			
		case .presentAndPush(let sceneName, let parameters):
			// MARK: PRESENT AND PUSH
			guard let viewController = try? resolveScene(
				sceneName: sceneName,
				parameters: parameters
			) else {
				return
			}
			viewController.hidesBottomBarWhenPushed = true
			
			let navigationController = AppNavigationController(rootViewController: viewController)
			if let presentingViewController {
				presentingViewController.present(
					navigationController,
					animated: animated,
					completion: completion
				)
			} else {
				presentingWindow?.rootViewController = viewController
			}
			
		case .back:
			// MARK: BACK
			let dismissalCompletion: () -> Void = {
				let newPresentingViewController = UIApplication.topViewController(
					controller: rootViewController
				)
				if newPresentingViewController is AppWindowManager.RootViewController {
					continueNavigation(.back, animated: false, completion: completion)
				} else {
					completion?()
				}
			}
			
			if presentingViewController == rootViewController {
				Assembler.shared.windowManager.popWindow()
				completion?()
				return
			}
			
			if let navigationController = presentingViewController?.navigationController,
			   navigationController.viewControllers.count > 1 {
				navigationController.popViewController(animated: animated)
				dismissalCompletion()
			} else {
				presentingViewController?.dismiss(
					animated: animated,
					completion: dismissalCompletion
				)
			}
			
		case .reset:
			// MARK: RESET
			Assembler.assembler().reconfigure()
			
		case .openUrl(let url, let parameters):
			// MARK: OPEN URL
			// Evaluate Deeplinks here
			continueNavigation(.safari(url: url), animated: animated, completion: completion)
			
		case .safari(let url):
			// MARK: SAFARI
			if UIApplication.shared.canOpenURL(url) {
				UIApplication.shared.open(url)
			}
		}
	}
}
