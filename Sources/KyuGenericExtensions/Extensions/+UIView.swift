//  swiftlint:disable:this file_name
//
//  +UIView.swift
//  KyuGenericExtensions
//
//  swiftlint:disable no_magic_numbers

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: - Initialization
public extension UIView {
	private class func initFromNib<T: UIView>(_ viewClass: T.Type, bundle: Bundle) -> T? {
		bundle.loadNibNamed(
			String(describing: viewClass),
			owner: nil,
			options: nil
		)?.first as? T
	}
	
	/// Initialize view by ClassName.
	class func initFromNib(bundle: Bundle? = nil) -> Self? {
		initFromNib(self, bundle: bundle ?? .main)
	}
}

// MARK: - Round Corner
public extension UIView {
	/// Set corners for View.
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		clipsToBounds = true
		layer.cornerRadius = radius
		layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
	}
	
	/// Set circle for View.
	func circle() {
		layer.cornerRadius = frame.height / 2
	}
}

// MARK: - View to Image
public extension UIView {
	/// Get image from View.
	func toImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: bounds.size)
		return renderer.image { _ in
			drawHierarchy(in: bounds, afterScreenUpdates: true)
		}
	}
}

// MARK: - Add Blurred Background Image
public extension UIView {
	/// Add Blur Background.
	func insertBlurredBackground(withStyle: UIBlurEffect.Style? = nil) {
		// Back View
		let blurEffect = UIBlurEffect(style: withStyle ?? .systemChromeMaterial)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		addSubview(blurEffectView)
		sendSubviewToBack(blurEffectView)
		clipsToBounds = true
	}
}

// MARK: - Gradient layer
public extension UIView {
	/// Apply Gradient layer on View.
	func applyGradient(colors: [UIColor]) {
		applyGradient(colors: colors, locations: [])
	}
	
	/// Apply Gradient layer on View with specific location.
	func applyGradient(colors: [UIColor], locations: [NSNumber]) {
		// swiftlint:disable:previous legacy_objc_type
		removeGradient()
		
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = colors.map { $0.cgColor }
		gradient.locations = locations
		self.layer.insertSublayer(gradient, at: 0)
	}
	
	/// Remove Gradient layer on View with specific location.
	func removeGradient() {
		for sublayer in layer.sublayers ?? [] where sublayer is CAGradientLayer {
			sublayer.removeFromSuperlayer()
		}
	}
}
#endif
