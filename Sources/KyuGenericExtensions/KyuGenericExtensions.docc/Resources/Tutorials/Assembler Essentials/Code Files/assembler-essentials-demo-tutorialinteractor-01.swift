protocol TutorialInteractorProtocol {
	func doSomething(request: TutorialModel.Something.Request)
}

class TutorialInteractor: TutorialInteractorProtocol {
	var presenter: TutorialPresenterProtocol?
	var worker: TutorialWorkerProtocol?
	
	init(
		presenter: TutorialPresenterProtocol?,
		worker: TutorialWorkerProtocol?
	) {
		self.presenter = presenter
		self.worker = worker
	}
}

extension TutorialInteractor {
	func doSomething(request: TutorialModel.Something.Request) {
		worker?.doSomeWork()
		
		let response = TutorialModel.Something.Response()
		presenter?.presentSomething(response: response)
	}
}
