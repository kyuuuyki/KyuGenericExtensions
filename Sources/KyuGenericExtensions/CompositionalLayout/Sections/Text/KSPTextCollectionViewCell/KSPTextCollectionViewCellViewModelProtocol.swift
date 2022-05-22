//
//  KSPTextCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

protocol KSPTextCollectionViewCellViewModelProtocol {
	var text: String? { get }
	var textColor: UIColor { get }
	var font: UIFont { get }
}

struct KSPTextCollectionViewCellViewModel: KSPTextCollectionViewCellViewModelProtocol {
	let text: String?
	let textColor: UIColor
	let font: UIFont
}
