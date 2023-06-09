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
		
		container.register(
			DataProcessingServiceProtocol.self,
			name: DataProcessingService.moduleName
		) { _ in
			return DataProcessingService()
		}
	}
}
