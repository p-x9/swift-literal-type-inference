//
//  DictionaryExprSyntax+inference.swift
//  
//
//  Created by p-x9 on 2024/01/25.
//  
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

extension DictionaryExprSyntax {
    var inferredKeyType: TypeSyntax? {
        guard case let .elements(elements) = self.content else {
            return nil
        }
        let expressions = elements.map(\.key)
        return expressions.inferredElementType
    }

    var inferredValueType: TypeSyntax? {
        guard case let .elements(elements) = self.content else {
            return nil
        }
        let expressions = elements.map(\.value)
        return expressions.inferredElementType
    }

    var inferredType: TypeSyntax? {
        guard let keyType = inferredKeyType,
              let valueType = inferredValueType else {
            return nil
        }
        return .init(
            DictionaryTypeSyntax(key: keyType, value: valueType)
        )
    }
}

extension Sequence where Element == DictionaryExprSyntax {
    var inferredElementType: TypeSyntax? {
        let dictionaries = self.filter { !$0.isElementsEmpty }
        let elementLists = dictionaries
            .map(\.content)
            .compactMap {
                if case let .elements(elements) = $0 {
                    return elements
                }
                return nil
            }
        guard elementLists.count == dictionaries.count else { return nil }

        let keys = elementLists.flatMap { $0.map(\.key) }
        let values = elementLists.flatMap { $0.map(\.value) }

        guard let keyType = keys.inferredElementType,
              let valueType = values.inferredElementType else {
            return nil
        }
        return .init(
            DictionaryTypeSyntax(key: keyType, value: valueType)
        )
    }
}
