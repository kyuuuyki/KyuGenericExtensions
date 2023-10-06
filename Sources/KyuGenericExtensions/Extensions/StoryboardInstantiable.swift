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
public protocol StoryboardInstantiable {
	static var storyboardName: String { get }
	static var storyboardBundle: Bundle { get }
	static var storyboardIdentifier: String { get }
}

#if swift(>=5.9)
@_documentation(visibility: private)
#endif
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
