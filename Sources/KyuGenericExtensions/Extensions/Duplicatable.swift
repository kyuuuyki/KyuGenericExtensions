//
//  Duplicatable.swift
//  KyuGenericExtensions
//

import Foundation

public protocol Duplicatable: Codable {
	func duplicate() throws -> Self
}

public extension Duplicatable {
	func duplicate() throws -> Self {
		let data = try JSONEncoder().encode(self)
		return try JSONDecoder().decode(Self.self, from: data)
	}
}
