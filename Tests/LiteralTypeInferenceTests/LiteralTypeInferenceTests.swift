import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@testable import LiteralTypeInference

final class LiteralTypeInferenceTests: XCTestCase {
    func testString() {
        checkInferredType(
            expr: """
            "hello"
            """,
            expected: "Swift.String"
        )

        checkInferredType(
            expr: """
            \"""
            hello
            \"""
            """,
            expected: "Swift.String"
        )
    }

    func testInt() {
        checkInferredType(
            expr: """
            123
            """,
            expected: "Swift.Int"
        )

        checkInferredType(
            expr: """
            100_000_000
            """,
            expected: "Swift.Int"
        )

        checkInferredType(
            expr: """
            0xFF
            """,
            expected: "Swift.Int"
        )
    }

    func testDouble() {
        checkInferredType(
            expr: """
            0.0
            """,
            expected: "Swift.Double"
        )

        checkInferredType(
            expr: """
            1e-2
            """,
            expected: "Swift.Double"
        )

        checkInferredType(
            expr: """
            0x01p-2
            """,
            expected: "Swift.Double"
        )
    }

    func testBool() {
        checkInferredType(
            expr: """
            true
            """,
            expected: "Swift.Bool"
        )

        checkInferredType(
            expr: """
            false
            """,
            expected: "Swift.Bool"
        )
    }
}

extension LiteralTypeInferenceTests {
    func testTuple() {
        checkInferredType(
            expr: """
            (1, 2.0, "3", true)
            """,
            expected: "(Swift.Int, Swift.Double, Swift.String, Swift.Bool)"
        )
    }
}

extension LiteralTypeInferenceTests {
    func testArray() {
        checkInferredType(
            expr: """
            [1, 2, 3]
            """,
            expected: "[Swift.Int]"
        )

        checkInferredType(
            expr: """
            [1.0, 2.0, 3.0]
            """,
            expected: "[Swift.Double]"
        )

        checkInferredType(
            expr: """
            [1, 2.0, 3]
            """,
            expected: "[Swift.Double]"
        )

        checkInferredType(
            expr: """
            [1, 2.0, 3, nil]
            """,
            expected: "[Swift.Double?]"
        )

        checkInferredType(
            expr: """
            [
                [[1], [2], [3]],
                [[], [2], [3.0]],
            ]
            """,
            expected: "[[[Swift.Double]]]"
        )

        checkInferredType(
            expr: """
            [
                [[], [], []],
                [[], [2], [3]],
            ]
            """,
            expected: "[[[Swift.Int]]]"
        )

        checkInferredType(
            expr: """
            [
                (1, 2.0, "3", true),
                (1.0, 2, "7", nil),
                (nil, nil, nil, false)
            ]
            """,
            expected: "[(Swift.Double?, Swift.Double?, Swift.String?, Swift.Bool?)]"
        )
    }
}

extension LiteralTypeInferenceTests {
    func testDictionary() {
        checkInferredType(
            expr: """
            [
                1: "1",
                2: "2",
                3: "3"
            ]
            """,
            expected: "[Swift.Int: Swift.String]"
        )

        checkInferredType(
            expr: """
            [
                1: [1: "1"],
                2: [2: nil],
                3: [3: "3"]
            ]
            """,
            expected: "[Swift.Int: [Swift.Int: Swift.String?]]"
        )

        checkInferredType(
            expr: """
            [
                1: [1: []],
                2: [2: [[]]],
                3: [3: [[1.0, 2]]]
            ]
            """,
            expected: "[Swift.Int: [Swift.Int: [[Swift.Double]]]]"
        )
    }
}

extension LiteralTypeInferenceTests {
    private func checkInferredType(
        expr: ExprSyntax,
        expected: TypeSyntax?
    ) {
        XCTAssertEqual(
            expr.inferredType?.formatted().description,
            expected?.description
        )
    }
}
