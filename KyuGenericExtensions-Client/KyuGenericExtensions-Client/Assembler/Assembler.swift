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
		self.shared
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
			TransitionCoordinator()
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: ContentSceneModule.moduleName
		) { _ in
			ContentSceneModule()
		}
	}
	
	func configureRootViewController(window: UIWindow?) {
		let viewController = try? resolver
			.resolve(
				SceneModuleProtocol.self,
				name: "ContentView"
			)
			.build(resolver: resolver)
		window?.rootViewController = viewController
	}
}
