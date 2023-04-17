// swift-tools-version:5.5
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
