//  swiftlint:disable:this file_name
//
//  +UIButton.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension UIButton {
	/// Set the font of current button.
	///
	/// - Parameters:
	///   - font: Selected `UIFont`.
	@available(iOS 15.0, *)
	func setTitleFont(_ font: UIFont) {
		let transformer = UIConfigurationTextAttributesTransformer { incoming in
			var outgoing = incoming
			outgoing.font = font
			return outgoing
		}
		configuration?.titleTextAttributesTransformer = transformer
	}
}
#endif
