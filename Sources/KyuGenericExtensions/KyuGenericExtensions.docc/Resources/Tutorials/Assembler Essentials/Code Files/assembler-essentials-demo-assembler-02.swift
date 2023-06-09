public extension Assembler {
	func configureModules() {
		container.register(
			TransitionCoordinatorProtocol.self,
			name: TransitionCoordinator.moduleName
		) { _ in
			return TransitionCoordinator()
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: WelcomeSceneModule.moduleName
		) { _ in
			return WelcomeSceneModule()
		}
		
		container.register(
			SceneModuleProtocol.self,
			name: TutorialSceneModule.moduleName
		) { _ in
			return TutorialSceneModule()
		}
	}
}
