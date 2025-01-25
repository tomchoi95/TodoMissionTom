//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// MAKR: 데이터 마이그레이션 시작

import SwiftUI
import SwiftData

typealias Todo = TodoSchemaV1_0_1.Todo

enum TodoMigrationPlan:SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [TodoSchemaV1.self, TodoSchemaV1_0_1.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: TodoSchemaV1.self, toVersion: TodoSchemaV1_0_1.self)
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
