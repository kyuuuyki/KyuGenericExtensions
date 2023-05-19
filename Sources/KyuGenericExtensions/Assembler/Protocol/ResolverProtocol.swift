//
//  ResolverProtocol.swift
//  KyuGenericExtensions
//

import Foundation

public protocol ResolverProtocol {
	/// Resolve the module from `Resolver`.
	///
	/// - Parameters:
	/// 	- moduleType: Registered module's type.
	///
	/// - Returns: A module which registered using privided moduleType.
	///
	func resolve<Module>(_ moduleType: Module.Type) -> Module?
	
	/// Resolve the module from `Resolver`.
	///
	/// - Parameters:
	/// 	- moduleType: Registered module's type.
	/// 	- name: Registered module's name.
	/// 	
	/// - Returns: A module which registered using privided `moduleType` and `name`.
	///
	func resolve<Module>(_ moduleType: Module.Type, name: String?) -> Module?
}

public extension ResolverProtocol {
	func resolve<Module>(_ moduleType: Module.Type) -> Module? {
		resolve(moduleType, name: nil)
	}
}
