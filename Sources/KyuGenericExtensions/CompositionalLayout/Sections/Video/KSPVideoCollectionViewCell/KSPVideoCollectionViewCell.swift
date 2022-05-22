//
//  KSPVideoCollectionViewCell.swift
//  KyuGenericExtensions
//

import AVKit
import Foundation
import UIKit

class KSPVideoCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	var viewModel: KSPVideoCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	
	// MARK: LIFE CYCLE
	override func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		removeVideoView()
	}
}

private extension KSPVideoCollectionViewCell {
	func configureView() {
	}
	
	func updateView() {
		guard let viewModel = viewModel else { return }
		removeVideoView()
		
		if let playerViewController = viewModel.playerViewController {
			playerViewController.view.frame = bounds
			addSubview(playerViewController.view)
		}
	}
	
	func removeVideoView() {
		for subview in subviews {
			subview.removeFromSuperview()
		}
	}
}
