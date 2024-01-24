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
    targets: [
        .target(
            name: "LiteralTypeInference"
        ),
        .testTarget(
            name: "LiteralTypeInferenceTests",
            dependencies: [
                "LiteralTypeInference"
            ]
        ),
    ]
)
