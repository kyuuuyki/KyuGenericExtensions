//
//  KSPCollectionViewCompositionalLayoutSectionProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPCollectionViewCompositionalLayoutSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	)
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView
}

public extension KSPCollectionViewCompositionalLayoutSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		return UICollectionReusableView()
	}
}
