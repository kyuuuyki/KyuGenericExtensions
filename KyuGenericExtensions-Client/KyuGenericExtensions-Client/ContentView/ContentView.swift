//
//  ContentView.swift
//  KyuGenericExtensions-Client
//

import KyuGenericExtensions
import SwiftUI
import UIKit

// MARK: - VIEW
struct ContentView: View {
	@ObservedObject var viewController: ContentViewController
	
	@State var cellHeight: CGFloat = 64
	
	var body: some View {
		let viewModel = $viewController.viewModel
		
		NavigationView {
			Form {
				Section(header: Text("Interaction")) {
					VStack {
						Spacer()
						ScrollView(.horizontal, showsIndicators: false) {
							HStack {
								Spacer()
								ForEach(0..<viewModel.randomNumbers.wrappedValue.count) { index in
									let image = viewModel.randomNumbers.wrappedValue[index]
									Button { [weak viewController] in
										viewController?.didTapOnRandomNumber(at: index)
									} label: {
										image
											.resizable()
											.symbolRenderingMode(.palette)
											.foregroundStyle(.white, .blue)
									}
									.frame(width: cellHeight, height: cellHeight)
								}
								Spacer()
							}
						}
						Spacer()
					}
					.listRowInsets(EdgeInsets())
				}
				Section(header: Text("Navigation")) {
					VStack {
						HStack {
							Button("Present") { [weak viewController] in
								viewController?.router?.presentContentView()
							}
							.font(.headline)
							.buttonStyle(.borderedProminent)
							.clipShape(Capsule())
							Button("Present And Push") { [weak viewController] in
								viewController?.router?.presentAndPushContentView()
							}
							.font(.headline)
							.buttonStyle(.borderedProminent)
							.clipShape(Capsule())
							Spacer()
						}
						HStack {
							Button("Push") { [weak viewController] in
								viewController?.router?.pushContentView()
							}
							.font(.headline)
							.buttonStyle(.borderedProminent)
							.clipShape(Capsule())
							Button("Back") { [weak viewController] in
								viewController?.router?.back()
							}
							.font(.headline)
							.buttonStyle(.borderedProminent)
							.clipShape(Capsule())
							Spacer()
						}
						HStack {
							Button("Reset") { [weak viewController] in
								viewController?.router?.reset()
							}
							.font(.headline)
							.buttonStyle(.borderedProminent)
							.clipShape(Capsule())
							Spacer()
						}
					}
				}
			}
			.navigationTitle(viewModel.title.wrappedValue)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					if viewModel.shouldDisplayBackButton.wrappedValue {
						Button { [weak viewController] in
							viewController?.router?.back()
						} label: {
							Image(systemName: "chevron.backward.circle.fill")
								.resizable()
								.font(.title2)
								.symbolRenderingMode(.hierarchical)
						}
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					if viewModel.shouldDisplayCloseButton.wrappedValue {
						Button { [weak viewController] in
							viewController?.hostingController?.navigationController?.dismiss(animated: true)
						} label: {
							Image(systemName: "xmark.circle.fill")
								.resizable()
								.font(.title2)
								.symbolRenderingMode(.hierarchical)
						}
					}
				}
			}
		}
		.onAppear { [weak viewController] in
			viewController?.onAppear()
		}
	}
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let viewController = ContentViewController()
		let viewModel = ContentViewModel(
			title: "ContentView",
			randomNumbers: [],
			shouldDisplayBackButton: true,
			shouldDisplayCloseButton: true
		)
		viewController.viewModel = viewModel
		return ContentView(viewController: viewController)
	}
}

// MARK: - VIEW MODEL
struct ContentViewModel {
	var title: String = ""
	var randomNumbers: [Image] = []
	
	var shouldDisplayBackButton = false
	var shouldDisplayCloseButton = false
}
