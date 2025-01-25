//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// MARK: 엔티티 이름을 initialDate -> initializedDate로 수정하고, 새로운 컬럼(priority)을 만들어서 기본값 medium을 집어 넣어보자.

import SwiftUI
import SwiftData

enum SchemaVersion1

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
