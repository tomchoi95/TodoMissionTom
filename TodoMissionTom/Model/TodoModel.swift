//
//  TodoModel.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-20.
//

import SwiftUI
import SwiftData

@Model
final class Todo {
    var title: String
    var content: String
    var initialTime: Date
    var latestUpdateTime: Date
    var dueDate: Date = Date() // 기능 추가 해야함.
    var priority: Priority
    var category: Category
    var isDone: Bool
    
    init(title: String, content: String, isDone: Bool, priority: Priority, category: Category) {
        self.title = title
        self.content = content
        self.initialTime = Date()
        self.latestUpdateTime = Date()
        self.isDone = isDone
        self.priority = priority
        self.category = category
    }
}

enum Priority: String, Identifiable, Codable, CaseIterable {
    var id: String { self.rawValue }
    
    case high = "high"
    case middle = "middle"
    case low = "low"
}

enum Category: String, Identifiable, Codable, CaseIterable {
    var id: String { self.rawValue }
    
    case `default`
    case work
    case personal
    case study
}


