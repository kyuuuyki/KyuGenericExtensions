protocol TutorialInteractorProtocol {
	func generateUniqueString(request: TutorialModel.GenerateUniqueString.Request)
}

class TutorialInteractor: TutorialInteractorProtocol {
	var presenter: TutorialPresenterProtocol?
	var worker: TutorialWorkerProtocol?
	
	var dataProcessingService: DataProcessingServiceProtocol?
	
	init(
		presenter: TutorialPresenterProtocol?,
		worker: TutorialWorkerProtocol?,
		dataProcessingService: DataProcessingServiceProtocol?
	) {
		self.presenter = presenter
		self.worker = worker
		self.dataProcessingService = dataProcessingService
	}
}

extension TutorialInteractor {
	func generateUniqueString(request: TutorialModel.GenerateUniqueString.Request) {
		let uniqueString = dataProcessingService?.generateUniqueString() ?? "Unknown"
		
		let response = TutorialModel.GenerateUniqueString.Response(uniqueString: uniqueString)
		presenter?.presentGeneratedUniqueString(response: response)
	}
}
