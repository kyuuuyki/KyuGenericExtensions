//
//  KSPInfoCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol KSPInfoCollectionViewCellViewModelProtocol {
	var title: String { get }
	var description: String? { get }
	var font: UIFont { get }
	var image: UIImage? { get }
	var titleTextColor: UIColor { get }
}
