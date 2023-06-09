protocol TutorialViewControllerProtocol: AnyObject {
	func displayGeneratedUniqueString(viewModel: TutorialModel.GenerateUniqueString.ViewModel)
}

class TutorialViewController: TutorialViewControllerProtocol, ObservableObject {
	weak var hostingController: UIHostingController<TutorialView>?
	var interactor: TutorialInteractorProtocol?
	var router: TutorialRouterProtocol?
	
	@Published var viewModel = TutorialViewModel()
	
	func onAppear() {
		initTutorialViewController()
	}
}

extension TutorialViewController {
	func generateUniqueString() {
		let request = TutorialModel.GenerateUniqueString.Request()
		interactor?.generateUniqueString(request: request)
	}
	
	func displayGeneratedUniqueString(viewModel: TutorialModel.GenerateUniqueString.ViewModel) {
		self.viewModel.title = viewModel.uniqueString
	}
}

private extension TutorialViewController {
	func initTutorialViewController() {
		generateUniqueString()
	}
}
