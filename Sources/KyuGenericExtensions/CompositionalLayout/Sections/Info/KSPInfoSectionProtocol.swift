//
//  KSPInfoSectionProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPInfoSectionContentProtocol {
	var title: String { get }
	var description: String? { get }
	var font: UIFont { get }
	var image: UIImage? { get }
	var url: URL? { get }
}

public protocol KSPInfoSectionProtocol: KSPCollectionViewCompositionalLayoutSectionProtocol {
	var contents: [KSPInfoSectionContentProtocol] { get }
}

public extension KSPInfoSectionProtocol {
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		prepareForSectionAt sectionIndex: Int
	) {
		collectionView.register(KSPInfoCollectionViewCell.self, bundle: .module)
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		return contents.count
	}
	
	func compositionalLayoutSection(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			KSPInfoCollectionViewCell.self,
			indexPath: indexPath
		) else {
			return UICollectionViewCell()
		}
		
		let content = contents[indexPath.item]
		let viewModel = KSPInfoCollectionViewCellViewModel(
			title: content.title,
			description: content.description,
			font: content.font,
			image: content.image,
			url: content.url
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
			heightDimension: .absolute(44)
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
