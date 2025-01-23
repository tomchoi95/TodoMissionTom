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
    var id: UUID = UUID()
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
