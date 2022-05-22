//
//  RouterProtocol.swift
//  KyuGenericExtensions
//

import Foundation

public protocol RouterProtocol {
	func performNavigation(_ type: NavigationType, animated: Bool, completion: (() -> Void)?)
}
