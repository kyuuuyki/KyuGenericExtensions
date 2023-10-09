//
//  SceneModuleProtocol.swift
//  KyuGenericExtensions
//

import Foundation
#if canImport(UIKit)
import UIKit

// swiftlint:disable:next line_length
/// The protocol defines a module with a more specific capability of building and returning viewcontroller.
public protocol SceneModuleProtocol: ModuleProtocol {
	/// Build the `ViewController` with specified parameters.
	///
	/// - Parameters:
	/// 	- resolver: Resolver that used for resolving `ViewController`'s services from the container.
	/// 	
	/// - Returns: `ViewController`.
	///
	func build(resolver: ResolverProtocol) throws -> UIViewController
	
	/// Build the `ViewController` with specified parameters.
	///
	/// - Parameters:
	/// 	- resolver: Resolver that used for resolving `ViewController`'s services from the container.
	/// 	- parameters: User-specified key-value parameters used in `ViewController`'s build process.
	///
	/// - Returns: `ViewController`.
	///
	func build(resolver: ResolverProtocol, parameters: [String: Any]) throws -> UIViewController
}

public extension SceneModuleProtocol {
	func build(resolver: ResolverProtocol) throws -> UIViewController {
		try build(resolver: resolver, parameters: [:])
	}
}
#endif
