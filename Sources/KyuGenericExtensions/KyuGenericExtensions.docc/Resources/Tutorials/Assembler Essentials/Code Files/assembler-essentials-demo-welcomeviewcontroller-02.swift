class WelcomeViewController: WelcomeViewControllerProtocol, ObservableObject {
	weak var hostingController: UIHostingController<WelcomeView>?
	var interactor: WelcomeInteractorProtocol?
	var router: WelcomeRouterProtocol?
	
	@Published var viewModel = WelcomeViewModel()
	
	func onAppear() {
		initWelcomeViewController()
	}
	
	func didTapOnTutorialButton() {
		router?.navigateToTutorialView()
	}
}
