# TransitionCoordinator
A coordinating handler.

As mentioned in <doc:Assembler-Assembler>, scenes easily transition between each other by informing the TransitionCoordinator, which handles all coordination without requiring any extra steps from the scenes.

## Definitions and usages

There are two main types of navigation:

### Static Navigation Type

This is a straightforward form of navigation, encompassing actions like push, present, back, etc. The conditions for this type remain fixed and do not change under any circumstances. 

For example, pushing an InformationScene when tapping on the info button.

#### Present
Present the destination scene constructed with parameters on the presenting window.
```swift
transitionCoordinator.performNavigation(
	NavigationType.present(
		sceneName: StartingSceneModule.moduleName,
		parameters: nil
	),
	animated: true,
	completion: nil
)
```

#### Push
Push the destination scene, constructed with parameters, to the navigation controller on the presenting window. If there is no navigation controller, this operation will have no effect.
```swift
transitionCoordinator.performNavigation(
	NavigationType.push(
		sceneName: StartingSceneModule.moduleName,
		parameters: nil
	),
	animated: true,
	completion: nil
)
```

#### Present & Push
Present the destination scene, constructed with parameters, as the root view controller of a new navigation controller, disregarding the existing navigation controller on the presenting window.
```swift
transitionCoordinator.performNavigation(
	NavigationType.presentAndPush(
		sceneName: StartingSceneModule.moduleName,
		parameters: nil
	),
	animated: true,
	completion: nil
)
```

#### Back
Pop the scene from the navigation controller on the presenting window. If there is no navigation controller, this operation will dismiss the presenting view controller.
```swift
transitionCoordinator.performNavigation(
	NavigationType.back,
	animated: true,
	completion: nil
)
```

#### Reset
Reconfigure the assembler to a state similar to the application's initial opening.
```swift
transitionCoordinator.performNavigation(
	NavigationType.reset,
	animated: true,
	completion: nil
)
```

>Note: When generating a project using [KyuSwiftTemplates](https://github.com/kyuuuyki/KyuSwiftTemplates.git), these static NavigationTypes should be automatically generated.

### Dynamic Navigation Type

This navigation type is more adaptable, featuring coordination conditions that can be intricate and change based on the current situation. 

#### Conditional Navigation

This navigation type assesses the defined requirements of the destination before proceeding to navigate to it. It acts like a fence to your backyard that requires a key for access. However, if you already have the key, you can open it without needing any additional steps.

For example, consider the scenario of pushing the ProfileScene when the user is already logged in. If the user is not logged in, the navigation will push the LoginScene first and later proceed to the destination after a successful login.

![](assembler-transitioncoordinator-01)

```swift
// Router.swift
transitionCoordinator.performNavigation(
	NavigationType.present(
		sceneName: ProfileSceneModule.moduleName,
		parameters: nil
	),
	animated: true,
	completion: nil
)
```

```swift
// TransitionCoordinator.swift
...
case .present(let sceneName, let parameters):
	guard let viewController = try? resolveScene(
		sceneName: sceneName,
		parameters: parameters
	) else {
		return
	}
	
	// MARK: CONDITION STARTS
	if [destination scene require authenticated user only] && [user is not authenticated] {
		// Proceed with navigation after a successful login.
		var loginCompletion: (() -> Void) = {
			self.performNavigation(
				NavigationType.present(
					sceneName: sceneName,
					parameters: parameters
				),
				animated: animated,
				completion: completion
			)
		}
		
		// Navigate to the LoginScene and invoke the `loginCompletion` upon successful login.
		self.performNavigation(
			NavigationType.present(
				sceneName: LoginSceneModule.moduleName,
				parameters: [completion: loginCompletion]
			),
			animated: true,
			completion: nil
		)
		return
	}
	// MARK: CONDITION ENDS
	
	if let presentingViewController {
		presentingViewController.navigationController?.pushViewController(
			viewController,
			animated: animated
		)
	} else {
		presentingWindow?.rootViewController = viewController
	}
	
	completion?()
...
```

>Warning: Please be mindful of the potential ambiguity in the completion parameter. In each navigation type, there is a completion parameter that refers to the navigation completion, which is called when the navigation is complete. On the other hand, the navigation for SceneModule's parameters will be called after a specific action within the scene.

#### Custom Navigation
Unlike Conditional Navigation, this navigation type is commonly used in dynamically evolving flows where we don't know the destination in advance, making it challenging to determine predefined requirements. However, this navigation type offers greater flexibility than Conditional Navigation because it can be customized like a thread with its own conditions.

This flexibility is evident in more complex flows, such as creating a new shopping cart in an e-commerce application. This process involves steps like selecting the delivery method, choosing a delivery address, selecting a store, creating the cart, and finally navigating to the designated scene, which in this case is the StoreHomepageScene.

![](assembler-transitioncoordinator-02)

```swift
// Router.swift
transitionCoordinator.performNavigation(
	NavigationType.createNewCart(parameters: nil),
	animated: true,
	completion: nil
)
```

```swift
// TransitionCoordinator.swift
...
case .createNewCart(let parameters):
	let deliveryMethod = parameters["deliveryMethod"] as? DeliveryMethod
	let address = parameters["address"] as? Address
	let store = parameters["store"] as? Store
	let createNewCartCompletion = parameters["completion"] as? (() -> Void)
	
	// Delivery Method Selection
	guard let deliveryMethod else {
		navigateToDeliveryMethodSelectionView { deliveryMethod in
			var updatedParameters = parameters
			updatedParameters["deliveryMethod"] = deliveryMethod
			self.performNavigation(
				NavigationType.createNewCart(parameters: updatedParameters),
				animated: true,
				completion: nil
			)
		}
		return
	}
	
	// Delivery Address Selection
	guard let address else {
		navigateToDeliveryAddressSelectionView { address in
			var updatedParameters = parameters
			updatedParameters["address"] = address
			self.performNavigation(
				NavigationType.createNewCart(parameters: updatedParameters),
				animated: true,
				completion: nil
			)
		}
		return
	}
	
	// Store Selection
	guard let store else {
		navigateToStoreSelectionView { store in
			var updatedParameters = parameters
			updatedParameters["store"] = store
			self.performNavigation(
				NavigationType.createNewCart(parameters: updatedParameters),
				animated: true,
				completion: nil
			)
		}
		return
	}
	
	// Cart Creation
	navigateToCartCreationView(
		deliveryMethod: deliveryMethod,
		address: address,
		store: store
	) {
		if let createNewCartCompletion {
			createNewCartCompletion()
		} else {
			self.performNavigation(
				NavigationType.goToStoreHomepageScene,
				animated: true,
				completion: nil
			)
		}
	}
...
```

>Warning: Please be mindful of the potential ambiguity in the completion parameter. In each navigation type, there is a completion parameter that refers to the navigation completion, which is called when the navigation is complete. On the other hand, the navigation for SceneModule's parameters will be called after a specific action within the scene.

>Note: These dynamic navigation can be applied to various navigation types. You are free to customize the TransitionCoordinator and NavigationType as you see fit.
