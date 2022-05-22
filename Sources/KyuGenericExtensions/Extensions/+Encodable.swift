//  swiftlint:disable:this file_name
//
//  +Encodable.swift
//  KyuGenericExtensions
//

import Foundation

// MARK: - JSON from Encodable
public extension Encodable {
	/// Get JSON from Encodable object.
	func toJSON() -> [String: Any] {
		guard let data = try? JSONEncoder().encode(self) else { return [:] }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
			.flatMap { $0 as? [String: Any] } ?? [:]
	}
}
