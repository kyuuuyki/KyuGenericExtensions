//
//  ContentModel.swift
//  KyuGenericExtensions-Client
//

import Foundation
import SwiftUI

enum ContentModel {
	// MARK: - RANDOM NUMBER
	enum RandomNumber {
		struct Request {
			let index: Int?
		}
		
		struct Response {
			let randomNumbers: [Int]
		}
		
		struct ViewModel {
			let randomNumbers: [Image]
		}
	}
}
