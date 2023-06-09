protocol TutorialViewControllerProtocol: AnyObject {
	func displaySomething(viewModel: TutorialModel.Something.ViewModel)
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
	func doSomething() {
		let request = TutorialModel.Something.Request()
		interactor?.doSomething(request: request)
	}
	
	func displaySomething(viewModel: TutorialModel.Something.ViewModel) {
		self.viewModel.title = "TutorialViewController"
	}
}

private extension TutorialViewController {
	func initTutorialViewController() {
		doSomething()
	}
}
