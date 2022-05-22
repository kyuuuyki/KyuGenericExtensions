//
//  KSPTextCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

class KSPTextCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: KSPTextCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellTextLabel: UILabel!
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension KSPTextCollectionViewCell {
	func configureView() {
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		cellTextLabel.text = viewModel.text
		cellTextLabel.textColor = viewModel.textColor
		cellTextLabel.font = viewModel.font
	}
}
