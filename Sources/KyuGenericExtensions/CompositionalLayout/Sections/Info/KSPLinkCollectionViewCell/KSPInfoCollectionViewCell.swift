//
//  KSPInfoCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public class KSPInfoCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	public var viewModel: KSPInfoCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellTitleLabel: UILabel!
	@IBOutlet private weak var cellDescriptionLabel: UILabel!
	@IBOutlet private weak var cellImageView: UIImageView!
	@IBOutlet private weak var cellImageContainerView: UIView!
	@IBOutlet private weak var cellSeparatorView: UIView!
	
	// MARK: LIFE CYCLE
	override public func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension KSPInfoCollectionViewCell {
	func configureView() {
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellTitleLabel.text = viewModel.title
		cellTitleLabel.textColor = viewModel.titleTextColor
		cellTitleLabel.font = viewModel.font
		cellDescriptionLabel.text = viewModel.description
		cellDescriptionLabel.isHidden = viewModel.description == nil
		cellDescriptionLabel.font = viewModel.font
		cellImageView.image = viewModel.image
		cellImageView.tintColor = viewModel.titleTextColor
		cellImageContainerView.isHidden = viewModel.image == nil
	}
}
