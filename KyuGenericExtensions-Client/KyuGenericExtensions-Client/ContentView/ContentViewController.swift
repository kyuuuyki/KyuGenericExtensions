//
//  ContentViewController.swift
//  KyuGenericExtensions-Client
//

import Foundation
import SwiftUI
import UIKit

// MARK: - DISPLAY LOGIC
protocol ContentViewControllerProtocol: AnyObject {
	func displayRandomNumber(viewModel: ContentModel.RandomNumber.ViewModel)
}

// MARK: - VIEW CONTROLLER
class ContentViewController: ContentViewControllerProtocol, ObservableObject {
	weak var hostingController: UIHostingController<ContentView>?
	var interactor: ContentInteractorProtocol?
	var router: ContentRouterProtocol?
	
	@Published var viewModel = ContentViewModel()
	
	func onAppear() {
		let sheetPresentationController = hostingController?.sheetPresentationController
		let navigationController = hostingController?.navigationController
		
		// Initial Configuration
		var detents: [UISheetPresentationController.Detent] = [.large()]
		if #available(iOS 16.0, *) {
			detents = detents.filter({ $0.identifier == .large || $0.identifier == .medium })
			let fraction = UISheetPresentationController.Detent.custom { _ in
				400
			}
			detents.insert(fraction, at: 0)
		}
		let prefersGrabberVisible = detents.count > 1
		
		sheetPresentationController?.detents = detents
		sheetPresentationController?.prefersGrabberVisible = prefersGrabberVisible
		
		navigationController?.isNavigationBarHidden = true
		navigationController?.sheetPresentationController?.detents = detents
		navigationController?.sheetPresentationController?.prefersGrabberVisible = prefersGrabberVisible
		
		// ViewModel
		let navigationStackCount = navigationController?.viewControllers.count ?? 0
		viewModel.shouldDisplayBackButton = navigationStackCount > 1
		
		if navigationController != nil {
			viewModel.title = "Navigation Stack Count: \(navigationStackCount)"
			viewModel.shouldDisplayCloseButton = true
		} else {
			viewModel.title = "SwiftUI"
			viewModel.shouldDisplayCloseButton = false
		}
		
		getRandomNumber(index: nil)
	}
	
	// MARK: Actions
	func didTapOnRandomNumber(at index: Int) {
		getRandomNumber(index: index)
	}
}

// MARK: - RANDOM NUMBER
extension ContentViewController {
	func getRandomNumber(index: Int?) {
		let request = ContentModel.RandomNumber.Request(index: index)
		interactor?.getRandomNumber(request: request)
	}
	
	func displayRandomNumber(viewModel: ContentModel.RandomNumber.ViewModel) {
		self.viewModel.randomNumbers = viewModel.randomNumbers
	}
}
