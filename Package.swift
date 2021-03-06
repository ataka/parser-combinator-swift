// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ParserCombinatorSwift",
    products: [
        .library(
            name: "ParserCombinatorSwift",
            targets: ["ParserCombinatorSwift"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "1.3.1"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.1"),
    ],
    targets: [
        .target(
            name: "ParserCombinatorSwift",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "ParserCombinatorSwiftTests",
            dependencies: ["ParserCombinatorSwift", "Quick", "Nimble"],
            path: "Tests"
        ),
    ]
)
