// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppStorage",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppStorage",
            targets: ["AppStorage"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "AppData", path: "../Core/AppData")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppStorage",
            dependencies: ["AppData"]),
        .testTarget(
            name: "AppStorageTests",
            dependencies: ["AppStorage"])
    ]
)
