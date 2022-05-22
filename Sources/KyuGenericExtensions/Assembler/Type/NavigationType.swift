//
//  NavigationType.swift
//  KyuGenericExtensions
//

import Foundation

public enum NavigationType {
	case present(sceneName: String, parameters: [String: Any]?)
	case push(sceneName: String, parameters: [String: Any]?)
	case presentAndPush(sceneName: String, parameters: [String: Any]?)
	case popToScene(sceneName: String)
	case back
	case reset
	
	case custom(navigationType: Any, sceneName: String, parameters: [String: Any]?)
}
