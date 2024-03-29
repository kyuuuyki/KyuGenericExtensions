//
//  CodableIgnored.swift
//  KyuGenericExtensions
//

import Foundation

/// Ignore current variable from Encoding/Decoding process.
@propertyWrapper
public struct CodableIgnored<T>: Codable {
	public var wrappedValue: T?
	
	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue
	}
	
	public init(from decoder: Decoder) throws {
		self.wrappedValue = nil
	}
	
	public func encode(to encoder: Encoder) throws {
		// Ignoring encoding process
	}
}

public extension KeyedDecodingContainer {
	func decode<T>(
		_ type: CodableIgnored<T>.Type,
		forKey key: Self.Key
	) throws -> CodableIgnored<T> {
		CodableIgnored(wrappedValue: nil)
	}
}

public extension KeyedEncodingContainer {
	mutating func encode<T>(
		_ value: CodableIgnored<T>,
		forKey key: KeyedEncodingContainer<K>.Key
	) throws {
		// Ignoring encoding process
	}
}
