// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MoviesGrid",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MoviesGrid",
            targets: ["MoviesGrid"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Domain", path: "../Core/Domain"),
        .package(name: "UIComponents", path: "../Main/UIComponents")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MoviesGrid",
            dependencies: ["UIComponents", "Domain"]),
        .testTarget(
            name: "MoviesGridTests",
            dependencies: ["MoviesGrid"])
    ]
)
