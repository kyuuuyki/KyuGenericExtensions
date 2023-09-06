//  swiftlint:disable:this file_name
//
//  +UITableView.swift
//  KyuGenericExtensions
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: - Configure Cells
public extension UITableView {
	/// Register reusable cells by ClassName.
	func register<T: UITableViewCell>(_ cell: T.Type) {
		register(
			UINib(
				nibName: String(describing: cell),
				bundle: Bundle(for: cell)
			),
			forCellReuseIdentifier: String(describing: cell)
		)
	}
	
	/// Dequeue reusable cells by ClassName.
	func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type) -> T? {
		dequeueReusableCell(withIdentifier: String(describing: cell)) as? T
	}
	
	/// Dequeue reusable cells by ClassName.
	func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T? {
		dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as? T
	}
}

// MARK: - Scrolling
public extension UITableView {
	/// Scroll to last UITableViewCell.
	func scrollToBottom() {
		let section = numberOfSections - 1
		let row = numberOfRows(inSection: section) - 1
		let indexPath = IndexPath(row: row, section: section)
		
		DispatchQueue.main.async {
			self.scrollToRow(at: indexPath, at: .bottom, animated: true)
		}
	}
}
#endif
