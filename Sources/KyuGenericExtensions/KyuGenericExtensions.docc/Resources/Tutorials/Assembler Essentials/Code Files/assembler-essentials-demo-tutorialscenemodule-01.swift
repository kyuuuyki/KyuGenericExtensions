public struct TutorialSceneModule: SceneModuleProtocol {
	public static var moduleName: String = "AssemblerDemo.TutorialSceneModule"
	
	public func build(resolver: ResolverProtocol, parameters: [String: Any]) throws -> UIViewController {
		let transitionCoordinator = try resolver.resolve(
			TransitionCoordinatorProtocol.self,
			name: "AssemblerDemo.TransitionCoordinator"
		)
		
		let viewController = TutorialViewController()
		
		let worker = TutorialWorker()
		let presenter = TutorialPresenter(viewController: viewController)
		let interactor = TutorialInteractor(
			presenter: presenter,
			worker: worker
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
