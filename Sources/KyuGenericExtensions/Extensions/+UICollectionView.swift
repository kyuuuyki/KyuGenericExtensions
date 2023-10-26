//  swiftlint:disable:this file_name
//
//  +UICollectionView.swift
//  KyuGenericExtensions
//
//  swiftlint:disable line_length

#if canImport(UIKit)
import UIKit

// MARK: - Configure Cells
public extension UICollectionView {
	/// Registers a class for use in creating new collection view cells.
	///
	/// - Parameters:
	/// 	- cell: The reusable cell class.
	/// 	- bundle: The bundle in which to search for the nib file. If you specify nil, this method looks for the nib file in the main bundle.
	/// 	- identifier: The reuse identifier to associate with the specified nib file.
	///
	func register<T: UICollectionViewCell>(
		_ cell: T.Type,
		bundle: Bundle? = nil,
		forCellWithReuseIdentifier identifier: String? = nil
	) {
		let resolvedReuseIdentifier = identifier ?? String(describing: cell)
		let resolvedBundle = bundle ?? Bundle(for: cell)
		
		if resolvedBundle.path(forResource: String(describing: cell), ofType: "nib") != nil {
			register(
				UINib(nibName: String(describing: cell), bundle: resolvedBundle),
				forCellWithReuseIdentifier: resolvedReuseIdentifier
			)
		} else {
			register(cell, forCellWithReuseIdentifier: resolvedReuseIdentifier)
		}
	}
	
	/// Dequeues a reusable cell object located by its identifier.
	///
	/// - Parameters:
	/// 	- cell: The reusable cell class.
	/// 	- identifier: The reuse identifier associated with the specified cell class.
	/// 	- indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
	///
	/// - Returns: A valid `UICollectionViewCell` object. `Nil` if the specify cell cannot dequeue from collection view or cast into the valid cell type.
	///
	func dequeueReusableCell<T: UICollectionViewCell>(
		_ cell: T.Type,
		withReuseIdentifier identifier: String? = nil,
		for indexPath: IndexPath
	) -> T? {
		let resolvedReuseIdentifier = identifier ?? String(describing: cell)
		return dequeueReusableCell(
			withReuseIdentifier: resolvedReuseIdentifier,
			for: indexPath
		) as? T
	}
	
	/// Registers a class for use in creating new collection reusable view.
	///
	/// - Parameters:
	/// 	- supplementaryView: The reusable view class.
	/// 	- elementKind: The kind of this reusable view.
	/// 	- identifier: The reuse identifier to associate with the specified nib file.
	///
	func register<T: UICollectionReusableView>(
		_ supplementaryView: T.Type,
		forSupplementaryViewOfKind elementKind: String? = nil,
		withReuseIdentifier identifier: String? = nil
	) {
		let resolvedElementKind = elementKind ?? String(describing: supplementaryView)
		let resolvedReuseIdentifier = identifier ?? String(describing: supplementaryView)
		register(
			supplementaryView,
			forSupplementaryViewOfKind: resolvedElementKind,
			withReuseIdentifier: resolvedReuseIdentifier
		)
	}
	
	/// Dequeues a reusable view object located by its identifier.
	///
	/// - Parameters:
	/// 	- supplementaryView: The reusable view class.
	/// 	- elementKind: The kind of this reusable view.
	/// 	- identifier: The reuse identifier to associate with the specified nib file.
	/// 	- indexPath: The index path specifying the location of the view. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the view's position in the collection view.
	///
	/// - Returns: A valid `UICollectionReusableView` object. `Nil` if the specify view cannot dequeue from collection view or cast into the valid view type.
	///
	func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
		_ supplementaryView: T.Type,
		ofKind elementKind: String? = nil,
		withReuseIdentifier identifier: String? = nil,
		for indexPath: IndexPath
	) -> T? {
		let resolvedElementKind = elementKind ?? String(describing: supplementaryView)
		let resolvedReuseIdentifier = identifier ?? String(describing: supplementaryView)
		return dequeueReusableSupplementaryView(
			ofKind: resolvedElementKind,
			withReuseIdentifier: resolvedReuseIdentifier,
			for: indexPath
		) as? T
	}
}
#endif
