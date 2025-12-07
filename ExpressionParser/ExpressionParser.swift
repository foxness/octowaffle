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
        return "Result was: \(tree)"
    }
    
    static func evaluate(_ expression: [Token?]) -> Double? {
        let tokens = expression.compactMap(\.self)
        if tokens.count != expression.count {
            return nil
        }
        
        return nil
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
