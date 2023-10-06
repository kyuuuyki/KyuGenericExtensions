//
//  ContentRouter.swift
//  KyuGenericExtensions-Client
//

import Foundation
import KyuGenericExtensions
import UIKit

// MARK: - ROUTING LOGIC
protocol ContentRouterProtocol {
	func presentContentView()
	func pushContentView()
	func presentAndPushContentView()
	func back()
	func reset()
}

// MARK: - ROUTER
struct ContentRouter: ContentRouterProtocol {
	var transitionCoordinator: TransitionCoordinatorProtocol?
}

extension ContentRouter {
	func presentContentView() {
		transitionCoordinator?.performNavigation(
			NavigationType.present(
				sceneName: "ContentView",
				parameters: [:]
			),
			animated: true,
			completion: nil
		)
	}
	
	func pushContentView() {
		transitionCoordinator?.performNavigation(
			NavigationType.push(
				sceneName: "ContentView",
				parameters: [:]
			),
			animated: true,
			completion: nil
		)
	}
	
	func presentAndPushContentView() {
		transitionCoordinator?.performNavigation(
			NavigationType.presentAndPush(
				sceneName: "ContentView",
				parameters: [:]
			),
			animated: true,
			completion: nil
		)
	}
	
	func back() {
		transitionCoordinator?.performNavigation(
			NavigationType.back,
			animated: true,
			completion: nil
		)
	}
	
	func reset() {
		transitionCoordinator?.performNavigation(
			NavigationType.reset,
			animated: true,
			completion: nil
		)
	}
}
