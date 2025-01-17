//
//  File.swift
//  TodoMissionTom
//
//  Created by 최범수 on 2025-01-17.
//

import SwiftData
import Foundation

@Model
class Todo {
    var id: UUID
    var title: String
    var content: String
    var todoPriority: TodoPriority
    var upToDate: Date
    var latestUpdat: Date
    var category: Category
    var isDone: Bool
    
    init(title: String, content: String, todoPriority: TodoPriority , upToDate: Date, latestUpdat: Date, category: Category, isDone: Bool) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.todoPriority = todoPriority
        self.upToDate = upToDate
        self.latestUpdat = latestUpdat
        self.category = category
        self.isDone = isDone
    }
}

enum Category: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case work = "💼"
    case study = "📚"
    case personal = "🤫"
    case defaultcategory = "💡"
}


enum TodoPriority: String, CaseIterable, Identifiable, Codable {
    case low = "🟢"
    case medium = "🟡"
    case high = "🔴"
    
    var id: String { self.rawValue }
}
