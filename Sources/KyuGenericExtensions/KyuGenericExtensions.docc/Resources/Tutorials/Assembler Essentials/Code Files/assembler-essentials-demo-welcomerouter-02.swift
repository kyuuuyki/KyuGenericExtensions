protocol WelcomeRouterProtocol {
	func navigateToTutorialView()
}

struct WelcomeRouter: WelcomeRouterProtocol {
	let transitionCoordinator: TransitionCoordinatorProtocol
	
	func navigateToTutorialView() {
		transitionCoordinator.performNavigation(
			NavigationType.present(
				sceneName: TutorialSceneModule.moduleName,
				parameters: nil
			),
			animated: true,
			completion: nil
		)
	}
}
