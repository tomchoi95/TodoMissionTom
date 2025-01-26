//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// MARK: 마이그레이션

import SwiftUI
import SwiftData

typealias Todo = SchemaVersion1_0_2.Todo
typealias Category = SchemaVersion1_0_2.Category

enum MigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [SchemaVersion1.self, SchemaVersion1_0_1.self, SchemaVersion1_0_2.self]
    }
    static var stages: [MigrationStage] {
        [SchemaVersion1ToSchemaVersion1_0_1, SchemaVersion1_0_1ToSchemaVersion1_0_2]
    }
    static let SchemaVersion1ToSchemaVersion1_0_1: MigrationStage = .lightweight(
        fromVersion: SchemaVersion1.self,
        toVersion: SchemaVersion1_0_1.self)
    static let SchemaVersion1_0_1ToSchemaVersion1_0_2: MigrationStage = .lightweight(fromVersion: SchemaVersion1_0_1.self, toVersion: SchemaVersion1_0_2.self)
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
// initialDate -> initializedDate 속성 이름 변경 우선순위 추가
enum SchemaVersion1_0_1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Todo.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 1)
    
    @Model
    final class Todo {
        @Attribute(.unique)
        var id: UUID = UUID()
        var title: String
        var content: String
        @Attribute(originalName: "initialDate")
        var initializedDate: Date
        var isCompleted: Bool
        private var _priority: Int = 1
        @Transient
        var priority: Priority {
            get { Priority(rawValue: _priority)! }
            set { _priority = newValue.rawValue }
        }
        
        init(title: String, content: String, initializedDate: Date, isCompleted: Bool, priority: Priority) {
            self.title = title
            self.content = content
            self.initializedDate = initializedDate
            self.isCompleted = isCompleted
            self.priority = priority
        }
        
    }
    
}
enum SchemaVersion1_0_2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Todo.self, Category.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 0, 2)
    
    @Model
    final class Todo {
        @Attribute(.unique) var id: UUID = UUID()
        var title: String
        var content: String
        @Attribute(originalName: "initialDate")
        var initializedDate: Date
        var isCompleted: Bool
        private var _priority: Int = 1
        @Transient
        var priority: Priority {
            get { Priority(rawValue: _priority)! }
            set { _priority = newValue.rawValue }
        }
        @Relationship(deleteRule: .nullify, inverse: \Category.todos)
        var category: Category?
        
        init(title: String, content: String, initializedDate: Date, isCompleted: Bool, priority: Priority, category: Category?) {
            self.title = title
            self.content = content
            self.initializedDate = initializedDate
            self.isCompleted = isCompleted
            self.priority = priority
            self.category = category
        }
        
    }
    
    @Model
    final class Category {
        @Attribute(.unique)
        var title: String
        var todos: [Todo]? = []
        init(title: String) {
            self.title = title
        }
    }
    
}


enum Priority: Int, Codable {
    case high
    case medium
    case low
    
    var emoji: String {
        switch self {
        case .high: "🔴"
        case .medium: "🟡"
        case .low: "🟢"
        }
    }
}





extension Todo {
    static func predicate(searchText: String) -> Predicate<Todo> {
        return #Predicate<Todo> { todo in
            (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
        }
    }
}
