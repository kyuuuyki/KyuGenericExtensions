//
//  AssemblerProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol AssemblerProtocol {
	/// `Assembler`'s shared instance.
	static func assembler() -> AssemblerProtocol
	
	/// `Assembler`'s container used for containing registered modules.
	var container: ContainerProtocol { get }
	
	/// `Assembler`'s resolver used for resolving registered modules.
	var resolver: ResolverProtocol { get }
	
	/// Attach `Assembler` to selected `Window`.
	///
	/// - Parameters:
	/// 	- window: `Window` to be attached by `Assembler`.
	///
	func configure(window: UIWindow?)
	func reconfigure()
}

public extension AssemblerProtocol {
	var resolver: ResolverProtocol {
		return container
	}
	
	func reconfigure() {
		container.removeAll()
		configure(window: UIApplication.shared.window)
	}
}
