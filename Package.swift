// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LiteralTypeInference",
    products: [
        .library(
            name: "LiteralTypeInference",
            targets: ["LiteralTypeInference"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-syntax.git",
            from: "509.0.0"
        ),
    ],
    targets: [
        .target(
            name: "LiteralTypeInference",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax")
            ]
        ),
        .testTarget(
            name: "LiteralTypeInferenceTests",
            dependencies: [
                "LiteralTypeInference"
            ]
        ),
    ]
)
