//
//  ExprSyntaxTests.swift
//
//
//  Created by p-x9 on 2024/01/24.
//  
//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder
@testable import LiteralTypeInference

final class ExprSyntaxTests: XCTestCase {}

extension ExprSyntaxTests {
    func testIsElementsEmptyArray() {
        checkIsElementsEmpty(
            expr: """
            []
            """,
            expected: true
        )

        checkIsElementsEmpty(
            expr: """
            [[[]]]
            """,
            expected: true
        )

        checkIsElementsEmpty(
            expr: """
            [[], [], [[[[]]]]]
            """,
            expected: true
        )

        checkIsElementsEmpty(
            expr: """
            [1]
            """,
            expected: false
        )

        checkIsElementsEmpty(
            expr: """
            [[[],[1]]]
            """,
            expected: false
        )

        checkIsElementsEmpty(
            expr: """
            [[], [], [[[[3]]]]]
            """,
            expected: false
        )

        checkIsElementsEmpty(
            expr: """
            [[1], [2,3,4], []]
            """,
            expected: false
        )
    }

    func testIsElementsEmptyDictionary() {
        checkIsElementsEmpty(
            expr: """
            [:]
            """,
            expected: true
        )

        checkIsElementsEmpty(
            expr: """
            ["a": 1]
            """,
            expected: false
        )
    }

    private func checkIsElementsEmpty(
        expr: ExprSyntax,
        expected: Bool
    ) {
        XCTAssertEqual(expr.isElementsEmpty, expected)
    }
}
