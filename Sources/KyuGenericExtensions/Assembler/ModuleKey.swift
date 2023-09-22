//
//  ModuleKey.swift
//  KyuGenericExtensions
//

import Foundation

internal struct ModuleKey {
	let moduleType: Any.Type
	let name: String?
}

extension ModuleKey: Hashable {
	static func == (lhs: ModuleKey, rhs: ModuleKey) -> Bool {
		lhs.moduleType == rhs.moduleType && lhs.name == rhs.name
	}
	
	func hash(into hasher: inout Hasher) {
		ObjectIdentifier(moduleType).hash(into: &hasher)
		name?.hash(into: &hasher)
	}
}
