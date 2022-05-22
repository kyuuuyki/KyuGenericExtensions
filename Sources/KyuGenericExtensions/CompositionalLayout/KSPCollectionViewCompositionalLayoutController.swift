//
//  KSPCollectionViewCompositionalLayoutController.swift
//  KyuGenericExtensions
//

//  swiftlint:disable colon opening_brace

import Foundation
import UIKit

open class KSPCollectionViewCompositionalLayoutController:
	UIViewController,
	UICollectionViewDelegate,
	UICollectionViewDataSource
{
	public var collectionViewLayout: KSPCollectionViewCompositionalLayoutProtocol?
	public weak var parallaxableConstraint: NSLayoutConstraint?
	
	public func reloadCollectionViewData(
		collectionView: UICollectionView,
		animated: Bool,
		completion: ((Bool) -> Void)?
	) {
		guard let collectionViewLayout = collectionViewLayout else { return }
		collectionView.setCollectionViewLayout(
			collectionViewLayout,
			animated: animated,
			completion: completion
		)
	}
	
	open dynamic func numberOfSections(in collectionView: UICollectionView) -> Int {
		guard let collectionViewLayout = collectionViewLayout else { return 0 }
		return collectionViewLayout.sections.count
	}
	
	open dynamic func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		guard let collectionViewLayout = collectionViewLayout else { return 0 }
		return collectionViewLayout.sections[section].compositionalLayoutSection(
			collectionView,
			numberOfItemsInSection: section
		)
	}
	
	open dynamic func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let collectionViewLayout = collectionViewLayout else { return UICollectionViewCell() }
		return collectionViewLayout.sections[indexPath.section].compositionalLayoutSection(
			collectionView,
			cellForItemAt: indexPath
		)
	}
}
