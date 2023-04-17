//
//  ContentWorker.swift
//  KyuGenericExtensions-Client
//

import Foundation

// MARK: - WORKER LOGIC
protocol ContentWorkerProtocol {
	func doSomeWork()
}

// MARK: - WORKER
struct ContentWorker: ContentWorkerProtocol {
	// MARK: GET - SOMETHING
	func doSomeWork() {
	}
}
