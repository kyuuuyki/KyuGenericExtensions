//
//  ModuleKey.swift
//  KyuGenericExtensions
//

import Foundation

internal struct ModuleKey {
	let moduleType: Any.Type
	let name: String?
	
	init(moduleType: Any.Type, name: String?) {
		self.moduleType = moduleType
		self.name = name
	}
}

extension ModuleKey: Hashable {
	static func == (lhs: ModuleKey, rhs: ModuleKey) -> Bool {
		return lhs.moduleType == rhs.moduleType && lhs.name == rhs.name
	}
	
	func hash(into hasher: inout Hasher) {
		ObjectIdentifier(moduleType).hash(into: &hasher)
		name?.hash(into: &hasher)
	}
}
