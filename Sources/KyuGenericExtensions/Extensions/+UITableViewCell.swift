//  swiftlint:disable:this file_name
//
//  +UITableViewCell.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

// MARK: - TableViewCell's Style
public extension UITableViewCell {
	/// Hide cell's separator.
	func hideSeparatorInset() {
		separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
	}
}
#endif
