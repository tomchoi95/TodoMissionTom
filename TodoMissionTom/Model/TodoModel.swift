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
    var isDone: Bool
    
    init(title: String, content: String, isDone: Bool) {
        self.title = title
        self.content = content
        self.initialTime = Date()
        self.latestUpdateTime = Date()
        self.isDone = isDone
    }
}

enum Priority {
    case high
    case middle
    case low
}
