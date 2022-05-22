//
//  KSPPhotoGalleryCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

class KSPPhotoGalleryCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: KSPPhotoGalleryCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension KSPPhotoGalleryCollectionViewCell {
	func configureView() {
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellImageView.image = viewModel.image
	}
}
