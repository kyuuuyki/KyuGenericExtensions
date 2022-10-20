//
//  KSPActivityIndicatorCollectionViewCell.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public class KSPActivityIndicatorCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	public var viewModel: KSPActivityIndicatorCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	@IBOutlet private weak var cellActivityIndicator: UIActivityIndicatorView!
	
	// MARK: LIFE CYCLE
	override public func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
}

private extension KSPActivityIndicatorCollectionViewCell {
	func configureView() {
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		
		if viewModel.shouldAnimated {
			cellActivityIndicator.startAnimating()
		} else {
			cellActivityIndicator.stopAnimating()
		}
	}
}
