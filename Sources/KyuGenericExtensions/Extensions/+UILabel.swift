//  swiftlint:disable:this file_name
//
//  +UILabel.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension UILabel {
	// MARK: Set inversed-color for Text based on BackgroundColor
	/// Set inversed-color for Text based on BackgroundColor.
	func setTextColor(forBackgroundColor: UIColor) {
		if forBackgroundColor.isDarkColor {
			textColor = UIColor.white
		} else {
			textColor = UIColor.black
		}
	}
	
	// MARK: Set inversed-color for BackgroundColor based on Text
	/// Set inversed-color for BackgroundColor based on Text.
	func setBackgroundColor(forTextColor: UIColor) {
		if forTextColor.isDarkColor {
			backgroundColor = UIColor.white
		} else {
			backgroundColor = UIColor.black
		}
	}
}
#endif
