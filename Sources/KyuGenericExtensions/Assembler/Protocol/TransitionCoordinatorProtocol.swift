//
//  TransitionCoordinatorProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

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
		
		return sceneModule.build(with: parameters)
	}
}
