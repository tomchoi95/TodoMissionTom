//
//  TodoMissionTomApp.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftUI
import SwiftData

@main
struct TodoMissionTomApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self, Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) // 저장 함

        do {
            return try ModelContainer(for: schema,migrationPlan: MigrationPlan.self, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
