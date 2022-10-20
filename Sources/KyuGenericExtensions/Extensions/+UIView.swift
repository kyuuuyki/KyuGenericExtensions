//  swiftlint:disable:this file_name
//
//  +UIView.swift
//  KyuGenericExtensions
//

//  swiftlint:disable function_parameter_count cyclomatic_complexity

import Foundation
import UIKit

// MARK: - Initialization
public extension UIView {
	private class func initFromNib<T: UIView>(_ viewClass: T.Type, bundle: Bundle) -> T? {
		return bundle.loadNibNamed(
			String(describing: viewClass),
			owner: nil,
			options: nil
		)?.first as? T
	}
	
	/// Initialize view by ClassName.
	class func initFromNib(bundle: Bundle? = nil) -> Self? {
		return initFromNib(self, bundle: bundle ?? .main)
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
		let image = renderer.image { _ in
			drawHierarchy(in: bounds, afterScreenUpdates: true)
		}
		
		return image
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

// MARK: - SLIDE VIEW IN OR OUT
public extension UIView {
	/// Animate slide in from edge.
	func slideIn(
		from edge: UIRectEdge,
		withDuration: Double,
		delay: Double = 0,
		usingSpringWithDamping: CGFloat = 1,
		initialSpringVelocity: CGFloat = 1,
		options: AnimationOptions = [],
		animation: @escaping () -> Void = {},
		completion: @escaping () -> Void = {}
	) {
		animate(
			isSlideIn: true,
			from: edge,
			withDuration: withDuration,
			delay: delay,
			usingSpringWithDamping: usingSpringWithDamping,
			initialSpringVelocity: initialSpringVelocity,
			options: options,
			animation: animation,
			completion: completion
		)
	}
	
	/// Animate slide out to edge.
	func slideOut(
		to edge: UIRectEdge,
		withDuration: Double,
		delay: Double = 0,
		usingSpringWithDamping: CGFloat = 1,
		initialSpringVelocity: CGFloat = 1,
		options: AnimationOptions = [],
		animation: @escaping () -> Void = {},
		completion: @escaping () -> Void = {}
	) {
		animate(
			isSlideIn: false,
			from: edge,
			withDuration: withDuration,
			delay: delay,
			usingSpringWithDamping: usingSpringWithDamping,
			initialSpringVelocity: initialSpringVelocity,
			options: options,
			animation: animation,
			completion: completion
		)
	}
	
	private func animate(
		isSlideIn: Bool,
		from edge: UIRectEdge,
		withDuration: Double,
		delay: Double,
		usingSpringWithDamping: CGFloat,
		initialSpringVelocity: CGFloat,
		options: AnimationOptions,
		animation: @escaping () -> Void,
		completion: @escaping () -> Void
	) {
		let window = UIApplication.shared.window
		let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		
		// Does not support all direction
		if edge == .all {
			return
		}
		
		// Starting Point
		var startingX: CGFloat = 0
		var startingY: CGFloat = 0
		
		if isSlideIn {
			switch edge {
			case .top:
				startingY = 0 - frame.size.height
				
			case .left:
				startingX = 0 - frame.size.width
				
			case .right:
				startingX = UIScreen.main.bounds.width
				
			case .bottom:
				startingY = UIScreen.main.bounds.height
				
			default:
				break
			}
		} else {
			switch edge {
			case .top:
				startingY = 0 + statusBarHeight
				
			case .left:
				startingX = 0
				
			case .right:
				startingX = UIScreen.main.bounds.width - frame.size.width
				
			case .bottom:
				startingY = UIScreen.main.bounds.height - frame.size.height
				
			default:
				break
			}
		}
		
		isHidden = false
		alpha = 1
		
		var distanceToStartingX = startingX - frame.origin.x
		var distanceToStartingY = startingY - frame.origin.y
		
		switch edge {
		case .top, .bottom:
			distanceToStartingX = 0
			
		case .left, .right:
			distanceToStartingY = 0
			
		default:
			break
		}
		
		transform = transform.translatedBy(x: distanceToStartingX, y: distanceToStartingY)
		
		// Distance to Move
		var distanceToMoveX: CGFloat = 0
		var distanceToMoveY: CGFloat = 0
		
		switch edge {
		case .top:
			distanceToMoveY = frame.size.height + statusBarHeight
			
		case .left:
			distanceToMoveX = frame.size.width
			
		case .right:
			distanceToMoveX = -frame.size.width
			
		case .bottom:
			distanceToMoveY = -frame.size.height
			
		default:
			break
		}
		
		// If sliding out, reverse direction of movement
		if !isSlideIn {
			distanceToMoveX = -distanceToMoveX
			distanceToMoveY = -distanceToMoveY
		}
		
		// Animate
		UIView.animate(
			withDuration: withDuration,
			delay: delay,
			usingSpringWithDamping: usingSpringWithDamping,
			initialSpringVelocity: initialSpringVelocity,
			options: options,
			animations: {
				self.transform = self.transform.translatedBy(x: distanceToMoveX, y: distanceToMoveY)
				animation()
			}
		) { _ in
			completion()
		}
	}
}

// MARK: - Gradient layer
public extension UIView {
	/// Apply Gradient layer on View.
	func applyGradient(colors: [UIColor]) {
		applyGradient(colors: colors, locations: nil)
	}
	
	/// Apply Gradient layer on View with specific location.
	func applyGradient(colors: [UIColor], locations: [NSNumber]?) {
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
