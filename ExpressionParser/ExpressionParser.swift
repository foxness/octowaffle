//
//  ExpressionParser.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

struct ExpressionParser {
    
    static func parse(_ expression: String) -> String? {
        let rawTokens = tokenize(expression)
        
        let tokens = rawTokens.compactMap(\.self)
        if tokens.count != rawTokens.count {
            return nil
        }
        
        let tree = treeify(tokens)
        let result = evaluate(tree: tree)
        return "Result was: \(tree) -> \(result)"
    }
    
    static func evaluate(tree: Value) -> Double {
        if case .number(let number) = tree {
            return number
        }
        
        if case .node(let node) = tree {
            let leftValue = evaluate(tree: node.children[0])
            let rightValue = evaluate(tree: node.children[1])
            
            switch node.operation {
            case .addition:
                return leftValue + rightValue
            case .subtraction:
                return leftValue - rightValue
            case .multiplication:
                return leftValue * rightValue
            case .division:
                return leftValue / rightValue
            }
        }
        
        fatalError("How did we get here?")
    }
    
    static func treeify(_ expression: [Token]) -> Value {
        if expression.count == 1 {
            if case .number(let number) = expression[0] {
                return .number(number)
            }
            
            fatalError("Unexpected token: \(expression[0])")
        }
        
        let numberRaw = expression[0]
        let operationRaw = expression[1]
        
        if case .number(let number) = numberRaw {
            if case .operation(let operation) = operationRaw {
                let remaining = expression.dropFirst(2)
                let subtree = treeify(Array(remaining))
                
                let node = Node(
                    operation: operation,
                    children: [.number(number), subtree]
                )
                
                return .node(node)
            }
        }
        
        fatalError("Unexpected tokens: \(numberRaw) and \(operationRaw)")
    }
    
    static func tokenize(_ expression: String) -> [Token?] {
        var result: [Token?] = []
        
        let split = expression.split(separator: " ")
        result = split.map { parseToken(String($0)) }
        print(split)
        
        return result
    }
    
    static func parseToken(_ token: String) -> Token? {
        switch token {
        case "+":
            return .operation(.addition)
        case "-":
            return .operation(.subtraction)
        case "*":
            return .operation(.multiplication)
        case "/":
            return .operation(.division)
        default:
            if let number = Double(token) {
                return .number(number)
            }
            
            return nil
        }
    }
}
