// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppNavigation",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppNavigation",
            targets: ["AppNavigation"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", from: "2.7.0"),
        .package(name: "MoviesGrid", path: "../Features/MoviesGrid"),
        .package(name: "FavoriteMovies", path: "../Features/FavoriteMovies")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppNavigation",
            dependencies: ["Swinject", "SwinjectAutoregistration", "MoviesGrid", "FavoriteMovies"]),
        .testTarget(
            name: "AppNavigationTests",
            dependencies: ["AppNavigation"])
    ]
)
