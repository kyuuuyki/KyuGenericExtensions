//
//  KSPPhotoGalleryCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public class KSPPhotoGalleryCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	public var viewModel: KSPPhotoGalleryCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellImageView: UIImageView!
	
	// MARK: LIFE CYCLE
	override public func awakeFromNib() {
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
