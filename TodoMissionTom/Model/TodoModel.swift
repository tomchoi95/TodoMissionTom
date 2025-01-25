//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// MAKR: 데이터 마이그레이션 시작

import SwiftUI
import SwiftData

typealias Todo = TodoSchemaV1_1_1.Todo

enum TodoMigrationPlan:SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [TodoSchemaV1.self, TodoSchemaV1_0_1.self, TodoSchemaV1_1_1.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV1_0_1, migrateV1_0_1toV1_1_1]
    }
    
    static let migrateV1toV1_0_1 = MigrationStage.lightweight(fromVersion: TodoSchemaV1.self, toVersion: TodoSchemaV1_0_1.self)
    static let migrateV1_0_1toV1_1_1 = MigrationStage.custom(fromVersion: TodoSchemaV1_0_1.self, toVersion: TodoSchemaV1_1_1.self,
                                                             willMigrate: nil) { context in
        // 마이그레이션 된 데이터를 불러다가 전제 거시기를 바꿀거임.
        let Item = try? context.fetch(FetchDescriptor<TodoSchemaV1_1_1.Todo>())
        Item?.forEach({ item in
            item.priority = .high
        })
        try? context.save()
    }

}

enum TodoSchemaV1: VersionedSchema {
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
        
        static func predicate(searchText: String) -> Predicate<Todo> {
            return #Predicate<Todo> { todo in
                (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
            }
        }
    }
}
enum TodoSchemaV1_0_1: VersionedSchema {
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
        var initDate: Date
        var isCompleted: Bool
        
        init(title: String, content: String, initDate: Date, isCompleted: Bool) {
            self.title = title
            self.content = content
            self.initDate = initDate
            self.isCompleted = isCompleted
        }
        
        static func predicate(searchText: String) -> Predicate<Todo> {
            return #Predicate<Todo> { todo in
                (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
            }
        }
    }
}
enum TodoSchemaV1_1_1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Todo.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 1, 1)
    
    @Model
    final class Todo {
        @Attribute(.unique) var id: UUID = UUID()
        var title: String
        var content: String
        var initDate: Date
        var isCompleted: Bool
        var priority: Priority = Priority.medium
        
        init(title: String, content: String, initDate: Date, isCompleted: Bool) {
            self.title = title
            self.content = content
            self.initDate = initDate
            self.isCompleted = isCompleted
        }
        
        static func predicate(searchText: String) -> Predicate<Todo> {
            return #Predicate<Todo> { todo in
                (searchText.isEmpty || todo.title.localizedStandardContains(searchText) || todo.content.localizedStandardContains(searchText))
            }
        }
    }
}

enum Priority: String, Codable {
    case high = "🔴"
    case medium = "🟡"
    case low = "🟢"
}
