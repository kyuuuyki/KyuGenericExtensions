//
//  ResolverProtocol.swift
//  KyuGenericExtensions
//

import Foundation

// swiftlint:disable:next line_length
/// The protocol enables specific classes to have the ability to resolve registered modules from the container of an Assembler.
public protocol ResolverProtocol {
	/// Resolve the module from `Resolver`.
	///
	/// - Parameters:
	/// 	- moduleType: Registered module's type.
	///
	/// - Returns: A module which registered using privided moduleType.
	///
	func resolve<Module>(_ moduleType: Module.Type) throws -> Module
	
	/// Resolve the module from `Resolver`.
	///
	/// - Parameters:
	/// 	- moduleType: Registered module's type.
	/// 	- name: Registered module's name.
	/// 	
	/// - Returns: A module which registered using privided `moduleType` and `name`.
	/// - Throws: ``ResolverError/moduleNotFound`` if designated module
	/// was not registered to the container.
	///
	func resolve<Module>(_ moduleType: Module.Type, name: String?) throws -> Module
}

public enum ResolverError: Error {
	case moduleNotFound
}

public extension ResolverProtocol {
	func resolve<Module>(_ moduleType: Module.Type) throws -> Module {
		try resolve(moduleType, name: nil)
	}
}
