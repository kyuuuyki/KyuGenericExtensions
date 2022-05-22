//
//  KSPPhotoGalleryCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

//  swiftlint:disable colon opening_brace

import Foundation
import UIKit

protocol KSPPhotoGalleryCollectionViewCellViewModelProtocol {
	var image: UIImage { get }
}

struct KSPPhotoGalleryCollectionViewCellViewModel:
	KSPPhotoGalleryCollectionViewCellViewModelProtocol
{
	let image: UIImage
}
