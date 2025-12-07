//
//  Thing.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

import SwiftUI
import Combine

class Thing: ObservableObject {
    
    @Published var isSelected: Bool = false
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
