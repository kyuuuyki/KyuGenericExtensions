//
//  ContainerProtocol.swift
//  KyuGenericExtensions
//

import Foundation

/// The protocol defines a container that holds all registered modules.
public protocol ContainerProtocol: ResolverProtocol {
	/// Remove all registered modules from `Container`.
	func removeAll()
	
	/// Register the module into `Container`.
	///
	/// - Parameters:
	/// 	- moduleType: Registering module's type.
	/// 	- module: Factory closure. Expected to return module at the end.
	///
	func register<Module>(
		_ moduleType: Module.Type,
		module: (_ resolver: ResolverProtocol) -> Module
	)
	
	/// Register the module into `Container`.
	///
	/// - Parameters:
	/// 	- moduleType: Registering module's type.
	/// 	- name: Registering module's name.
	/// 	- module: Factory closure. Expected to return module at the end.
	///
	func register<Module>(
		_ moduleType: Module.Type,
		name: String?,
		module: (_ resolver: ResolverProtocol) -> Module
	)
}

public extension ContainerProtocol {
	func register<Module>(
		_ moduleType: Module.Type,
		module: (_ resolver: ResolverProtocol) -> Module
	) {
		register(moduleType, name: nil, module: module)
	}
}
