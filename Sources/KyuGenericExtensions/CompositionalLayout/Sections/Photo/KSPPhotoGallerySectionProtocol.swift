//
//  KSPPhotoGallerySectionProtocol.swift
//  KyuGenericExtensions
//

//  swiftlint:disable colon opening_brace

import Foundation
import UIKit

public protocol KSPPhotoGallerySectionProtocol:
	KSPCollectionViewCompositionalLayoutSectionProtocol
{
	var images: [UIImage] { get }
	var imageRatio: CGFloat { get }
}

public extension KSPPhotoGallerySectionProtocol {
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
		return images.count
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
		
		let viewModel = KSPPhotoGalleryCollectionViewCellViewModel(image: images[indexPath.item])
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
			heightDimension: .fractionalWidth(1 / imageRatio)
		)
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: groupSize,
			subitems: [item]
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .paging
		return section
	}
}
