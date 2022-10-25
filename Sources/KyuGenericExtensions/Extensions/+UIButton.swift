//  swiftlint:disable:this file_name
//
//  +UIButton.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public extension UIButton {
	func setTitleFont(_ font: UIFont) {
		let transformer = UIConfigurationTextAttributesTransformer { incoming in
			var outgoing = incoming
			outgoing.font = font
			return outgoing
		}
		configuration?.titleTextAttributesTransformer = transformer
	}
}
