//  swiftlint:disable:this file_name
//
//  +UICollectionView.swift
//  KyuGenericExtensions
//

//  swiftlint:disable line_length

import Foundation
import UIKit

// MARK: - Configure Cells
public extension UICollectionView {
	/**
	 Registers a class for use in creating new collection view cells.
	 - parameter cell: The reusable cell class.
	 - parameter bundle: The bundle in which to search for the nib file. If you specify nil, this method looks for the nib file in the main bundle.
	 - parameter reuseIdentifier: The reuse identifier to associate with the specified nib file. This parameter must not be nil and must not be an empty string.
	 */
	func register<T: UICollectionViewCell>(
		_ cell: T.Type,
		bundle: Bundle? = nil,
		forCellWithReuseIdentifier reuseIdentifier: String? = nil
	) {
		let resolvedReuseIdentifier = reuseIdentifier ?? String(describing: cell)
		let resolvedBundle = bundle ?? Bundle(for: cell)
		
		if resolvedBundle.path(forResource: resolvedReuseIdentifier, ofType: "nib") != nil {
			register(
				UINib(nibName: resolvedReuseIdentifier, bundle: resolvedBundle),
				forCellWithReuseIdentifier: resolvedReuseIdentifier
			)
		} else {
			register(cell, forCellWithReuseIdentifier: resolvedReuseIdentifier)
		}
	}
	
	/**
	 Dequeues a reusable cell object located by its identifier.
	 - parameter cell: The reusable cell class.
	 - parameter indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
	 - returns: A valid `UICollectionReusableView` object. `Nil` if the specify cell cannot dequeue from collection view or cast into the valid cell type.
	 */
	func dequeueReusableCell<T: UICollectionViewCell>(
		_ cell: T.Type,
		indexPath: IndexPath
	) -> T? {
		return dequeueReusableCell(
			withReuseIdentifier: String(describing: cell),
			for: indexPath
		) as? T
	}
}

// MARK: - Compositional Layout
public extension UICollectionView {
	/**
	 Changes the collection view’s layout and notifies you when the animations complete.
	 - parameter compositionalLayout: The new layout object for the collection view.
	 - parameter animated: Specify `true` if you want to animate changes from the current layout to the new layout specified by the layout parameter. Specify false to make the change without animations.
	 - parameter completion: The block that is executed when the layout transition finishes or is aborted by the user.
	 */
	func setCollectionViewLayout(
		_ compositionalLayout: KSPCollectionViewCompositionalLayoutProtocol,
		animated: Bool,
		completion: ((Bool) -> Void)?
	) {
		let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
			guard let self = self else { return nil }
			let section = compositionalLayout.sections[sectionIndex]
			section.compositionalLayoutSection(self, prepareForSectionAt: sectionIndex)
			return section.compositionalLayoutSection(
				self,
				layoutForSectionAt: sectionIndex
			)
		}
		setCollectionViewLayout(layout, animated: animated, completion: completion)
		reloadData()
	}
}
