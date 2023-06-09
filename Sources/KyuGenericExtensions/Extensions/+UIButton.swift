//  swiftlint:disable:this file_name
//
//  +UIButton.swift
//  KyuGenericExtensions
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIButton {
	/// Set the font of current button.
	///
	/// - Parameters:
	/// 	- font: Selected `UIFont`.
	///
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
