//
//  AssemblerProtocol.swift
//  KyuGenericExtensions
//

import Foundation
import UIKit

public protocol AssemblerProtocol {
	static func assembler() -> AssemblerProtocol
	var container: ContainerProtocol { get }
	var resolver: ResolverProtocol { get }
	
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
