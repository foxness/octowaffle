//
//  Token.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

enum Token: Equatable {
    case number(Double)
    case operation(Operation)

//    case function(String)
//    case leftParen
//    case rightParen
}

enum Operation: Equatable {
    case subtraction
    case addition
    case multiplication
    case division
    //    case function(String)
    //    case leftParen
    //    case rightParen
}
