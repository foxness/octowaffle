//
//  ContentView.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var result: String? = nil
    @State private var text: String = "1 + 12 * 3"
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Expression", text: $text)
                        .font(.system(size: 30, design: .monospaced))
                        .onSubmit {
                            calculateResult()
                        }
                    
                    Button("Parse") {
                        calculateResult()
                    }
                }
                
                Text(result ?? "No result")
                    .padding(30)
            }
            .frame(maxWidth: 700)
            .padding(50)
            .navigationTitle("Expression Parser")
        }
        .onAppear {
            calculateResult()
        }
    }
    
    private func calculateResult() {
        let calculated = ExpressionParser.parse(text)
        
        if let calculated {
            result = calculated
        } else {
            result = "Invalid Expression"
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
