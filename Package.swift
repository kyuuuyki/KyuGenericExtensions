// swift-tools-version:5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "KyuGenericExtensions",
	platforms: [.iOS(.v13)],
	products: [
		.library(
			name: "KyuGenericExtensions",
			targets: ["KyuGenericExtensions"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.2.0"),
	],
	targets: [
		.target(
			name: "KyuGenericExtensions",
			dependencies: []),
		.testTarget(
			name: "KyuGenericExtensionsTests",
			dependencies: ["KyuGenericExtensions"]),
	]
)
