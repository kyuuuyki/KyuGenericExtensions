//
//  Assembler.swift
//  KyuGenericExtensions-Client
//
//  Created by Chayanon.Ard on 17/4/2566 BE.
//

import Foundation
import KyuGenericExtensions
import SwiftUI

public final class Assembler: AssemblerProtocol {
	// MARK: PUBLIC
	public static func assembler() -> AssemblerProtocol {
		return self.shared
	}
	
	public let container: ContainerProtocol = Container()
	
	// MARK: PRIVATE
	private init() {}
	private static let shared = Assembler()
}

public extension Assembler {
	func configure(window: UIWindow?) {
		configureModules()
		configureRootViewController(window: window)
	}
	
	func configureModules() {
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return TransitionCoordinator()
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: ContentSceneModule.moduleName
		) { _ in
			return ContentSceneModule()
		}
	}
	
	func configureRootViewController(window: UIWindow?) {
		guard let viewController = resolver.resolve(
			SceneModuleProtocol.self,
			name: "ContentView"
		)?.build(resolver: resolver, parameters: nil)
		else {
			return
		}
		window?.rootViewController = viewController
	}
}
