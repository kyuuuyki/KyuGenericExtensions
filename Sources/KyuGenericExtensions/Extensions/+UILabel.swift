//  swiftlint:disable:this file_name
//
//  +UILabel.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

// MARK: - Set inversed-color for Text based on BackgroundColor
public extension UILabel {
	/// Set inversed-color for Text based on BackgroundColor.
	func setTextColor(forBackgroundColor: UIColor) {
		if forBackgroundColor.isDarkColor {
			textColor = UIColor.white
		} else {
			textColor = UIColor.black
		}
	}
}

// MARK: - Set inversed-color for BackgroundColor based on Text
public extension UILabel {
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
