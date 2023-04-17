//
//  ContentInteractor.swift
//  KyuGenericExtensions-Client
//

import Foundation

// MARK: - BUSINESS LOGIC
protocol ContentInteractorProtocol {
	func getRandomNumber(request: ContentModel.RandomNumber.Request)
}

// MARK: - INTERACTOR
class ContentInteractor: ContentInteractorProtocol {
	var presenter: ContentPresenterProtocol?
	var worker: ContentWorkerProtocol?
	
	init(presenter: ContentPresenterProtocol? = nil, worker: ContentWorkerProtocol? = nil) {
		self.presenter = presenter
		self.worker = worker
	}
	
	private var randomNumbers = [Int]()
}

// MARK: - RANDOM NUMBER
extension ContentInteractor {
	func getRandomNumber(request: ContentModel.RandomNumber.Request) {
		if let index = request.index {
			randomNumbers[index] = .random(in: (1...50))
		} else {
			randomNumbers = (0..<10).compactMap({ _ in
				return 0
			})
		}
		
		let response = ContentModel.RandomNumber.Response(randomNumbers: randomNumbers)
		presenter?.presentRandomNumber(response: response)
	}
}
