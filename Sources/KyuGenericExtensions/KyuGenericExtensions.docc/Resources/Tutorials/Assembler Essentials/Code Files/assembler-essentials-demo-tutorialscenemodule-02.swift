public struct TutorialSceneModule: SceneModuleProtocol {
	public static var moduleName: String = "AssemblerDemo.TutorialSceneModule"
	
	public func build(resolver: ResolverProtocol, parameters: [String: Any]) throws -> UIViewController {
		guard let transitionCoordinator = resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: "AssemblerDemo.TransitionCoordinator"
		) else {
			return nil
		}
		
		guard let dataProcessingService = resolver.resolve(
			DataProcessingServiceProtocol.self,
			name: "AssemblerDemo.DataProcessingService"
		) else {
			return nil
		}
		
		let viewController = TutorialViewController()
		
		let worker = TutorialWorker()
		let presenter = TutorialPresenter(viewController: viewController)
		let interactor = TutorialInteractor(
			presenter: presenter,
			worker: worker,
			dataProcessingService: dataProcessingService
		)
		let router = TutorialRouter(transitionCoordinator: transitionCoordinator)
		viewController.interactor = interactor
		viewController.router = router
		
		let view = TutorialView(viewController: viewController)
		let hostingController = UIHostingController(rootView: view)
		viewController.hostingController = hostingController
		return hostingController
	}
}
