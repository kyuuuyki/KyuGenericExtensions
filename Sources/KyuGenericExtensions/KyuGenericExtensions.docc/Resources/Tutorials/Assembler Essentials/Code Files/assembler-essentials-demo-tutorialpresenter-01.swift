protocol TutorialPresenterProtocol {
	func presentSomething(response: TutorialModel.Something.Response)
}

struct TutorialPresenter: TutorialPresenterProtocol {
	weak var viewController: TutorialViewControllerProtocol?
}

extension TutorialPresenter {
	func presentSomething(response: TutorialModel.Something.Response) {
		let viewModel = TutorialModel.Something.ViewModel()
		viewController?.displaySomething(viewModel: viewModel)
	}
}
