//
//  TransitionCoordinatorProtocol.swift
//  KyuGenericExtensions
//

import Foundation
#if canImport(UIKit)
import UIKit

// swiftlint:disable:next line_length
/// The protocol defines a transition coordinator that acts as a central hub for routing to other view controllers based on parameters.
public protocol TransitionCoordinatorProtocol: ModuleProtocol {
	var resolver: ResolverProtocol { get }
	func performNavigation(_ type: Any, animated: Bool, completion: (() -> Void)?)
	func resolveScene(sceneName: String, parameters: [String: Any]?) -> UIViewController?
}

public extension TransitionCoordinatorProtocol {
	func resolveScene(sceneName: String, parameters: [String: Any]?) -> UIViewController? {
		guard let sceneModule = resolver.resolve(
			SceneModuleProtocol.self,
			name: sceneName
		) else {
			return nil
		}
		
		return sceneModule.build(resolver: resolver, parameters: parameters)
	}
}
#endif
