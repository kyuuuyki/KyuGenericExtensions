struct WelcomeView: View {
	@ObservedObject var viewController: WelcomeViewController
	
	var body: some View {
		let viewModel = $viewController.viewModel
		Text(viewModel.title.wrappedValue)
	}
}
