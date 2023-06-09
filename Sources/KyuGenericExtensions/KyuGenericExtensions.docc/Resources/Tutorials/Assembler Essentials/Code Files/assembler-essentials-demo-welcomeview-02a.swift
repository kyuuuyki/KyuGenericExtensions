struct WelcomeView: View {
	@ObservedObject var viewController: WelcomeViewController
	
	var body: some View {
		let viewModel = $viewController.viewModel
		VStack(spacing: 8) {
			Text(viewModel.title.wrappedValue)
			
			Button { [weak viewController] in
				viewController?.didTapOnTutorialButton()
			} label: {
				Text("Tutorial")
			}
			.buttonStyle(.borderedProminent)
		}
	}
}
