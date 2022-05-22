//
//  KSPVideoCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import AVKit
import Foundation
import UIKit

protocol KSPVideoCollectionViewCellViewModelProtocol {
	var playerViewController: AVPlayerViewController? { get }
}

struct KSPVideoCollectionViewCellViewModel: KSPVideoCollectionViewCellViewModelProtocol {
	weak var playerViewController: AVPlayerViewController?
}
