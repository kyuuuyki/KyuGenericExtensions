//
//  KSPInfoCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

protocol KSPInfoCollectionViewCellViewModelProtocol {
	var title: String { get }
	var description: String? { get }
	var font: UIFont { get }
	var image: UIImage? { get }
	var titleTextColor: UIColor { get }
}

struct KSPInfoCollectionViewCellViewModel: KSPInfoCollectionViewCellViewModelProtocol {
	let title: String
	let description: String?
	let font: UIFont
	let image: UIImage?
	var titleTextColor: UIColor
	
	init(title: String, description: String?, font: UIFont, image: UIImage?, url: URL?) {
		self.title = title
		self.description = description
		self.font = font
		self.image = image
		
		if url != nil {
			self.titleTextColor = .link
		} else if description != nil {
			self.titleTextColor = .secondaryLabel
		} else {
			self.titleTextColor = .label
		}
	}
}
