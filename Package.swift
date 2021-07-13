// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RIBs-SwiftUI",
    platforms: [
        .iOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "RIBs-SwiftUI",
            targets: ["RIBs-SwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dehrom/Navigator.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "RIBs-SwiftUI",
            dependencies: ["Navigator"]),
    ],
    swiftLanguageVersions: [.v5]
)
