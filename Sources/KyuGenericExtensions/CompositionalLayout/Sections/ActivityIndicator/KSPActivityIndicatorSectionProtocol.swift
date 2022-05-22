//
//  KSPActivityIndicatorSectionProtocol.swift
//  KyuGenericExtensions
//

//  swiftlint:disable colon opening_brace

import Foundation
import UIKit

public protocol KSPActivityIndicatorSectionProtocol:
	KSPCollectionViewCompositionalLayoutSectionProtocol
{
	var shouldAnimated: Bool { get }
}

public extension KSPActivityIndicatorSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(KSPActivityIndicatorCollectionViewCell.self, bundle: .module)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return 1
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			KSPActivityIndicatorCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		let viewModel = KSPActivityIndicatorCollectionViewCellViewModel(
			shouldAnimated: shouldAnimated
		)
		cell.viewModel = viewModel
		
		return cell
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(80)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
}
