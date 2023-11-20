# Assembler & Container
A dependency manager and its container.

The Assembler includes a Container, which acts as a repository for storing dependencies, including scenes and services. Once the container registers these dependencies, they can be conveniently retrieved whenever necessary.

## How it works

### Registering and Resolving Modules from the Container

As mentioned earlier, all dependencies, such as scenes and services, will be registered with the container using the ``ContainerProtocol/register(_:name:module:)`` method.

```swift
container.register(
	TransitionCoordinatorProtocol.self,
	name: TransitionCoordinator.moduleName
) { _ in
	return TransitionCoordinator()
}
```

If you need to use any module, you can resolve it using the ``ResolverProtocol/resolve(_:name:)`` method.

```swift
let transitionCoordinator = try resolver.resolve(
	TransitionCoordinatorProtocol.self,
	name: TransitionCoordinator.moduleName
)
```

### Initializing ViewController from SceneModule

Each viewController is constructed by its corresponding ``SceneModuleProtocol`` through the ``SceneModuleProtocol/build(resolver:parameters:)`` method. This process involves resolving all the necessary dependencies using the injected resolver from the container. The resulting viewController is then returned from this function and can be subsequently utilized by the caller.

```swift
func build(
	resolver: ResolverProtocol, 
	parameters: [String: Any]
) throws -> UIViewController {
	// Resolving TransitionCoordinator from Container
	let transitionCoordinator = try resolver.resolve(
		TransitionCoordinatorProtocol.self,
		name: TransitionCoordinator.moduleName
	)
	
	// ViewController Initialization
	let viewController = ContentViewController()
	...
	return viewController
}
```

## Integration and usages

### Attaching RootViewController to presenting Window

To integrate this architecture into the project, we need to attach the created rootViewController to the currently presented window within the ``AssemblerProtocol/configure(window:)`` method. In order to create the rootViewController, the Assembler utilizes its ``AssemblerProtocol/resolver-5f2rv`` to resolve the rootViewController from the container mentioned in the <doc:#Initializing-ViewController-from-SceneModule> process.

```swift
func scene(
	_ scene: UIScene,
	willConnectTo session: UISceneSession,
	options connectionOptions: UIScene.ConnectionOptions
) {
	Assembler.assembler().configure(window: window)
}
```

```swift
func configure(window: UIWindow?) {
	guard let window else { return }
	windowManager.configureRootWindow(window: window)
	
	let viewController = try? resolver
	.resolve(
		SceneModuleProtocol.self,
		name: StartingSceneModule.moduleName
	)
	.build(resolver: resolver)
	window.rootViewController = viewController
}
```

![](assembler-overview-02)

### Navigate to Another Scene using TransitionCoordinator

All navigation processes will be managed by the <doc:Assembler-TransitionCoordinator>. Each viewController needs to resolve ``TransitionCoordinatorProtocol`` from the container during the initialization process.

When presenting scene wants to navigate to `StartingScene`, it simply needs to inform the resolved `transitionCoordinator` that it wants to transition to `StartingScene` using the ``TransitionCoordinatorProtocol/performNavigation(_:animated:completion:)`` method, and everything will be taken care of.

```swift
func presentStartingView() {
	transitionCoordinator?.performNavigation(
		NavigationType.present(
			sceneName: StartingSceneModule.moduleName,
			parameters: nil
		),
		animated: true,
		completion: nil
	)
}
```

>Important: `StartingScene` needs to be registered in the container to enable resolution for future usage.

![](assembler-overview-03)
