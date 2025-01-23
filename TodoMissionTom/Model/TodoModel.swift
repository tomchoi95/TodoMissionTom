//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

// 모델에 필요한 것. ID, title, content, initialDate, isCompleted

import SwiftUI
import SwiftData

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
