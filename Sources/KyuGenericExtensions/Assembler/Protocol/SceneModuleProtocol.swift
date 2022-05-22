//
//  SceneModuleProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol SceneModuleProtocol: ModuleProtocol {
	var nibName: String { get }
	var bundle: Bundle? { get }
	
	/// Build the `ViewController` with specified parameters.
	///
	/// - Parameters:
	/// 	- parameters: User-specified key-value parameters used in `ViewController`'s build process.
	/// - Returns: `ViewController`.
	///
	func build(with parameters: [String: Any]?) -> UIViewController?
}
