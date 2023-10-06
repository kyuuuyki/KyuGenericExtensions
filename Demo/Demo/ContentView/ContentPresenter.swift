//
//  ContentPresenter.swift
//  KyuGenericExtensions-Client
//

import Foundation
import SwiftUI
import UIKit

// MARK: - PRESENTATION LOGIC
protocol ContentPresenterProtocol {
	func presentRandomNumber(response: ContentModel.RandomNumber.Response)
}

// MARK: - PRESENTER
struct ContentPresenter: ContentPresenterProtocol {
	weak var viewController: ContentViewControllerProtocol?
}

// MARK: - RANDOM NUMBER
extension ContentPresenter {
	func presentRandomNumber(response: ContentModel.RandomNumber.Response) {
		let randomNumbers = response.randomNumbers.compactMap { randomNumber in
			Image(systemName: "\(randomNumber).circle.fill")
		}
		let viewModel = ContentModel.RandomNumber.ViewModel(randomNumbers: randomNumbers)
		viewController?.displayRandomNumber(viewModel: viewModel)
	}
}
