//
//  KSPTextSectionProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPTextSectionProtocol: KSPCollectionViewCompositionalLayoutSectionProtocol {
	var text: String? { get }
	var textColor: UIColor { get }
	var font: UIFont { get }
}

public extension KSPTextSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(KSPTextCollectionViewCell.self, bundle: .module)
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
			KSPTextCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		let viewModel = KSPTextCollectionViewCellViewModel(
			text: text,
			textColor: textColor,
			font: font
		)
		cell.viewModel = viewModel
		cell.sizeToFit()
		return cell
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .estimated(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets.leading = 16
		section.contentInsets.trailing = 16
		section.contentInsets.top = 8
		section.contentInsets.bottom = 8
		return section
	}
}
