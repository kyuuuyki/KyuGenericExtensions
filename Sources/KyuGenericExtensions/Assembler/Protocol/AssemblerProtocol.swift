//
//  AssemblerProtocol.swift
//  KyuGenericExtensions
//

#if canImport(UIKit)
import UIKit

/// The protocol defines an assembler with the capability to oversee modularization management.
public protocol AssemblerProtocol {
	/// Shared instance.
	static func assembler() -> AssemblerProtocol
	
	/// Container used for containing registered modules.
	var container: ContainerProtocol { get }
	
	/// Resolver used for resolving registered modules.
	var resolver: ResolverProtocol { get }
	
	/// Configuration point for attaching startingViewController to presenting window.
	///
	/// - Parameters:
	/// 	- window: `Window` to be attached by startingViewController.
	///
	func configure(window: UIWindow?)
	func reconfigure()
}

public extension AssemblerProtocol {
	var resolver: ResolverProtocol {
		container
	}
	
	func reconfigure() {
		container.removeAll()
		configure(window: UIApplication.shared.window)
	}
}
#endif
