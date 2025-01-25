//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// MARK: 엔티티 이름을 initialDate -> initializedDate로 수정하고, 새로운 컬럼(priority)을 만들어서 기본값 medium을 집어 넣어보자.

import SwiftUI
import SwiftData

typealias Todo = SchemaVersion1_0_1.Todo

enum MigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [SchemaVersion1.self, SchemaVersion1_0_1.self]
    }
    static var stages: [MigrationStage] {
        [SchemaVersion1ToSchemaVersion1_0_1]
    }
    static let SchemaVersion1ToSchemaVersion1_0_1: MigrationStage = .lightweight(fromVersion: SchemaVersion1.self, toVersion: SchemaVersion1_0_1.self)
    
}

enum SchemaVersion1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Todo.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)
    
    @Model
    final class Todo {
        @Attribute(.unique) var id: UUID = UUID()
        var title: String
        var content: String
        var initialDate: Date
        var isCompleted: Bool
        
        init(title: String, content: String, initialDate: Date, isCompleted: Bool) {
            self.title = title
            self.content = content
            self.initialDate = initialDate
            self.isCompleted = isCompleted
        }
        
        
    }

}
enum SchemaVersion1_0_1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Todo.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 1)
    
    @Model
    final class Todo {
        @Attribute(.unique) var id: UUID = UUID()
        var title: String
        var content: String
        @Attribute(originalName: "initialDate")
        var initializedDate: Date
        var isCompleted: Bool
        var priority: Priority = Priority.medium
        
        init(title: String, content: String, initializedDate: Date, isCompleted: Bool, priority: Priority) {
            self.title = title
            self.content = content
            self.initializedDate = initializedDate
            self.isCompleted = isCompleted
            self.priority = priority
        }
        
        
    }

}

enum Priority: String, Codable {
    case high = "🔴"
    case medium = "🟡"
    case low = "🟢"
}





extension Todo {
    static func predicate(searchText: String) -> Predicate<Todo> {
        return #Predicate<Todo> { todo in
            (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
        }
    }
}
