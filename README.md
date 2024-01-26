# LiteralTypeInference

swift-syntax extension to infer types from expressions based on literal information.

<!-- # Badges -->

[![Github issues](https://img.shields.io/github/issues/p-x9/swift-literal-type-inference)](https://github.com/p-x9/swift-literal-type-inference/issues)
[![Github forks](https://img.shields.io/github/forks/p-x9/swift-literal-type-inference)](https://github.com/p-x9/swift-literal-type-inference/network/members)
[![Github stars](https://img.shields.io/github/stars/p-x9/swift-literal-type-inference)](https://github.com/p-x9/swift-literal-type-inference/stargazers)
[![Github top language](https://img.shields.io/github/languages/top/p-x9/swift-literal-type-inference)](https://github.com/p-x9/swift-literal-type-inference/)

## Usage

Implemented as an extension of the `ExprSyntaxProtocol`.

The type inferred from literal information can be obtained from the `inferredType` property.


```swift
import SwiftSyntax
import SwiftSyntaxBuilder
import LiteralTypeInference


let expr: ExprSyntax = """
[
    "item1": [
        (1, 2.0, "3", true),
        (1.0, 2, "7", false),
        (nil, nil, nil, false)
    ],
    "item2": [],
    "item3": [
        (1, 2, "3", true)
    ]
]
"""

// Get the type of expr from the `inferredType` property
let type = expr.inferredType

print(type?.expected?.formatted().description)
// => [String: [(Double?, Double?, String?, Bool)]]
```

## License
LiteralTypeInference is released under the MIT License. See [LICENSE](./LICENSE)
