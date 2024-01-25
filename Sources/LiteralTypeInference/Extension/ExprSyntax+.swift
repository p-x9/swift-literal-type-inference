//
//  ExprSyntax+.swift
//
//
//  Created by p-x9 on 2024/01/24.
//  
//

import Foundation
import SwiftSyntax

extension ExprSyntax {
    var isNil: Bool {
        kind == .nilLiteralExpr
    }
}

extension Sequence where Element == ExprSyntax {
    func allSatisfy(_ kind: SyntaxKind) -> Bool {
        allSatisfy { $0.kind == kind }
    }
}
