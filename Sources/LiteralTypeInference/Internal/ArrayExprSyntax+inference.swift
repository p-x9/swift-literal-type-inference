//
//  ArrayExprSyntax+inference.swift
//
//
//  Created by p-x9 on 2024/01/25.
//  
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension ArrayExprSyntax {
    var inferredElementType: TypeSyntax? {
        let expressions = elements.map(\.expression)
        return expressions.inferredElementType
    }

    var inferredType: TypeSyntax? {
        guard let elementType = inferredElementType else {
            return nil
        }
        return .init(
            ArrayTypeSyntax(element: elementType)
        )
    }
}

extension Sequence where Element == ArrayExprSyntax {
    var inferredElementType: TypeSyntax? {
        let expressions = self.flatMap { $0.elements.map(\.expression) }
        guard let type = expressions.inferredElementType else { return nil }
        return  .init(
            ArrayTypeSyntax(element: type)
        )
    }
}
