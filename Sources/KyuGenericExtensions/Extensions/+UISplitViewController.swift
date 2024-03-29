//  swiftlint:disable:this file_name
//
//  +UISplitViewController.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

#if canImport(UIKit)
import UIKit

@available(*, deprecated, message: "UIKit extensions may be deprecated and eventually removed from the package in the distant future. We recommend transitioning to SwiftUI for a more future-proof solution.") // swiftlint:disable:this line_length
public extension UISplitViewController {
	// MARK: SplitView Ratio
	/// Set SplitView's masterView and detailView ratio.
	func configure(widthFraction: CGFloat, minimumDetailSectionWidth: CGFloat = 0) {
		// SplitView
		preferredPrimaryColumnWidthFraction = widthFraction
		maximumPrimaryColumnWidth = view.frame.width - minimumDetailSectionWidth
		
		view.backgroundColor = UIColor.white
		
		// SeparatorView
		var yForSeparatorView = maximumPrimaryColumnWidth
		let yForSaparatorViewFromFraction = view.frame.width * widthFraction
		
		if yForSeparatorView > yForSaparatorViewFromFraction {
			yForSeparatorView = yForSaparatorViewFromFraction
		}
		
		let separatorView = UIView(
			frame: CGRect(
				x: yForSeparatorView + 0.25,
				y: 0,
				width: 0.5,
				height: view.frame.height
			)
		)
		separatorView.backgroundColor = UIColor.lightGray
		
		view.addSubview(separatorView)
	}
}
#endif
