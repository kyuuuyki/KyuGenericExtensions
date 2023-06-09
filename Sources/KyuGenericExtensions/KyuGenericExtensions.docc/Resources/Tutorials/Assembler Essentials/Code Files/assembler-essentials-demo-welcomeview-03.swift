struct WelcomeView: View {
	@ObservedObject var viewController: WelcomeViewController
	
	var body: some View {
		let viewModel = $viewController.viewModel
		VStack(spacing: 24) {
			Text("🎉")
				.font(.system(size: 64))
			
			VStack(spacing: 8) {
				Text("Introducing Assembler")
					.font(.system(size: 24, weight: .bold))
					.padding(.horizontal)
				Text("Build an application utilizing modularized scenes management with Assembler")
					.multilineTextAlignment(.center)
					.padding(.horizontal)
			}
			
			Button { [weak viewController] in
				viewController?.didTapOnTutorialButton()
			} label: {
				Text("Tutorial")
			}
			.buttonStyle(.borderedProminent)
			.clipShape(Capsule())
		}
		.preferredColorScheme(.dark)
	}
}
