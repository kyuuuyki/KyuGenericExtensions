//  swiftlint:disable:this file_name
//
//  +UIViewController.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

// MARK: - Hide keyboard when tapping outside input field
public extension UIViewController {
	/// Make ViewController automatically end editing when user tapped outside input field.
	func hideKeyboardWhenTappedAround() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		tapGesture.cancelsTouchesInView = false
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc
	private func hideKeyboard() {
		view.endEditing(true)
	}
}

// MARK: - Alert handling
public extension UIViewController {
	/// Display AlertView with activity indicator.
	func displayAlertWithActivityIndicator(loadingText: String? = nil) {
		let alert = UIAlertController(
			title: nil,
			message: loadingText ?? "Processing...",
			preferredStyle: .alert
		)
		
		let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
		indicator.hidesWhenStopped = true
		indicator.isUserInteractionEnabled = false
		indicator.startAnimating()
		
		alert.view.addSubview(indicator)
		
		present(alert, animated: true, completion: nil)
	}
	
	/// Display AlertView with default error style.
	func displayAlertWithErrorStyle(
		title: String? = nil,
		message: String? = nil,
		confirmButtonTitle: String? = nil,
		handler: (() -> Void)? = nil
	) {
		let alert = UIAlertController(
			title: title ?? "Oops!",
			message: message ?? "Don't worry, it's not your fault.",
			preferredStyle: .alert
		)
		
		let action = UIAlertAction(
			title: confirmButtonTitle ?? "Oh, Okay.",
			style: .default
		) { _ in
			handler?()
		}
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
	}
	
	/// Dismiss presenting AlertView.
	func dismissAlertController(completion: (() -> Void)?) {
		if let topController = UIApplication.topViewController() {
			if topController is UIAlertController {
				topController.dismiss(animated: true, completion: completion)
			}
		}
	}
}
