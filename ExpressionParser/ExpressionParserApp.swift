//
//  ExpressionParserApp.swift
//  ExpressionParser
//
//  Created by River Deem on 2025-12-07.
//

import SwiftUI
import SwiftData

@main
struct ExpressionParserApp: App {
    
    @StateObject var thing = Thing(name: "thing")
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(thing)
        }
        .modelContainer(sharedModelContainer)
    }
}
