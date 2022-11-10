//
//  SceneModuleProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol SceneModuleProtocol: ModuleProtocol {
	var nibName: String { get }
	var bundle: Bundle? { get }
	
	/// Build the `ViewController` with specified parameters.
	///
	/// - Parameters:
	/// 	- resolver: Resolver that used for resolving `ViewController`'s services from the container.
	/// 	- parameters: User-specified key-value parameters used in `ViewController`'s build process.
	/// - Returns: `ViewController`.
	///
	func build(resolver: ResolverProtocol, parameters: [String: Any]?) -> UIViewController?
}
