protocol TutorialPresenterProtocol {
	func presentGeneratedUniqueString(response: TutorialModel.GenerateUniqueString.Response)
}

struct TutorialPresenter: TutorialPresenterProtocol {
	weak var viewController: TutorialViewControllerProtocol?
}

extension TutorialPresenter {
	func presentGeneratedUniqueString(response: TutorialModel.GenerateUniqueString.Response) {
		let uniqueString = response.uniqueString
		let viewModel = TutorialModel.GenerateUniqueString.ViewModel(uniqueString: uniqueString)
		viewController?.displayGeneratedUniqueString(viewModel: viewModel)
	}
}
