# Getting Started with Assembler

Integrate Modularization Management into Your Project.

## Overview

Essentially, the Assembler serves as the foundation for integrating various modules, transforming modularized projects into functional applications. Its primary purpose is to handle scenes and dependencies management.

The Assembler includes a Container, which acts as a repository for storing dependencies, including scenes and services. Once the container registers these dependencies, they can be conveniently retrieved whenever necessary.

![](assembler-overview)

## Before Starting

#### Registering and Resolving Modules from the Container

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
let transitionCoordinator = resolver.resolve(
	TransitionCoordinatorProtocol.self,
	name: TransitionCoordinator.moduleName
)
```

#### Initializing ViewController from SceneModule

Each viewController is constructed by its corresponding ``SceneModuleProtocol`` through the ``SceneModuleProtocol/build(resolver:parameters:)`` method. This process involves resolving all the necessary dependencies using the injected resolver from the container. The resulting viewController is then returned from this function and can be subsequently utilized by the caller.

```swift
func build(
	resolver: ResolverProtocol, 
	parameters: [String: Any]?
) -> UIViewController? {
	// Resolving TransitionCoordinator from Container
	guard let transitionCoordinator = resolver.resolve(
		TransitionCoordinatorProtocol.self,
		name: TransitionCoordinator.moduleName
	) else {
		return nil
	}
	
	// ViewController Initialization
	let viewController = ContentViewController()
	...
	return viewController
}
```

## Getting Started

#### Attaching RootViewController to presenting Window

To integrate this architecture into the project, we need to attach the created rootViewController to the currently presented window within the ``AssemblerProtocol/configure(window:)`` method. In order to create the rootViewController, the Assembler utilizes its ``AssemblerProtocol/resolver-5f2rv`` to resolve the rootViewController from the container mentioned in the "Initialize ViewController from SceneModule" process.

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
	guard let viewController = resolver.resolve(
		SceneModuleProtocol.self,
		name: StartingSceneModule.moduleName
	)?.build(resolver: resolver, parameters: nil)
	else {
		return
	}
	window?.rootViewController = viewController
}
```

#### Navigate to Another Scene using TransitionCoordinator

All navigation processes will be managed by the ``TransitionCoordinatorProtocol``. Each viewController needs to resolve this module from the container during the initialization process. 

When *SceneA* wants to navigate to *SceneB*, it simply needs to inform the resolved transitionCoordinator that it wants to transition to *SceneB* using the ``TransitionCoordinatorProtocol/performNavigation(_:animated:completion:)`` method, and everything will be taken care of. 

It's important to note that *SceneB* must be registered with the container in order to be resolved from the specific container mentioned.

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
