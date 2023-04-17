//  swiftlint:disable:this file_name
//
//  +UIButton.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public extension UIButton {
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
