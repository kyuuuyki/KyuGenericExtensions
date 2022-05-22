//
//  KSPPhotoSectionProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPPhotoSectionProtocol: KSPCollectionViewCompositionalLayoutSectionProtocol {
	var image: UIImage { get }
}

public extension KSPPhotoSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(KSPPhotoGalleryCollectionViewCell.self, bundle: .module)
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
			KSPPhotoGalleryCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		let viewModel = KSPPhotoGalleryCollectionViewCellViewModel(image: image)
		cell.viewModel = viewModel
		return cell
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		layoutForSectionAt sectionIndex: Int
	) -> NSCollectionLayoutSection {
		let height = image.size.height * UIScreen.main.bounds.width / image.size.width
		
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .absolute(height)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: itemSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		return section
	}
}
