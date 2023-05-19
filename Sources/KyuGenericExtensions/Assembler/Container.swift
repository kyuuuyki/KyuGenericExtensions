//
//  Container.swift
//  KyuGenericExtensions
//

import Foundation

/// The default implementation of the container that conforms to the ``ContainerProtocol``.
public final class Container: ContainerProtocol {
	public init() {}
	private var modules = [ModuleKey: Any]()
	
	public func removeAll() {
		modules.removeAll()
	}
	
	public func register<Module>(
		_ moduleType: Module.Type,
		name: String?,
		module: (_ resolver: ResolverProtocol) -> Module
	) {
		let module = module(self)
		let key = ModuleKey(moduleType: moduleType, name: name)
		modules[key] = module
	}
	
	public func resolve<Module>(_ moduleType: Module.Type, name: String?) -> Module? {
		let key = ModuleKey(moduleType: moduleType, name: name)
		return modules[key] as? Module
	}
}
