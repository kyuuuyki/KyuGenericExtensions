//
//  KSPVideoCollectionViewCell.swift
//  KyuGenericExtensions
//

import AVKit
import Foundation
import UIKit

public class KSPVideoCollectionViewCell: UICollectionViewCell {
	// MARK: MODEL
	public var viewModel: KSPVideoCollectionViewCellViewModelProtocol? {
		didSet {
			updateView()
		}
	}
	
	// MARK: VIEW
	
	// MARK: LIFE CYCLE
	override public func awakeFromNib() {
		super.awakeFromNib()
		configureView()
	}
	
	override public func prepareForReuse() {
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
