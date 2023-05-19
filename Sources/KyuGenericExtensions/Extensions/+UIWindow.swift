//  swiftlint:disable:this file_name
//
//  +UIWindow.swift
//  KyuGenericExtensions
//

import Foundation
#if canImport(UIKit)
import UIKit

// MARK: - Override UserInterfaceStyle
public extension UIWindow {
	/// Override UserInterfaceStyle with specific style.
	func overrideUserInterfaceStyle(preferredStyle: UIUserInterfaceStyle?) {
		let imageView = UIImageView()
		imageView.image = UIApplication.shared.delegate!.window!?.toImage()
		imageView.frame = CGRect(origin: .zero, size: frame.size)
		addSubview(imageView)
		
		UIView.animate(withDuration: 0.35, animations: {
			self.overrideUserInterfaceStyle = preferredStyle ?? .unspecified
			imageView.alpha = 0
		}, completion: { _ in
			imageView.removeFromSuperview()
		})
	}
}
#endif
