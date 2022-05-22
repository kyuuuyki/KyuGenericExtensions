//
//  KSPActivityIndicatorCollectionViewCellViewModelProtocol.swift
//  KyuGenericExtensions
//

//  swiftlint:disable colon opening_brace

import Foundation
import UIKit

protocol KSPActivityIndicatorCollectionViewCellViewModelProtocol {
	var shouldAnimated: Bool { get }
}

struct KSPActivityIndicatorCollectionViewCellViewModel:
	KSPActivityIndicatorCollectionViewCellViewModelProtocol
{
	let shouldAnimated: Bool
}
