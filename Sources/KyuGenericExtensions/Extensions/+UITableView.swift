//  swiftlint:disable:this file_name
//
//  +UITableView.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension UITableView {
	// MARK: Configure Cells
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
	
	// MARK: Scrolling
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
