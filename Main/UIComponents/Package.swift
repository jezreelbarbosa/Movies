// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UIComponents",
            targets: ["UIComponents"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Common", path: "../Core/Common"),
        .package(url: "https://github.com/freshOS/Stevia.git", from: "5.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UIComponents",
            dependencies: ["Common", "Stevia"]),
        .testTarget(
            name: "UIComponentsTests",
            dependencies: ["UIComponents", "Common", "Stevia"])
    ]
)
