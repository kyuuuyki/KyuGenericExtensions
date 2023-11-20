//  swiftlint:disable:this file_name
//
//  +UITableViewCell.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension UITableViewCell {
	// MARK: TableViewCell's Style
	/// Hide cell's separator.
	func hideSeparatorInset() {
		separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
	}
}
#endif
