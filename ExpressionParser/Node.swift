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
