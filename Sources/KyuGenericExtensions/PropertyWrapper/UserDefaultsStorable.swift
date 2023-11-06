//
//  UserDefaultsStorable.swift
//  KyuGenericExtensions
//

import Foundation

@propertyWrapper
public struct UserDefaultsStorable<T: Codable> {
	public var wrappedValue: T? {
		get {
			decodeFromUserDefaults()
		}
		set {
			encodeToUserDefaults(value: newValue)
		}
	}
	
	var key: String
	
	public init(key: String) {
		self.key = key
	}
	
	func decodeFromUserDefaults() -> T? {
		guard let data = UserDefaults.standard.data(
			forKey: key
		) else {
			return nil
		}
		let decoder = JSONDecoder()
		return try? decoder.decode(T.self, from: data)
	}
	
	func encodeToUserDefaults(value: T?) {
		if let value {
			let encoder = JSONEncoder()
			do {
				let data = try encoder.encode(value)
				UserDefaults.standard.setValue(data, forKey: key)
			} catch {
				UserDefaults.standard.removeObject(forKey: key)
			}
		} else {
			UserDefaults.standard.removeObject(forKey: key)
		}
	}
}
