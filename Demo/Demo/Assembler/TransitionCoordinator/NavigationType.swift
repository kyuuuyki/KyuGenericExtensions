//
//  NavigationType.swift
//  KyuGenericExtensions-Client
//
//  swiftlint:disable sorted_enum_cases

import Foundation

public enum NavigationType {
	// Base Navigation
	case present(sceneName: String, parameters: [String: Any])
	case push(sceneName: String, parameters: [String: Any])
	case presentAndPush(sceneName: String, parameters: [String: Any])
	case back
	case reset
	case openUrl(url: URL, parameters: [String: Any])
	case safari(url: URL)
}
