// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cheetos",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        // MARK: Core
        .library(
            name: "Cheetos",
            targets: ["Cheetos"]
        ),
        
        // MARK: Value
        .library(
            name: "Values",
            targets: ["Values"]
        )
    ],
    targets: [
        // MARK: Core
        .target(
            name: "Cheetos",
            dependencies: ["Values"]
        ),
        .testTarget(
            name: "CheetosTests",
            dependencies: ["Cheetos", "Values"]
        ),
        
        // MARK: Value
        .target(
            name: "Values"
        )
    ]
)
