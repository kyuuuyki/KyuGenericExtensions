//  swiftlint:disable:this file_name
//
//  +UIFont.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

public extension UIFont {
	enum RegistrationError: Error {
		case failedToInitializeDataProvider
		case failedToTakeUnretainedValue
	}
	
	static func register(name: String, withExtension: String = "ttf", bundle: Bundle = .main) throws {
		if let url = bundle.url(forResource: name, withExtension: withExtension) {
			guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
				throw RegistrationError.failedToInitializeDataProvider
			}
			let font = CGFont(fontDataProvider)
			var error: Unmanaged<CFError>?
			guard let font, CTFontManagerRegisterGraphicsFont(font, &error) else {
				throw error?.takeUnretainedValue() ?? RegistrationError.failedToTakeUnretainedValue
			}
		}
	}
}
#endif
