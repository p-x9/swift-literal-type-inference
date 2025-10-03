// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "LiteralTypeInference",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "LiteralTypeInference",
            targets: ["LiteralTypeInference"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-syntax.git",
            "509.0.0"..<"603.0.0"
        )
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
                "LiteralTypeInference",
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax")
            ]
        )
    ]
)
