//
//  KSPTextCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPTextCollectionViewCellViewModelProtocol {
	var text: String? { get }
	var textColor: UIColor { get }
	var font: UIFont { get }
}
