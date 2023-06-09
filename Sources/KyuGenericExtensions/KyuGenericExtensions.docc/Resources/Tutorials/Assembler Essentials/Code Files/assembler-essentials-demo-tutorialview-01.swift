struct TutorialView: View {
	@ObservedObject var viewController: TutorialViewController
	
	var body: some View {
		let viewModel = $viewController.viewModel
		
		Text(viewModel.title.wrappedValue)
			.onAppear { [weak viewController] in
				viewController?.onAppear()
			}
	}
}
