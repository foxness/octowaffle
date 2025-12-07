//
//  Node.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

struct Node: Equatable {
    let operation: Operation
    let children: [Value]
}

enum Value: Equatable {
    case number(Double)
    case node(Node)
}

extension Value: CustomStringConvertible {
    var description: String {
        switch self {
        case let .number(number):
            return String(number)
        case let .node(node):
            return "\(node)"
        }
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        let operationSymbol: String
        switch operation {
        case .addition:
            operationSymbol = "+"
        case .subtraction:
            operationSymbol = "-"
        case .multiplication:
            operationSymbol = "*"
        case .division:
            operationSymbol = "/"
        }
        
        return "(\(children[0]) \(operationSymbol) \(children[1]))"
    }
}
