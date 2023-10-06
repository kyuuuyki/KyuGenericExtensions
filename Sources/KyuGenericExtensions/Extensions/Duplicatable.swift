//
//  Duplicatable.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

import Foundation

#if swift(>=5.9)
@_documentation(visibility: private)
#endif
public protocol Duplicatable: Codable {
	func duplicate() throws -> Self
}

#if swift(>=5.9)
@_documentation(visibility: private)
#endif
public extension Duplicatable {
	func duplicate() throws -> Self {
		let data = try JSONEncoder().encode(self)
		return try JSONDecoder().decode(Self.self, from: data)
	}
}
