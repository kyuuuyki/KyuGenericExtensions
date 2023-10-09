//
//  ContentSceneModule.swift
//  KyuGenericExtensions-Client
//

import Foundation
import KyuGenericExtensions
import SwiftUI
import UIKit

struct ContentSceneModule: SceneModuleProtocol {
	static var moduleName: String = "ContentView"
	
	func build(resolver: ResolverProtocol, parameters: [String: Any]) throws -> UIViewController {
		// Services
		let transitionCoordinator = try resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: "TransitionCoordinator"
		)
		
		// ViewController
		let viewController = ContentViewController()
		
		let worker = ContentWorker()
		let presenter = ContentPresenter(viewController: viewController)
		let interactor = ContentInteractor(presenter: presenter, worker: worker)
		let router = ContentRouter(transitionCoordinator: transitionCoordinator)
		viewController.interactor = interactor
		viewController.router = router
		
		let view = ContentView(viewController: viewController)
		let hostingController = UIHostingController(rootView: view)
		viewController.hostingController = hostingController
		return hostingController
	}
}
