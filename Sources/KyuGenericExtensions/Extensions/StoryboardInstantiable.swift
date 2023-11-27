//
//  StoryboardInstantiable.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

#if canImport(UIKit)
import UIKit

#if swift(>=5.9)
@_documentation(visibility: private)
#endif
@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public protocol StoryboardInstantiable {
	static var storyboardName: String { get }
	static var storyboardBundle: Bundle { get }
	static var storyboardIdentifier: String { get }
}

#if swift(>=5.9)
@_documentation(visibility: private)
#endif
@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension StoryboardInstantiable {
	static var storyboardBundle: Bundle? { nil }
	static var storyboardIdentifier: String? { nil }
	
	/// Initialize ViewController from Storyboard by ClassName.
	static func initFromStoryboard() -> Self? {
		let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
		return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self
	}
}
#endif
