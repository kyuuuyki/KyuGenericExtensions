//  swiftlint:disable:this file_name
//
//  +UICollectionView.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

// MARK: - Configure Cells
public extension UICollectionView {
	/// Register reusable cells by ClassName.
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
	
	/// Dequeue reusable cells by ClassName.
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
